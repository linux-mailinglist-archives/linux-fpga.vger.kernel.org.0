Return-Path: <linux-fpga+bounces-1012-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D4A1CE2E
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 20:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FBA1667EE
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 19:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7DB13C67E;
	Sun, 26 Jan 2025 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="If5MA2ga"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5728399;
	Sun, 26 Jan 2025 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737920822; cv=fail; b=p+HpfyBvPfdDYhccQojHIYuagaYLMX2IhiDp7ulHRf9WyWmDbpZLylAT3Vckvo+2jfan47ZCbT7PaDV9jSdi+Oc8CbOAPGzZbLmsxun4eQXtbD64tBTgVYm51zZoXma4SjJpd+XgVf/cjTqY2Uqj0trP3F/q5a8ILzlzZwZwMw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737920822; c=relaxed/simple;
	bh=JY68RrCS1zSx3d1CBVwJvgKpYpdHYkqTP/tZkNlDI+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rM7LGeRQ24uMVT8Rq3jWvg7vqSqhXtl4mbedp+YYjWGkr0RbzBqUdpx2tx5IIqY/zyvO/mksxx/a+FasCwktlMnU/rV4VN6LjKLN4fSvgLXw2a938LbkPRRnaz08VaEiWZnVYEnPES8jJaYzXRBfYlyNBNpYHrtd8lRZUHumrv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=If5MA2ga; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrGNl7UfTCh3oK81UqBfRdzobj8gjLxRFCD9uFr+mkuHfV+ctA35SSRpKxQrBr1pZq0B+UrYGtmX+lIhSC8p3tjMELGiq5anLVCVL3NN4RZm1rNGy8u1uJeGy89oeI6jLppxR6+NvU2JCUScx+uUAHD9kKarJm088W8fLsjEvNoYN935jsNAUyW77UqPp3oDEOhG3KbMb3exngCpqDe1nsdjDzqwVwBaTgAfoRgkakJ5+3E6A9jXG0pwUnxiDe/j5CbnK8VXoDlBRr0D1DeCGfMtWVfr4mUnAS6vxNiBN6sndEd4ApgQAibv0nxxSRpFkvcRqaJiaphKjATWAsYUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxO+NuGfb7pCyeL1L6K7VN6n30zL8HuvWIb9Xx978EQ=;
 b=fSRixNaztKOn9Mivbf7fBrQ8AsZfAs6lGWk4fMMN3VwhNYyby+lwMvv+Bvl1s/KFxyRpEuc+UUlxgS3ehjaYYQIShDGIXYCYg9N7zgcA7zCqYi5ouYqjMk/awuWytKfqf+IIgxlASKAVMAPugVKvhBjCCXZxgWOwPx1/fwoH8A+wp1JlhM/Fh6DoWhlYkDtDugD0/kkRfZrzu3JrPqLF2Rtu4no2zEueuhQ3x4iVEFSXlU/Xy5NBp1yzl8PWqiZUNGH2wYp4UTh7CEGm+Zmdhb86zlN86VFbkqofzQj/E/832R3dcL2voBaEK2jPZ3PR1AIRThbLRyePA5Y1j/6d9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxO+NuGfb7pCyeL1L6K7VN6n30zL8HuvWIb9Xx978EQ=;
 b=If5MA2gaslpNqyCzkOOT5l1pApVZL1/jfHKVvDqqXWcm3qVT3LuDV88oQTDCZblWqjThPpcd8HEa6VIsebxgLSzF6kFVlFhmkAess37cIp7DMbkH0KAvC15jR3pbmjFa10qqpk/khy+7kpnr4B2NLOvuIjui+EI0YOfp+XWrBNQ=
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Sun, 26 Jan
 2025 19:46:57 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::2c) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 19:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 19:46:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:46:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:46:55 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 26 Jan 2025 13:46:54 -0600
Message-ID: <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
Date: Sun, 26 Jan 2025 11:46:54 -0800
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
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e2c423-f960-44da-3d5e-08dd3e4230c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZmRTVGbk5GQUJwT2ZmMFI3Tjlld05PbFh5aUpzMk9JMjY4NmNtZTFrWEkv?=
 =?utf-8?B?UDFLdnNQaUdYalV2SWt2VHN5N2REUDV6WUtiQ1dpMVF4QmI4MHhiUWtEN25D?=
 =?utf-8?B?SE5FdmpBWkFHdXFlcGZOTFQxeTJkZCs0OHlXWlFCc2JLdVVJeElhRG1lZktI?=
 =?utf-8?B?TkRnVUxtOFR2YzRFYjIzQ2RHTHBPMktTTTlJbWVYSDVJeitLY3F1V1VvVFZF?=
 =?utf-8?B?ZDU2Tmxjc2dCdE56L0N0dnFQbWlNYnFyMzd0V0tSeVU4QTBmeklUK1FMRWwr?=
 =?utf-8?B?RlNIWUR0c0x2eEhjaTM2RGRWSUZ3ODdRZXVQT0dEanZmT0JxOGdXTXdobXY0?=
 =?utf-8?B?TWJ6QmJReEhhdkpDcGJHQnFnVHltdnBNdVd0M3VnK2hWSVJSbGZpWTdWbXdM?=
 =?utf-8?B?NmV6NTF3cnlUeVEyekRqRlE4WWhjNUpwN0RnOVN6cWI4Y0JFWEJNRzdnOWJR?=
 =?utf-8?B?VkhRbVNPNlVORHI4WGxVMnIxVkp3YjVLYmE1SC9ydmdkKytUdGJQdXEvaVpa?=
 =?utf-8?B?SmNyenNxTXRrZ0FrL2x0dDZjSzdBTFFBSHZhSHFzR0g3SDVwdHdxL2NXRnNW?=
 =?utf-8?B?Zytod1RYRDNhSEpaR2RvMEkzeXdEeHNYeG56S3R1RkpHOE02WS9zT0hCTCtn?=
 =?utf-8?B?eGc0YmlaOFg4Uy91b0t0azFIQS9LVTJOVkdFa2E3TDN2NnNzQnpjQVllbHo4?=
 =?utf-8?B?YWdJZTQwUzZETzY4MmtVS1BFcGtQWE5HMDB5WmpoTE9NcFd6cCsrbi9zODhL?=
 =?utf-8?B?MG5RNlRyT1ZrMmJXRFVNd3FTQ3pVRzlxTVk0bHg1K1Q1VDNPNmtyVi9mcktr?=
 =?utf-8?B?OHRRUFgyd3ZpRkFuT05zWXplaTNhOUVpREhwdlVyTmJMbVR1aXc2MVVvUFZX?=
 =?utf-8?B?dnhZR2tSUHl4UU9mRElrU3IvcStEdHpqMHphdVI0MU9EU0RHZVIybDd5NS9S?=
 =?utf-8?B?SWhyVzA3WVJkeFZXY0tqOHFMQmRucVVWbVQweW5kd1FNZDBXTWVXUzhMU0JI?=
 =?utf-8?B?LzBhcENOdEo4RnNSdWFaRHBIdlgxekh6VHYySGdncGwyeDR2SFFVL3NaTHhE?=
 =?utf-8?B?ektHNDNSaGE4VmdrZ3JYQlhORnNEem1UdXlMc2o2TXZpaE9zNCsydzU4S0s1?=
 =?utf-8?B?UDBiZCtuMllQTDY1MldleWdoaUgxbWE4TGRadU1IT0lMODZlZmZlaHNVdmdh?=
 =?utf-8?B?a1F3OHdrRHdLSTNZK2svenRYckhVSHpnUVVPR1c0WWRwVnRSUjJHVUFtT1lS?=
 =?utf-8?B?ckYrUEZLeW1rc0VKVS93UG1QelVNeWJMQklUcmpDeGN5L3BvNlROY0N1L29Z?=
 =?utf-8?B?ZHFoVWd3RjFOcm9ObE1nMDhqdnVqbEh4bnM5Q3VMeHcyTEhoQVJMbEVTUTU0?=
 =?utf-8?B?Qkk5QWlVeVh5VG9FaFdiRkIzektQclZIWUd1MENBR0ZaVHhMQ1hENFZVWmNj?=
 =?utf-8?B?QTh4dS9RODFidUdyVm5xdUtyMWlMSzJEcEtmZk15SlF6N1E2S1FBeGRGNUVP?=
 =?utf-8?B?S3VJc2xZQi8xWmJGUG5oaFZpNXdNd002eHM0eTViTGgvQzlqclBaeG9ZZVds?=
 =?utf-8?B?ZmpYRHhaV0w0VjduUXRYdWVhS3NJUWNwVkRsNVVGejlKWmlkVGttZE9XdkR6?=
 =?utf-8?B?d1hTNlNvY2l4TFhqWEo3di85dGpScmozeGxQOVpjMGZIS1RuN29LZEVrcE1Z?=
 =?utf-8?B?RGJDbmM0K0RNOThacDExYitjMDQvUTJVN2c3RGp5eVJPd0ZqSGw4U24yNWJr?=
 =?utf-8?B?VjR4L0lFa2VuaElrTUN5cUF6N1dCUC96eXNDREc1Z0hwMzRJWE9RN3JQTjFE?=
 =?utf-8?B?QnJQZXcrekpjclFaYUd6WDU3cTBSdmYyekRNQzhwMDd2c29SWXl3NE1abWtQ?=
 =?utf-8?B?VEdpUUZSZUZDRlVQOFM2QzFLVFNWVVpSSjBTSXhMbUZEcFN6RWRqcGZwUUFy?=
 =?utf-8?B?blhkZzFLdzZ3clNWblhyeXBZY3lUWDFyNi9DY3lISnEzM3ZzY0Q1STREMG1I?=
 =?utf-8?Q?bNf7ZdGJ7w5vLv5pxaLiozTBYD09Ec=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 19:46:56.1952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e2c423-f960-44da-3d5e-08dd3e4230c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869



On 1/26/25 02:32, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Dec 10, 2024 at 10:37:30AM -0800, Yidong Zhang wrote:
>> AMD Versal based PCIe card, including V70, is designed for AI inference
>> efficiency and is tuned for video analytics and natural language processing
>> applications.
>>
>> The driver architecture:
>>
>>    +---------+  Communication +---------+  Remote  +-----+------+
>>    |         |  Channel       |         |  Queue   |     |      |
>>    | User PF | <============> | Mgmt PF | <=======>| FW  | FPGA |
>>    +---------+                +---------+          +-----+------+
>>      PL Data                    base FW
>>                                 APU FW
>>                                 PL Data (copy)
>>   - PL (FPGA Program Logic)
>>   - FW (Firmware)
>>
>> There are 2 separate drivers from the original XRT[1] design.
>>   - UserPF driver
>>   - MgmtPF driver
>>
>> The new AMD versal-pci driver will replace the MgmtPF driver for Versal
>> PCIe card.
>>
>> The XRT[1] is already open-sourced. It includes solution of runtime for
>> many different type of PCIe Based cards. It also provides utilities for
>> managing and programming the devices.
>>
>> The AMD versal-pci stands for AMD Versal brand PCIe device management
>> driver. This driver provides the following functionalities:
>>
>>     - module and PCI device initialization
>>       this driver will attach to specific device id of V70 card;
>>       the driver will initialize itself based on bar resources for
>>       - communication channel:
>>         a hardware message service between mgmt PF and user PF
>>       - remote queue:
>>         a hardware queue based ring buffer service between mgmt PF and PCIe
>>         hardware firmware for programming FPGA Program Logic, loading
>>         firmware and checking card healthy status.
>>
>>     - programming FW
>>       - The base FW is downloaded onto the flash of the card.
>>       - The APU FW is downloaded once after a POR (power on reset).
>>       - Reloading the MgmtPF driver will not change any existing hardware.
>>
>>     - programming FPGA hardware binaries - PL Data
>>      - using fpga framework ops to support re-programing FPGA
>>      - the re-programming request will be initiated from the existing UserPF
>>        driver only, and the MgmtPF driver load the matched PL Data after
>>        receiving request from the communication channel. The matching PL
> 
> I think this is not the way the FPGA generic framework should do. A FPGA
> region user (your userPF driver) should not also be the reprogram requester.
> The user driver cannot deal with the unexpected HW change if it happens.
> Maybe after reprogramming, the user driver cannot match the device
> anymore, and if user driver is still working on it, crash.

One thing to clarify. The current design is:

The userPF driver is the only requester. The mgmtPF has no uAPI to 
reprogram the FPGA.


> 
> The expected behavior is, the FPGA region removes user devices (thus
> detaches user drivers), does reprogramming, re-enumerates/rescans and
> matches new devices with new drivers. And I think that's what Nava is
> working on.
> 

Nava's work is different than our current design, our current design is:

the separate userPF driver will detach all services before requesting to 
the mgmtPF to program the FPGA, and after the programming is done, the 
userPF will re-enumerate/rescan the matching new devices.

The mgmtPF is a util driver which is responsible for communicating with 
the mgmtPF PCIe bar resources.


> BTW, AFAICS the expected flow is easier to implement for of-fpga-region,
> but harder for PCI devices. But I think that's the right direction and
> should try to work it out.

Could I recap the suggested design if I understand that correctly...

You are thinking that the mgmtPF (aka. versal-pci) driver should have a 
uAPI to trigger the FPGA re-programing; and using Nava's callback ops to 
detach the separate userPF driver; after re-programing is done, re-attch 
the userPF driver and allow the userPF driver re-enumerate all to match 
the new hardware.

I think my understanding is correct, it is doable.

As long as we can keep our userPF driver as separate driver, the code 
change won't be too big.

> 
> Thanks,
> Yilun

