#!/usr/bin/env python3
"""
Test Script for WhatsApp Number Reporter Simulator
==================================================

This script demonstrates the functionality of the WhatsApp Number Reporter Simulator
for educational and testing purposes.

Usage:
    python3 test_simulation.py
"""

import sys
import os
from whatsapp_number_reporter import WhatsAppReporterSimulator

def test_phone_validation():
    """Test phone number validation functionality"""
    print("🧪 Testing Phone Number Validation")
    print("=" * 40)
    
    simulator = WhatsAppReporterSimulator()
    
    test_numbers = [
        "+1234567890",      # Valid US number
        "+447911123456",    # Valid UK number
        "+919876543210",    # Valid Indian number
        "1234567890",       # Invalid (no country code)
        "+123",             # Invalid (too short)
        "+12345678901234567890",  # Invalid (too long)
        "abc123def",        # Invalid (contains letters)
        "",                 # Invalid (empty)
    ]
    
    for number in test_numbers:
        is_valid = simulator.validate_phone_number(number)
        status = "✅ Valid" if is_valid else "❌ Invalid"
        print(f"{number:20} -> {status}")
    
    print()

def test_report_reasons():
    """Test report reasons functionality"""
    print("🧪 Testing Report Reasons")
    print("=" * 40)
    
    simulator = WhatsAppReporterSimulator()
    
    print("Available report reasons:")
    for i, reason in enumerate(simulator.report_reasons, 1):
        print(f"  {i:2d}. {reason}")
    print()

def test_simulation_logic():
    """Test simulation logic without user input"""
    print("🧪 Testing Simulation Logic")
    print("=" * 40)
    
    simulator = WhatsAppReporterSimulator()
    
    # Test data
    test_inputs = {
        'phone_number': '+1234567890',
        'num_reports': 3,
        'reason': 'Spam or unwanted messages',
        'additional_details': 'Test simulation'
    }
    
    print(f"📞 Target: {test_inputs['phone_number']}")
    print(f"🔢 Reports: {test_inputs['num_reports']}")
    print(f"🎯 Reason: {test_inputs['reason']}")
    print()
    
    # Run simulation
    simulator.run_simulation(test_inputs)
    
    # Display logs
    print(f"\n📊 Generated {len(simulator.reports_log)} log entries")
    for i, report in enumerate(simulator.reports_log, 1):
        print(f"  {i}. {report['report_id']} - {report['status']}")

def test_logging():
    """Test logging functionality"""
    print("🧪 Testing Logging Functionality")
    print("=" * 40)
    
    simulator = WhatsAppReporterSimulator()
    
    # Add some test reports
    test_reports = [
        {
            'report_id': 'RPT_TEST_001',
            'phone_number': '+1234567890',
            'reason': 'Test reason 1',
            'timestamp': '2024-01-15T10:00:00',
            'status': 'SUCCESS',
            'additional_details': 'Test log 1'
        },
        {
            'report_id': 'RPT_TEST_002',
            'phone_number': '+9876543210',
            'reason': 'Test reason 2',
            'timestamp': '2024-01-15T10:01:00',
            'status': 'FAILED',
            'additional_details': 'Test log 2'
        }
    ]
    
    simulator.reports_log = test_reports
    
    # Test saving logs
    test_filename = 'test_simulation_log.json'
    simulator.save_logs(test_filename)
    
    # Check if file was created
    if os.path.exists(test_filename):
        print(f"✅ Log file created: {test_filename}")
        # Clean up
        os.remove(test_filename)
        print(f"🗑️  Test file cleaned up")
    else:
        print(f"❌ Log file creation failed")
    
    print()

def run_all_tests():
    """Run all test functions"""
    print("🚀 WhatsApp Number Reporter Simulator - Test Suite")
    print("=" * 60)
    print("This test suite demonstrates the educational tool's functionality")
    print("All tests are simulations and do not interact with real services")
    print()
    
    try:
        test_phone_validation()
        test_report_reasons()
        test_simulation_logic()
        test_logging()
        
        print("🎉 All tests completed successfully!")
        print("\n📚 Educational Note:")
        print("This tool demonstrates cybersecurity concepts including:")
        print("• Input validation and sanitization")
        print("• API simulation and rate limiting")
        print("• Logging and audit trails")
        print("• Error handling and user feedback")
        print("• Anti-abuse system design principles")
        
    except Exception as e:
        print(f"❌ Test failed with error: {e}")
        return False
    
    return True

if __name__ == "__main__":
    success = run_all_tests()
    sys.exit(0 if success else 1)
