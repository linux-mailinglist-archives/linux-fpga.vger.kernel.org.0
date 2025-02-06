Return-Path: <linux-fpga+bounces-1040-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B051A29FAF
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 05:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21F17A3581
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 04:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB411632E6;
	Thu,  6 Feb 2025 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z3XLQvGe"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588C1662E7;
	Thu,  6 Feb 2025 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816318; cv=fail; b=KE+LtvPRKfjtftWbOm3+8zzJDB786MfgbINJ+iKnUiPGhaKVCYGNl9ty3sgcjr35kZSSI8rxkkEqvPlU0aE0Bri98N4qjnlpbr5mF0UIOkIRnblFYCdORk/Fc9JfTq5ifsZ6G3ukeG85v4a6Ro0L3ZxG+OZYzTjc3LtmHvz5J2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816318; c=relaxed/simple;
	bh=5CHB9BpXY4ZVJ4hC+A/H1FFwIeX0DHYWwtd9/Org7YI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iEj6M7AwH35zbFHm0tLZOJoq/IfJGvskyrHkhoG9hU79AWNa+tryvzkCfDhIJ2gjjwmF98avcRb9dKViwaJ5CAs7/kh0l5rVMPAlUlSiEM18b5RJStWwsCzRPOlsDF5BO+Ms6m5vm4T72JTY6O7spScAkIEe7ScWxubgB7N6jQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z3XLQvGe; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTieAeOJxXkG0fxiu0n32JuUVqnN6/scEQxXV3FWy834EQeuVCuoEwnpCseE/mfhG4rAP8Zh4axOCIjZFFrK2CnM0fbwzDd9RNNbZzryTAB6smsxrXq5RA6hgqA80wSDHIgxj78e5tcUbQHqDUOz5MncHZ2F8Y6MYlWFywtVdAekbvQGBdglFl0hZv6ZkMaGJybSGOHjivQfFu/IRQI6GKEU/gNxG3R4i7j6DppOZua48U3KEvXK7nBT1mG2xkFhRY61B1ZtLhv7SsL8vKGTJqnmSXC4ENfY5JTq6XgyJa3Ij1OtdNUclb1OHzix6UWdeVxeQzVdwxBcFdV/jugLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfw6ZvHdEYYDp/xqV+8K5CHGqDmtog4XlfDfjhJh0zM=;
 b=J3BaOgjmPq2HJtu0rSP3okM/UWUGA3UKEI5YIb7DDvI4VW7USf4h0cv/ZC8KRzjJ5DgeCMMAvGrq6hiX3vGsKEhEyWVI1qf8yEWRJ7cYgdf0gHr+Ds3CaB6fBHYtgTfJkAwe7dC4XlT/oBqPcq8IjyL5SZjgu3FrWHBtKHUFZinQi6uhovAYmVzZtsCZQLXmqmIu2BOOw2O6HQaJnOZ10AIoEp47ng7rbhxfPC5DIe5veTShEO3elA1Jp/1VawSOv04S1XFp5rvaQXwTV6Te/toaGIDWwr8biZmKA0bqHxh+ei2DYCakrZCnTnOzRVn2VqVWHH23JzqFFi94l3frCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfw6ZvHdEYYDp/xqV+8K5CHGqDmtog4XlfDfjhJh0zM=;
 b=z3XLQvGeuRrTp1ui6jSxw4E/jfwZcrcEk0JZEpyIzeehaVNaCfsNKFTdDf6FiivvGbswXbE4F6d+LKFxJW+xwlMxkVTM7mshd8/GZ/aSgDdsxAmeW0XI9lwoGLx3moXL+kr1REk+E4RlTO1ttWg0LsV0sJUAZ484DcZwhzMa5m8=
Received: from CH0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:610:11a::18)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 04:31:53 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::76) by CH0PR03CA0341.outlook.office365.com
 (2603:10b6:610:11a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 04:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 04:31:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 22:31:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 22:31:51 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 5 Feb 2025 22:31:50 -0600
Message-ID: <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
Date: Wed, 5 Feb 2025 20:31:50 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>, Hayden Laccabue
	<hayden.laccabue@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e5cc65-d398-4f04-cee9-08dd46672def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2FhYW9VK2RXaWJ3RVFFUFhSNEdpbCtQOURPd2dPSjIrR2M4dUNZVXV3WXZ3?=
 =?utf-8?B?azByVyt2TVdVSHN6dHg1V0pOZFBXTGtNNnoreE1icEduMlhncVg3S09QcHVy?=
 =?utf-8?B?VXhqVzh0b2RRMzRybGhzeUsycDJMZnExQ21VREFPWXBPdlNMbmZHU1RNamVV?=
 =?utf-8?B?cXQ0Nm5vblJJaHZvZng1NTVHSG8wSTBWblFDQ2ExMzhFQUZTTFJDS2FnaTdt?=
 =?utf-8?B?UG5PbVVrRWxTWWFtbGlVa09zNEd1WnhsV2tISkRFVjdYcFErMGlxek04SmpR?=
 =?utf-8?B?NGZQUzV6dTNSRmZkZXRxMGZPc3ptRHl5RHhHM25SNmZnSmc3YVQ1MDhBd3p3?=
 =?utf-8?B?UExycExpMjNHWXE4Wjd6K0JIbmNXUVhMQUtmOVl5d2NqdldzTEJnSFg3K3FQ?=
 =?utf-8?B?YjFvaHdob3c4OUdVak04VzQvR3hvK2F4ZWhGUXM0cnZXTWFMZXpDam96L1dq?=
 =?utf-8?B?Vkp6NzJvRDZ5MjluNlNEUkppYUZRS2tqcHQ0eEZRZTB3VkVGV1BWWCtGdTZ1?=
 =?utf-8?B?d3h6RENzbHRMWm9TZy93c2JjTnZzVVpZMmZiNTBNa2hXNG9ta1dOMlJ3Zkhh?=
 =?utf-8?B?bldEZWVRNThmUWE4a2k5ZDVkOXgzOTJWaG8reFRXSFVramhsdkYvMGlUdUV5?=
 =?utf-8?B?cmNybWFFS3BpLy9ZeXliSW5nM0dhcXdWRDlyZnNnR2QvL25oUzBJTE5yU0ZN?=
 =?utf-8?B?WDZHZEo3VnRpWVJKUVJvZlNnekM2TFhDRVZsSUNXWGZ3UWdLeW5FZHpRaU9u?=
 =?utf-8?B?d2g2elY2QVdMeHp1VVlkaXJDOUI1eVNVcy92T3B1ZVo3bHBPY0tYWXJXamc3?=
 =?utf-8?B?UWdRT0tvTFlNWmRLYkErb0k5U2szU3pDM1NheU9kM1dYaG9ydk9JYTUyL2g0?=
 =?utf-8?B?VThpN3lFNXBPdDdQLzZrdnFZK3BIQ2E0SVR5RE5MTmtUUzNqcUUxMkZ2YUlx?=
 =?utf-8?B?OTlOZzJPL0QxL3UvV0gvTDY0T0UyRC9KUUJPQnJZRFVqUXRYdmxjSksxOXQ4?=
 =?utf-8?B?UTBOZVBQMEJKZFZMTjlyNVNKbVk5b0Y3ZzRpL3BHa3Y0UytWQjEwTzEwVE4y?=
 =?utf-8?B?ODcrYkNPb0lMbHk1bW9GQ1U5ZW5WNSs1enRrL0UvaDFvSHhRK0tOL0ZSRkMy?=
 =?utf-8?B?cGhwTFZxSGtITE1JR0dtdmFDaDRHQzZoNUx6WVR2cmpoR0JiVmFEbWd6bUhK?=
 =?utf-8?B?NEU5bDk0c0F4U0pJeFlzRkJ0Y0JBNDhSa2hQSVJGQlJsZEU5ZndubGhVQ2pC?=
 =?utf-8?B?ZjVETVdnc1lsdUZUMWhTc2NZczZob2JLWmZQOFlEbWtjM1BPVHpTbVVvNERr?=
 =?utf-8?B?QVBoTEMyT3F4Y1YzalBjUTJBSWN2MnJSY2xkWDVISElMa0hIZ0I1cEtOYldq?=
 =?utf-8?B?WkZwZE1raUJKRkRkRDVOZklJamk4a2NqY0JlQ0RuM2REUjAvc2ZweCs1cER2?=
 =?utf-8?B?eDEwbFp0V3hMWFg5Vk1ybEU4ZDJwM3JjVE56am0yUk5VTysyNDVHUmpRYnRN?=
 =?utf-8?B?NjlFNE9HM3JuTzhwRkc0eEFQcEVJTllYSCtFNzByalZ3MU5Sbk5BT1QwMXhS?=
 =?utf-8?B?TWxCWlowL1pyc09oWXNCcG1oV3hjR1l0VFM4VmxRd2p5VHREK1o3OVRSYjY3?=
 =?utf-8?B?TzZTSmV4M1krUklVYU5EWEFmcGpZWWgwSjFCd3Q2UUgvTUxxUy9EZkFXemtJ?=
 =?utf-8?B?bnNFbWY4am52bEdlQjBNN0U1NUlTL0wvK2NCalRNd0VveDJkcWU5eGJqRDIy?=
 =?utf-8?B?Z251NUdFejVlVTVybzg4YkVxcWpQMzVzRlBwdjdHN2tGdXJyUjdPNTJ2WjNI?=
 =?utf-8?B?ejdFWXpMbjh2M09ra3dHdUpEOUkyYUxHb2dzNnBxd3FvSmphSHA3dEE1NWU2?=
 =?utf-8?B?TCtoMlB5OUo0Q0FBUDRDcnJjZ0JBTjRaUUMwL29qZUtJTjhUR3dzMGJxQWFZ?=
 =?utf-8?B?Y1RML2h0aG0rQzhxdGxoOWFSZFFUOU9CNERWandLcWVaS1pUejhRMmRQZU9Z?=
 =?utf-8?Q?aZulIX32pLU3LXf+d571oxXYRAdfo8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 04:31:52.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e5cc65-d398-4f04-cee9-08dd46672def
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839



On 2/5/25 20:15, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sun, Jan 26, 2025 at 11:46:54AM -0800, Yidong Zhang wrote:
>>
>>
>> On 1/26/25 02:32, Xu Yilun wrote:
>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On Tue, Dec 10, 2024 at 10:37:30AM -0800, Yidong Zhang wrote:
>>>> AMD Versal based PCIe card, including V70, is designed for AI inference
>>>> efficiency and is tuned for video analytics and natural language processing
>>>> applications.
>>>>
>>>> The driver architecture:
>>>>
>>>>     +---------+  Communication +---------+  Remote  +-----+------+
>>>>     |         |  Channel       |         |  Queue   |     |      |
>>>>     | User PF | <============> | Mgmt PF | <=======>| FW  | FPGA |
>>>>     +---------+                +---------+          +-----+------+
>>>>       PL Data                    base FW
>>>>                                  APU FW
>>>>                                  PL Data (copy)
>>>>    - PL (FPGA Program Logic)
>>>>    - FW (Firmware)
>>>>
>>>> There are 2 separate drivers from the original XRT[1] design.
>>>>    - UserPF driver
>>>>    - MgmtPF driver
>>>>
>>>> The new AMD versal-pci driver will replace the MgmtPF driver for Versal
>>>> PCIe card.
>>>>
>>>> The XRT[1] is already open-sourced. It includes solution of runtime for
>>>> many different type of PCIe Based cards. It also provides utilities for
>>>> managing and programming the devices.
>>>>
>>>> The AMD versal-pci stands for AMD Versal brand PCIe device management
>>>> driver. This driver provides the following functionalities:
>>>>
>>>>      - module and PCI device initialization
>>>>        this driver will attach to specific device id of V70 card;
>>>>        the driver will initialize itself based on bar resources for
>>>>        - communication channel:
>>>>          a hardware message service between mgmt PF and user PF
>>>>        - remote queue:
>>>>          a hardware queue based ring buffer service between mgmt PF and PCIe
>>>>          hardware firmware for programming FPGA Program Logic, loading
>>>>          firmware and checking card healthy status.
>>>>
>>>>      - programming FW
>>>>        - The base FW is downloaded onto the flash of the card.
>>>>        - The APU FW is downloaded once after a POR (power on reset).
>>>>        - Reloading the MgmtPF driver will not change any existing hardware.
>>>>
>>>>      - programming FPGA hardware binaries - PL Data
>>>>       - using fpga framework ops to support re-programing FPGA
>>>>       - the re-programming request will be initiated from the existing UserPF
>>>>         driver only, and the MgmtPF driver load the matched PL Data after
>>>>         receiving request from the communication channel. The matching PL
>>>
>>> I think this is not the way the FPGA generic framework should do. A FPGA
>>> region user (your userPF driver) should not also be the reprogram requester.
>>> The user driver cannot deal with the unexpected HW change if it happens.
>>> Maybe after reprogramming, the user driver cannot match the device
>>> anymore, and if user driver is still working on it, crash.
>>
>> One thing to clarify. The current design is:
>>
>> The userPF driver is the only requester. The mgmtPF has no uAPI to reprogram
>> the FPGA.
>>
>>
>>>
>>> The expected behavior is, the FPGA region removes user devices (thus
>>> detaches user drivers), does reprogramming, re-enumerates/rescans and
>>> matches new devices with new drivers. And I think that's what Nava is
>>> working on.
>>>
>>
>> Nava's work is different than our current design, our current design is:
>>
>> the separate userPF driver will detach all services before requesting to the
>> mgmtPF to program the FPGA, and after the programming is done, the userPF
>> will re-enumerate/rescan the matching new devices.
> 
> That's not align with the Device-Driver Model, A device driver should not
> re-enumerate/rescan a matching device.

Thanks! Yilun.

I will need to discuss this in my team. Our current userPF driver 
organize services (rom, sensor, msix, etc.) as platform driver and 
re-enumerate (online/offline) when there is a hardware change.


> 
>>
>> The mgmtPF is a util driver which is responsible for communicating with the
>> mgmtPF PCIe bar resources.
>>
>>
>>> BTW, AFAICS the expected flow is easier to implement for of-fpga-region,
>>> but harder for PCI devices. But I think that's the right direction and
>>> should try to work it out.
>>
>> Could I recap the suggested design if I understand that correctly...
>>
>> You are thinking that the mgmtPF (aka. versal-pci) driver should have a uAPI
> 
> This should be the unified fpga-region class uAPI.
> 
>> to trigger the FPGA re-programing; and using Nava's callback ops to detach
>> the separate userPF driver; after re-programing is done, re-attch the userPF
> 
> No need to detach a specific driver, remove all devices in the
> fpga-region. I imagine this could also be a generic flow for all PCI/e
> based FPGA cards.

I see your point. Is there an existing example in current fpga driver 
for PCI/e based cards?

We will need to talk to our management team and re-design our driver.
I think we have 2 approaches:
1) Align with linux fpga, having one driver for both userPF and mgmtPF; or
2) find a different location (maybe driver/misc) for the version-pci 
driver, because it is an utility driver, not need to be tied with fpga 
framework.

Please let me know you thoughts. Which way is acceptable by you.

Thanks,
David
> 
> Thanks,
> Yilun
> 
>> driver and allow the userPF driver re-enumerate all to match the new
>> hardware.
>>
>> I think my understanding is correct, it is doable.
>>
>> As long as we can keep our userPF driver as separate driver, the code change
>> won't be too big.
>>
>>>
>>> Thanks,
>>> Yilun

