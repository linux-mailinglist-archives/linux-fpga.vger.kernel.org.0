Return-Path: <linux-fpga+bounces-930-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBF9C4BA1
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Nov 2024 02:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A852847DD
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Nov 2024 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A0820494D;
	Tue, 12 Nov 2024 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vGvBqidX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B821E884;
	Tue, 12 Nov 2024 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374577; cv=fail; b=BMzhjfAdDz5siUXXJ+H5sdoRvUGGEvCV28GWEA/gAj/9JIDP4G8BWQ0Kmx8XYIKT1wopg0Nib0+3q2YhbtNLzx8eUKbfaC3MAmE2u2GvEh/ppWSA8uiw9andYANO2PZkoPPM9Spw+ln7EehM8o98xkMdatvOEbfEkwvIWWoM7h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374577; c=relaxed/simple;
	bh=dl7Sbrhqr8BQxwUUghZGJma7QwSe7V4HDXdJUUuU+0o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=pL1xn8sGHxPb9ilmKPRTLOjuennDKGZzX1kF1hKgG0F31tCRi6MZ3zygMATBqRiKqapqZSMZTn9D7eH+FsllW1Inbl0+Q0twj8D+ULRPPeCU4hNODVOn7L654+obnvPv3P889FwLtKBMh36o9MLnTpiJ2QiaHPztmFrCiD3PQhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vGvBqidX; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kN1T6nlzoTDQ08nB0LqYJtg/OmqntBrRIgULGNgIpLWURjAYeorOW4fr/kUHfz5Z9dfp/zClFl2ioxrlQvET2npaON4TVGW1BFbshG9gDaZ0bgz0zwhISj/dnIXc/FdSKoYTIcrDbTebd/Bvk5kcR8Wo6SajQC3659VE7i7z8Sqfn0c24H20+jKmzOYo1vQG+afe0WUJdGv9bzhPBYi3wuOHDCGW4kApIpCVlrxLaaf9tcXCDliGit/NVQ8v8VHFmmeQ4MPRgem3ByPII5YHEKwg0wXXYukyP98U1OLOZT6U5hZuwpbzBmh/KswpipKnwL3G8P0e8mDtJWR4pz2ZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2s52ezsG+Ws4M5C/yA4k68aDZA5FG0Kx5aUAEd4YUQ=;
 b=mSNk997xVOG1gm59sbAiB89nVpVkC7CNUf4muXmiCCfhYXFxm6MCVUXnEZ8gTZOLrhF4Hzlawh/hyhJxFtl3tfZ1EXqgheBkIQV778t3eTa2ir/lldGTATTkHZ+Vx+0IFUhTrYZPRfBA9cNmd4hSzdNIiM5VB22YgxwX8w8h0vH4/ZD/mwtgKPu1HZU73VL1n9LER+g5Z+fCoiTcjhbaR+mXO7EiJh9GhoYKCInFeMbFcBGgAe/lP6pJjA3CE3FY3h3k3eaD9V0/21yGqB9iPc5aW6dgmea3ApQLteu15XmRnlbphjrKLBBho9cfM2GQaMhFaYTF/1wjqmg6C3skOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2s52ezsG+Ws4M5C/yA4k68aDZA5FG0Kx5aUAEd4YUQ=;
 b=vGvBqidX6EhDyyppsBicA9MWqK9lwW3fwnlPc7pB33zkB+pspMaUmVRQyI9XYitoK6NBtLlCFIdgKBWI1SJgamFlM/SdkJwieKmqNyJ3r9e1rb+wop8RhnPPsqliTuaigYiy9DA/cGnQhuHJGKqYG6QN9fZWoHORNWQW7j8BaCY=
Received: from BN9PR03CA0399.namprd03.prod.outlook.com (2603:10b6:408:111::14)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 01:22:48 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::e) by BN9PR03CA0399.outlook.office365.com
 (2603:10b6:408:111::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 01:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 01:22:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 19:22:47 -0600
Received: from [172.19.74.143] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 19:22:46 -0600
Message-ID: <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
Date: Mon, 11 Nov 2024 17:22:41 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yidong Zhang <yidong.zhang@amd.com>
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<lizhi.hou@amd.com>, DMG Karthik <Karthik.DMG@amd.com>, Nishad Saraf
	<nishads@amd.com>, Prapul Krishnamurthy <prapulk@amd.com>,
	<yidong.zhang@amd.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d67a9ff-7701-4706-3799-08dd02b884ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWFsOG9XOWJHVDlTb2NMSkF1NWpVTFVNcEVYKzNiU2tlQmtuZUxGck85K3RW?=
 =?utf-8?B?S1hjZUtTaHJqSUtrM3FHSkNQVFZQS1lEMEVoUVMxZFNydVhhRUdDZWYwK0hs?=
 =?utf-8?B?NG9EekREeFlpVDhCWEFMWWlUYjRYa2hZQUNiZCtGblYxOGdPbmJIQi9KMjh1?=
 =?utf-8?B?cU9sSE9jM3czVnFKbnpVRlFTU1RRTGtXb2o5YXd2RmVKY3BPYmx0dzNkRmdH?=
 =?utf-8?B?RGtkbnZiWlU2RVNrdTFHVVJsZE5nS3RYejFrdCtnN1hWcENOcE94WlNOS3Y4?=
 =?utf-8?B?ZmRRa2dnelVXWHBjM3BGaVYwQjF6bXd0QTI4R3NHKzhhRFBUaUJsRDZXOHJn?=
 =?utf-8?B?b3VvNmdBSTJRZGppMGd4SWN6WGVBQm9iM2g2bVZzc3FOZkdYMVFLTWhwbmsr?=
 =?utf-8?B?aTBzQUF0bWl0QUtsY29CeUo4dERwMnphQXNrOUhMR1c4MWRmaHM3SktJK1Fl?=
 =?utf-8?B?cklXU3IvSmtFRTdYMUUyd0tzdTBMV0c3S28rblB2eFJhTjRETjNKWTRKc3hZ?=
 =?utf-8?B?TkQwMjI2WjFINlZKcm9jSUxUZ0lYZ2xIS28rdElFVXZ2OWpXMHY0VzFjTldP?=
 =?utf-8?B?ektDY3NsNWE4RCtDUWNUc0F3SzVzQ2lETmR2SEVYUm5FRHROK3IyNnBKZjNp?=
 =?utf-8?B?SkhlOFAreUNOcEFTOHZxdXYyY3BwbzY4Uk1GVE1tUGVGN09zU1dtWmVxUVhi?=
 =?utf-8?B?TFpHRDlCUjNzUE1OdGxocHpTQkpxWlRLKzY4R3ZDVGdZem02dURZTFQrcm9W?=
 =?utf-8?B?REdZNEhDS01kTXYxdGliVUxTSHRJaGZReUkzWmFBeWlSZS9EbUZLTGJLMTdY?=
 =?utf-8?B?WUNGTzBHa24xY3BTd0NDelRlVzJ2KzB5bTdBYThaUVZVZnI1dzFjbXdjUk8z?=
 =?utf-8?B?djVWejdGZjFHOXNpbXZWQWZRVXcvcWhxejJwWWdtZnUyaXlFTU85ZlRDaWpP?=
 =?utf-8?B?ZFEwVThjK0oxN2J1R2xnZWEydDg5WTh0aWxxbmdwZFp4SXNLbitkWWdTOXVK?=
 =?utf-8?B?K2hLWi90RXh3akxqUFdldDBRcm9ac0JsUkFuU3hWRUgvVE92b1ljS0VBV04r?=
 =?utf-8?B?dmhPczEyU0x6WGtmcWtxMXdJMDJYbGk4U3NKWElreTQxbUY4MVJERCt4TjNa?=
 =?utf-8?B?QkhZWkkxc0VvS1VzT2IrcUhSVTAyMms4SW4yMmdiY25CakpTSXBKdDN1T0J3?=
 =?utf-8?B?VFlnMUpXeUxrMlZ6UnV6cHdXa2hudU1xWVg4RkpEYkw2Z2ZJYVZSWnUrelJP?=
 =?utf-8?B?dW9DbWV2TmVGRzZzbFYwYmpYdVFISyt4TXRRYkxNOVcwUGpZdnozUHVVSGhw?=
 =?utf-8?B?WHRFcmdPY0N0a2laR0xUdzZ3dmhaNzB0eTRacEo2eUVaa2k2ZjdVczhETkNl?=
 =?utf-8?B?SG9nMmNuYnorRXBseDZlV0pHL1dmbkcwUnltc3JqcHdReUZmQXp3RXNhTXN2?=
 =?utf-8?B?akoycTIwTXZPeWxVak1OUE9YWVFKY3k3eU9oM1ArY0dwKzYrZk9XcDZub1lv?=
 =?utf-8?B?SjdXSTFBSDVWN0FOMGRkenl0a1NqL0tjZkJoSjJua3NubjJNS0d4YndEVm1D?=
 =?utf-8?B?V2hMZkRhYXphbkE2U1E1c0NwYzhYMTQ3bGtGZlBIVlRRMzVZa3dBNzdkZk9L?=
 =?utf-8?B?SEJhMHgwYXJXL2xvREt6cEg2NFpseFlBcEtvZHdUTm9IbGZCeFBjL1N0Nk9t?=
 =?utf-8?B?b3BvclhndVhTWHdiMi9tVUJjdkxzdmFVUU15d1dZVWpWQkRGaTNXS3kvMUJt?=
 =?utf-8?B?cXRCMWxuSUExSCtWQm40VWJJZzgyL2N6QmZFY00zN2syQnZWMmxJQ0F5ajdB?=
 =?utf-8?B?N0lzS3lSU2xNZklsQ0tCT2h3Ly82M2pjcVAxbSs2ZzZDdW5DTjhYY1NGalFh?=
 =?utf-8?B?SWErN0hIS3lBNjFISkxvUWs5cGYrcU5xclVKRlY1SlZNbDg0RjIrRXlSY2R2?=
 =?utf-8?Q?xLrviQAfqGA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 01:22:48.1042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d67a9ff-7701-4706-3799-08dd02b884ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951



On 10/17/24 23:17, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Mon, Oct 07, 2024 at 03:01:26PM -0700, David Zhang wrote:
>> From: Yidong Zhang <yidong.zhang@amd.com>
>>
>> AMD Versal based PCIe card, including V70, is designed for AI inference
>> efficiency and is tuned for video analytics and natural language processing
>> applications.
>>
>> Add the driver to support AMD Versal card management physical function.
>> Only very basic functionalities are added.
> 
> I think this is not "basic" enough.  If possible please add your following
> functionalities one by one.

Thank you so much for the review. I added more info for each functions 
below.

> 
>>    - module and PCI device initialization
>>    - fpga framework ops callbacks
>>    - communication with user physical function
> 
> So IIUC this is a multifunction PCI device? Management PF & User PF?
> Next time please add some description about the architecture overview
> of this card, as well as how the SW stack is supposed to make the card
> work.
>

I would like to add the following info by next V2 patch:

The driver architecture picture:

   +---------+  Communication +---------+  Remote  +-----+------+
   |         |  Channel       |         |  Queue   |     |      |
   | User PF | <============> | Mgmt PF | <=======>| FW  | FPGA |
   +---------+                +---------+          +-----+------+
     PL Data                    base FW
                                APU FW
                                PL Data (copy)
  - PL (FPGA Program Logic)
  - FW (Firmware)

There are 2 separate drivers from the original XRT[1] design.
  - UserPF driver
  - MgmtPF driver

The new amd-vpci driver will replace the MgmtPF driver for Versal PCIe card.

The XRT[1] is already open-sourced. It includes solution of runtime for 
many different type of PCIe Based cards. It also provides utilities for
managing and programming the devices.

The amd-vpci stands for AMD Versal brand PCIe device management driver.
This driver provides the following functionalities:

    - module and PCI device initialization
      this driver will attach to specific device id of V70 card;
      the driver will initialize itself based on bar resources for
      - communication channel:
        a hardware message service between mgmt PF and user PF
      - remote queue:
        a hardware queue based ring buffer service between mgmt PF and
        PCIe hardware firmware for programing FPGA Program Logic.

    - programing FWs
      - The base FW is downloaded onto flash of the card.
      - The APU FW is downloaded once after a POR (power on reset).
      - Reloading the MgmtPF driver will not change any existing hardware.

    - programing FPGA hardware binaries - PL Data
     - using fpga framework ops to support re-programing FPGA
     - the re-programing request will be initiated from the existing
       UserPF driver only, and the MgmtPF driver load the same PL Data 
after receiving request from the communication channel.

[1] https://github.com/Xilinx/XRT/blob/master/README.rst

>>
>> Co-developed-by: DMG Karthik <Karthik.DMG@amd.com>
>> Signed-off-by: DMG Karthik <Karthik.DMG@amd.com>
>> Co-developed-by: Nishad Saraf <nishads@amd.com>
>> Signed-off-by: Nishad Saraf <nishads@amd.com>
>> Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
>> Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
>> Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
>> ---
>>   MAINTAINERS                    |   7 +
>>   drivers/fpga/Kconfig           |   3 +
>>   drivers/fpga/Makefile          |   3 +
>>   drivers/fpga/amd/Kconfig       |  17 ++
>>   drivers/fpga/amd/Makefile      |   6 +
>>   drivers/fpga/amd/vmgmt-comms.c | 344 ++++++++++++++++++++++++++++
>>   drivers/fpga/amd/vmgmt-comms.h |  14 ++
>>   drivers/fpga/amd/vmgmt.c       | 395 +++++++++++++++++++++++++++++++++
>>   drivers/fpga/amd/vmgmt.h       | 100 +++++++++
>>   include/uapi/linux/vmgmt.h     |  25 +++
>>   10 files changed, 914 insertions(+)
>>   create mode 100644 drivers/fpga/amd/Kconfig
>>   create mode 100644 drivers/fpga/amd/Makefile
>>   create mode 100644 drivers/fpga/amd/vmgmt-comms.c
>>   create mode 100644 drivers/fpga/amd/vmgmt-comms.h
>>   create mode 100644 drivers/fpga/amd/vmgmt.c
>>   create mode 100644 drivers/fpga/amd/vmgmt.h
>>   create mode 100644 include/uapi/linux/vmgmt.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a097afd76ded..645f00ccb342 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1185,6 +1185,13 @@ M:     Sanjay R Mehta <sanju.mehta@amd.com>
>>   S:   Maintained
>>   F:   drivers/spi/spi-amd.c
>>
>> +AMD VERSAL PCI DRIVER
>> +M:   Yidong Zhang <yidong.zhang@amd.com>
>> +L:   linux-fpga@vger.kernel.org
>> +S:   Supported
>> +F:   drivers/fpga/amd/
>> +F:   include/uapi/linux/vmgmt.h
>> +
>>   AMD XGBE DRIVER
>>   M:   "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
>>   L:   netdev@vger.kernel.org
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 37b35f58f0df..dce060a7bd8f 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -290,4 +290,7 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
>>
>>   source "drivers/fpga/tests/Kconfig"
>>
>> +# Driver files
>> +source "drivers/fpga/amd/Kconfig"
>> +
>>   endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index aeb89bb13517..5e8a3869f9a0 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -58,5 +58,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000) += dfl-n3000-nios.o
>>   # Drivers for FPGAs which implement DFL
>>   obj-$(CONFIG_FPGA_DFL_PCI)           += dfl-pci.o
>>
>> +# AMD PCIe Versal Management Driver
>> +obj-y                                        += amd/
>> +
>>   # KUnit tests
>>   obj-$(CONFIG_FPGA_KUNIT_TESTS)               += tests/
>> diff --git a/drivers/fpga/amd/Kconfig b/drivers/fpga/amd/Kconfig
>> new file mode 100644
>> index 000000000000..126bc579a333
>> --- /dev/null
>> +++ b/drivers/fpga/amd/Kconfig
>> @@ -0,0 +1,17 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config AMD_VERSAL_MGMT
>> +     tristate "AMD PCIe Versal Management Driver"
>> +     select FW_LOADER
>> +     select FW_UPLOAD
>> +     select REGMAP_MMIO
>> +     depends on FPGA_BRIDGE
>> +     depends on FPGA_REGION
>> +     depends on HAS_IOMEM
>> +     depends on PCI
>> +     help
>> +       AMD PCIe Versal Management Driver provides management services to
>> +       download firmware, program bitstream, collect sensor data, control
>> +       resets, and communicate with the User function.
>> +
>> +       If "M" is selected, the driver module will be amd-vmgmt.
>> diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
>> new file mode 100644
>> index 000000000000..3e4c6dd3b787
>> --- /dev/null
>> +++ b/drivers/fpga/amd/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
> 
> IMHO the naming vmgmt is hard to understand, any better idea?

The "v" stand for Versal. We would change to amd-vpci for Versal based 
pcie devices.

> 
>> +
>> +amd-vmgmt-$(CONFIG_AMD_VERSAL_MGMT)          := vmgmt.o      \
>> +                                                vmgmt-comms.o
>> diff --git a/drivers/fpga/amd/vmgmt-comms.c b/drivers/fpga/amd/vmgmt-comms.c
>> new file mode 100644
>> index 000000000000..bed0d369a744
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt-comms.c
>> @@ -0,0 +1,344 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pci.h>
>> +#include <linux/timer.h>
>> +#include <linux/uuid.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "vmgmt.h"
>> +#include "vmgmt-comms.h"
>> +
>> +#define COMMS_PROTOCOL_VERSION                       1
>> +#define COMMS_PCI_BAR_OFF                    0x2000000
>> +#define COMMS_TIMER                          (HZ / 10)
>> +#define COMMS_DATA_LEN                               16
>> +#define COMMS_DATA_TYPE_MASK                 GENMASK(7, 0)
>> +#define COMMS_DATA_EOM_MASK                  BIT(31)
>> +#define COMMS_MSG_END                                BIT(31)
>> +
>> +#define COMMS_REG_WRDATA_OFF                 0x0
>> +#define COMMS_REG_RDDATA_OFF                 0x8
>> +#define COMMS_REG_STATUS_OFF                 0x10
>> +#define COMMS_REG_ERROR_OFF                  0x14
>> +#define COMMS_REG_RIT_OFF                    0x1C
>> +#define COMMS_REG_IS_OFF                     0x20
>> +#define COMMS_REG_IE_OFF                     0x24
>> +#define COMMS_REG_CTRL_OFF                   0x2C
>> +#define COMMS_REGS_SIZE                              0x1000
>> +
>> +#define COMMS_IRQ_DISABLE_ALL                        0
>> +#define COMMS_IRQ_RECEIVE_ENABLE             BIT(1)
>> +#define COMMS_IRQ_CLEAR_ALL                  GENMASK(2, 0)
>> +#define COMMS_CLEAR_FIFO                     GENMASK(1, 0)
>> +#define COMMS_RECEIVE_THRESHOLD                      15
>> +
>> +enum comms_req_ops {
>> +     COMMS_REQ_OPS_UNKNOWN                   = 0,
>> +     COMMS_REQ_OPS_HOT_RESET                 = 5,
>> +     COMMS_REQ_OPS_GET_PROTOCOL_VERSION      = 19,
>> +     COMMS_REQ_OPS_GET_XCLBIN_UUID           = 20,
>> +     COMMS_REQ_OPS_MAX,
>> +};
>> +
>> +enum comms_msg_type {
>> +     COMMS_MSG_INVALID                       = 0,
>> +     COMMS_MSG_START                         = 2,
>> +     COMMS_MSG_BODY                          = 3,
>> +};
>> +
>> +enum comms_msg_service_type {
>> +     COMMS_MSG_SRV_RESPONSE                  = BIT(0),
>> +     COMMS_MSG_SRV_REQUEST                   = BIT(1),
>> +};
>> +
>> +struct comms_hw_msg {
>> +     struct {
>> +             u32             type;
>> +             u32             payload_size;
>> +     } header;
>> +     struct {
>> +             u64             id;
>> +             u32             flags;
>> +             u32             size;
>> +             u32             payload[COMMS_DATA_LEN - 6];
>> +     } body;
>> +} __packed;
>> +
>> +struct comms_srv_req {
>> +     u64                     flags;
>> +     u32                     opcode;
>> +     u32                     data[];
>> +};
>> +
>> +struct comms_srv_ver_resp {
>> +     u32                     version;
>> +};
>> +
>> +struct comms_srv_uuid_resp {
>> +     uuid_t                  uuid;
>> +};
>> +
>> +struct comms_msg {
>> +     u64                     id;
>> +     u32                     flags;
>> +     u32                     len;
>> +     u32                     bytes_read;
>> +     u32                     data[10];
>> +};
>> +
>> +struct comms_device {
>> +     struct vmgmt_device     *vdev;
>> +     struct regmap           *regmap;
>> +     struct timer_list       timer;
>> +     struct work_struct      work;
>> +};
>> +
>> +static bool comms_regmap_rd_regs(struct device *dev, unsigned int reg)
>> +{
>> +     switch (reg) {
>> +     case COMMS_REG_RDDATA_OFF:
>> +     case COMMS_REG_IS_OFF:
>> +             return true;
>> +     default:
>> +             return false;
>> +     }
>> +}
>> +
>> +static bool comms_regmap_wr_regs(struct device *dev, unsigned int reg)
>> +{
>> +     switch (reg) {
>> +     case COMMS_REG_WRDATA_OFF:
>> +     case COMMS_REG_IS_OFF:
>> +     case COMMS_REG_IE_OFF:
>> +     case COMMS_REG_CTRL_OFF:
>> +     case COMMS_REG_RIT_OFF:
>> +             return true;
>> +     default:
>> +             return false;
>> +     }
>> +}
>> +
>> +static bool comms_regmap_nir_regs(struct device *dev, unsigned int reg)
>> +{
>> +     switch (reg) {
>> +     case COMMS_REG_RDDATA_OFF:
>> +             return true;
>> +     default:
>> +             return false;
>> +     }
>> +}
>> +
>> +static const struct regmap_config comms_regmap_config = {
>> +     .name = "comms_config",
>> +     .reg_bits = 32,
>> +     .reg_stride = 4,
>> +     .val_bits = 32,
>> +     .readable_reg = comms_regmap_rd_regs,
>> +     .writeable_reg = comms_regmap_wr_regs,
>> +     .readable_noinc_reg = comms_regmap_nir_regs,
>> +};
>> +
>> +static inline struct comms_device *to_ccdev_work(struct work_struct *w)
>> +{
>> +     return container_of(w, struct comms_device, work);
>> +}
>> +
>> +static inline struct comms_device *to_ccdev_timer(struct timer_list *t)
>> +{
>> +     return container_of(t, struct comms_device, timer);
>> +}
>> +
>> +static u32 comms_set_uuid_resp(struct vmgmt_device *vdev, void *payload)
>> +{
>> +     struct comms_srv_uuid_resp *resp;
>> +     u32 resp_len = sizeof(*resp);
>> +
>> +     resp = (struct comms_srv_uuid_resp *)payload;
>> +     uuid_copy(&resp->uuid, &vdev->xclbin_uuid);
>> +     vmgmt_dbg(vdev, "xclbin UUID: %pUb", &resp->uuid);
>> +
>> +     return resp_len;
>> +}
>> +
>> +static u32 comms_set_protocol_resp(void *payload)
>> +{
>> +     struct comms_srv_ver_resp *resp = (struct comms_srv_ver_resp *)payload;
>> +     u32 resp_len = sizeof(*resp);
>> +
>> +     resp->version = COMMS_PROTOCOL_VERSION;
>> +
>> +     return sizeof(resp_len);
>> +}
>> +
>> +static void comms_send_response(struct comms_device *ccdev,
>> +                             struct comms_msg *msg)
>> +{
>> +     struct comms_srv_req *req = (struct comms_srv_req *)msg->data;
>> +     struct vmgmt_device *vdev = ccdev->vdev;
>> +     struct comms_hw_msg response = {0};
>> +     u32 size;
>> +     int ret;
>> +     u8 i;
>> +
>> +     switch (req->opcode) {
>> +     case COMMS_REQ_OPS_GET_PROTOCOL_VERSION:
>> +             size = comms_set_protocol_resp(response.body.payload);
>> +             break;
>> +     case COMMS_REQ_OPS_GET_XCLBIN_UUID:
>> +             size = comms_set_uuid_resp(vdev, response.body.payload);
>> +             break;
>> +     default:
>> +             vmgmt_err(vdev, "Unsupported request opcode: %d", req->opcode);
>> +             *response.body.payload = -1;
>> +             size = sizeof(int);
>> +     }
>> +
>> +     vmgmt_dbg(vdev, "Response opcode: %d", req->opcode);
>> +
>> +     response.header.type = COMMS_MSG_START | COMMS_MSG_END;
>> +     response.header.payload_size = size;
>> +
>> +     response.body.flags = COMMS_MSG_SRV_RESPONSE;
>> +     response.body.size = size;
>> +     response.body.id = msg->id;
>> +
>> +     for (i = 0; i < COMMS_DATA_LEN; i++) {
>> +             ret = regmap_write(ccdev->regmap, COMMS_REG_WRDATA_OFF, ((u32 *)&response)[i]);
>> +             if (ret < 0) {
>> +                     vmgmt_err(vdev, "regmap write failed: %d", ret);
>> +                     return;
>> +             }
>> +     }
>> +}
>> +
>> +#define STATUS_IS_READY(status) ((status) & BIT(1))
>> +#define STATUS_IS_ERROR(status) ((status) & BIT(2))
>> +
>> +static void comms_check_request(struct work_struct *w)
>> +{
>> +     struct comms_device *ccdev = to_ccdev_work(w);
>> +     u32 status = 0, request[COMMS_DATA_LEN] = {0};
>> +     struct comms_hw_msg *hw_msg;
>> +     struct comms_msg msg;
>> +     u8 type, eom;
>> +     int ret;
>> +     int i;
>> +
>> +     ret = regmap_read(ccdev->regmap, COMMS_REG_IS_OFF, &status);
>> +     if (ret) {
>> +             vmgmt_err(ccdev->vdev, "regmap read failed: %d", ret);
>> +             return;
>> +     }
>> +     if (!STATUS_IS_READY(status))
>> +             return;
>> +     if (STATUS_IS_ERROR(status)) {
>> +             vmgmt_err(ccdev->vdev, "An error has occurred with comms");
>> +             return;
>> +     }
>> +
>> +     /* ACK status */
>> +     regmap_write(ccdev->regmap, COMMS_REG_IS_OFF, status);
>> +
>> +     for (i = 0; i < COMMS_DATA_LEN; i++) {
>> +             if (regmap_read(ccdev->regmap, COMMS_REG_RDDATA_OFF, &request[i]) < 0) {
>> +                     vmgmt_err(ccdev->vdev, "regmap read failed");
>> +                     return;
>> +             }
>> +     }
>> +
>> +     hw_msg = (struct comms_hw_msg *)request;
>> +     type = FIELD_GET(COMMS_DATA_TYPE_MASK, hw_msg->header.type);
>> +     eom = FIELD_GET(COMMS_DATA_EOM_MASK, hw_msg->header.type);
>> +
>> +     /* Only support fixed size 64B messages */
>> +     if (!eom || type != COMMS_MSG_START) {
>> +             vmgmt_err(ccdev->vdev, "Unsupported message format or length");
>> +             return;
>> +     }
>> +
>> +     msg.flags = hw_msg->body.flags;
>> +     msg.len = hw_msg->body.size;
>> +     msg.id = hw_msg->body.id;
>> +
>> +     if (msg.flags != COMMS_MSG_SRV_REQUEST) {
>> +             vmgmt_err(ccdev->vdev, "Unsupported service request");
>> +             return;
>> +     }
>> +
>> +     if (hw_msg->body.size > sizeof(msg.data) * sizeof(msg.data[0])) {
>> +             vmgmt_err(ccdev->vdev, "msg is too big: %d", hw_msg->body.size);
>> +             return;
>> +     }
>> +     memcpy(msg.data, hw_msg->body.payload, hw_msg->body.size);
> 
> Why is the memcpy() necessary? I just see the data move from stack to
> stack, finally they will be released all.

Sure, I will fix this.

> 
>> +
>> +     /* Now decode and respond appropriately */
>> +     comms_send_response(ccdev, &msg);
>> +}
>> +
>> +static void comms_sched_work(struct timer_list *t)
>> +{
>> +     struct comms_device *ccdev = to_ccdev_timer(t);
>> +
>> +     /* Schedule a work in the general workqueue */
>> +     schedule_work(&ccdev->work);
>> +     /* Periodic timer */
>> +     mod_timer(&ccdev->timer, jiffies + COMMS_TIMER);
>> +}
>> +
>> +static void comms_config(struct comms_device *ccdev)
>> +{
>> +     /* Disable interrupts */
>> +     regmap_write(ccdev->regmap, COMMS_REG_IE_OFF, COMMS_IRQ_DISABLE_ALL);
>> +     /* Clear request and response FIFOs */
>> +     regmap_write(ccdev->regmap, COMMS_REG_CTRL_OFF, COMMS_CLEAR_FIFO);
>> +     /* Clear interrupts */
>> +     regmap_write(ccdev->regmap, COMMS_REG_IS_OFF, COMMS_IRQ_CLEAR_ALL);
>> +     /* Setup RIT reg */
>> +     regmap_write(ccdev->regmap, COMMS_REG_RIT_OFF, COMMS_RECEIVE_THRESHOLD);
>> +     /* Enable RIT interrupt */
>> +     regmap_write(ccdev->regmap, COMMS_REG_IE_OFF, COMMS_IRQ_RECEIVE_ENABLE);
>> +
>> +     /* Create and schedule timer to do recurring work */
>> +     INIT_WORK(&ccdev->work, &comms_check_request);
>> +     timer_setup(&ccdev->timer, &comms_sched_work, 0);
>> +     mod_timer(&ccdev->timer, jiffies + COMMS_TIMER);
> 
> Do we have to use raw timer+workqueue for a normal periodic task? Could
> delayed_work work for you?
> 
> And do we have to do endless periodic query? Couldn't the user PF driver
> trigger the service? Where is the user PF driver?

Current Versal based communication channel hardware does not support 
interrupt.

> 
>> +}
>> +
>> +void vmgmtm_comms_fini(struct comms_device *ccdev)
>> +{
>> +     /* First stop scheduling new work then cancel work */
>> +     del_timer_sync(&ccdev->timer);
>> +     cancel_work_sync(&ccdev->work);
>> +}
>> +
>> +struct comms_device *vmgmtm_comms_init(struct vmgmt_device *vdev)
> 
> So 'comms' means 'communication with user PF ', is it? I thought it was
> some common services at first, especially it is introduced in the first
> basic patch.
> 
> Any better name?

We can use comm_chan_* instead.

> 
>> +{
>> +     struct comms_device *ccdev;
>> +
>> +     ccdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*ccdev), GFP_KERNEL);
>> +     if (!ccdev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     ccdev->vdev = vdev;
>> +
>> +     ccdev->regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
>> +                                           vdev->tbl + COMMS_PCI_BAR_OFF,
>> +                                           &comms_regmap_config);
> 
> I'm not sure why a regmap is needed. All register accessing is within
> the same module/file, and I assume a base+offset is enough to position
> the register addr.

I thought the regmap is preferred. We can use some common APIs like 
regmap_bulk_*. The base+offset works too, then we will implement our own 
bulk_* functions. Please let me know.

> 
>> +     if (IS_ERR(ccdev->regmap)) {
>> +             vmgmt_err(vdev, "Comms regmap init failed");
>> +             return ERR_CAST(ccdev->regmap);
>> +     }
>> +
>> +     comms_config(ccdev);
>> +     return ccdev;
>> +}
>> diff --git a/drivers/fpga/amd/vmgmt-comms.h b/drivers/fpga/amd/vmgmt-comms.h
>> new file mode 100644
>> index 000000000000..0afb14c8bd32
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt-comms.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __VMGMT_COMMS_H
>> +#define __VMGMT_COMMS_H
>> +
>> +struct comms_device *vmgmtm_comms_init(struct vmgmt_device *vdev);
>> +void vmgmtm_comms_fini(struct comms_device *ccdev);
>> +
>> +#endif       /* __VMGMT_COMMS_H */
>> diff --git a/drivers/fpga/amd/vmgmt.c b/drivers/fpga/amd/vmgmt.c
>> new file mode 100644
>> index 000000000000..b72eff9e8bc0
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt.c
>> @@ -0,0 +1,395 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/device/class.h>
>> +#include <linux/err.h>
>> +#include <linux/firmware.h>
>> +#include <linux/fs.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/idr.h>
>> +#include <linux/kdev_t.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/types.h>
>> +#include <linux/uuid.h>
>> +#include <linux/vmgmt.h>
>> +
>> +#include "vmgmt.h"
>> +#include "vmgmt-comms.h"
>> +
>> +#define DRV_NAME                     "amd-vmgmt"
>> +#define CLASS_NAME                   DRV_NAME
>> +
>> +#define PCI_DEVICE_ID_V70PQ2         0x50B0
>> +#define VERSAL_XCLBIN_MAGIC_ID               "xclbin2"
>> +
>> +static DEFINE_IDA(vmgmt_dev_minor_ida);
>> +static dev_t vmgmt_devnode;
>> +struct class *vmgmt_class;
>> +static struct fpga_bridge_ops vmgmt_br_ops;
>> +
>> +struct vmgmt_fpga_region {
>> +     struct fpga_device *fdev;
>> +     uuid_t *uuid;
>> +};
>> +
>> +static inline struct vmgmt_device *vmgmt_inode_to_vdev(struct inode *inode)
>> +{
>> +     return (struct vmgmt_device *)container_of(inode->i_cdev, struct vmgmt_device, cdev);
>> +}
>> +
>> +static enum fpga_mgr_states vmgmt_fpga_state(struct fpga_manager *mgr)
>> +{
>> +     struct fpga_device *fdev = mgr->priv;
>> +
>> +     return fdev->state;
>> +}
>> +
>> +static const struct fpga_manager_ops vmgmt_fpga_ops = {
>> +     .state = vmgmt_fpga_state,
> 
> If you want to add a skeleton, then add all skeleton ops with no
> implementation. This makes me think the fpga_manager need .state() only.

Sure, I will fix this.

> 
>> +};
>> +
>> +static int vmgmt_get_bridges(struct fpga_region *region)
>> +{
>> +     struct fpga_device *fdev = region->priv;
>> +
>> +     return fpga_bridge_get_to_list(&fdev->vdev->pdev->dev, region->info,
>> +                                    &region->bridge_list);
>> +}
>> +
>> +static void vmgmt_fpga_fini(struct fpga_device *fdev)
>> +{
>> +     fpga_region_unregister(fdev->region);
>> +     fpga_bridge_unregister(fdev->bridge);
>> +     fpga_mgr_unregister(fdev->mgr);
>> +}
>> +
>> +static struct fpga_device *vmgmt_fpga_init(struct vmgmt_device *vdev)
>> +{
>> +     struct device *dev = &vdev->pdev->dev;
>> +     struct fpga_region_info region = { 0 };
>> +     struct fpga_manager_info info = { 0 };
>> +     struct fpga_device *fdev;
>> +     int ret;
>> +
>> +     fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
>> +     if (!fdev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     fdev->vdev = vdev;
>> +
>> +     info = (struct fpga_manager_info) {
>> +             .name = "AMD Versal FPGA Manager",
>> +             .mops = &vmgmt_fpga_ops,
>> +             .priv = fdev,
>> +     };
>> +
>> +     fdev->mgr = fpga_mgr_register_full(dev, &info);
>> +     if (IS_ERR(fdev->mgr)) {
>> +             ret = PTR_ERR(fdev->mgr);
>> +             vmgmt_err(vdev, "Failed to register FPGA manager, err %d", ret);
>> +             return ERR_PTR(ret);
>> +     }
>> +
>> +     /* create fgpa bridge, region for the base shell */
>> +     fdev->bridge = fpga_bridge_register(dev, "AMD Versal FPGA Bridge",
>> +                                         &vmgmt_br_ops, fdev);
> 
> I didn't find the br_ops anywhere in this patchset. So how to gate the
> FPGA region when it is being reprogrammed? What is the physical link
> between the FPGA region and outside visitors?

The FPGA region gate operation is done in the FW running in this PCIe 
card. The FW will "freeze" the gate before programing the PL. After 
downloading the new hardware. The FW will then "free" the gate.

No physical link between FPGA region and outside visitors, the FW 
handles all requests.

> 
>> +     if (IS_ERR(fdev->bridge)) {
>> +             vmgmt_err(vdev, "Failed to register FPGA bridge, err %ld",
>> +                       PTR_ERR(fdev->bridge));
>> +             ret = PTR_ERR(fdev->bridge);
>> +             goto unregister_fpga_mgr;
>> +     }
>> +
>> +     region = (struct fpga_region_info) {
>> +             .compat_id = (struct fpga_compat_id *)&vdev->intf_uuid,
>> +             .get_bridges = vmgmt_get_bridges,
>> +             .mgr = fdev->mgr,
>> +             .priv = fdev,
>> +     };
>> +
>> +     fdev->region = fpga_region_register_full(dev, &region);
> 
> I assume the fpga region represents the user PF, is it? If you
> reprogram the FPGA region, how does the user PF driver aware the HW is
> changing?

The HW changing request is always requested from the user PF driver. The 
user PF driver will make sure it is safe to change hardware. Then, the 
user PF driver notify the mgmt PF driver by a unique identify of the HW 
bitstream (PL Data).

The mgmt PF driver, the amd-vpci driver, will check the unique identify 
and then find the same PL Data from its local storage which is 
previously installed, and start downloading it.

> 
>> +     if (IS_ERR(fdev->region)) {
>> +             vmgmt_err(vdev, "Failed to register FPGA region, err %ld",
>> +                       PTR_ERR(fdev->region));
>> +             ret = PTR_ERR(fdev->region);
>> +             goto unregister_fpga_bridge;
>> +     }
>> +
>> +     return fdev;
>> +
>> +unregister_fpga_bridge:
>> +     fpga_bridge_unregister(fdev->bridge);
>> +
>> +unregister_fpga_mgr:
>> +     fpga_mgr_unregister(fdev->mgr);
>> +
>> +     return ERR_PTR(ret);
>> +}
>> +
>> +static int vmgmt_open(struct inode *inode, struct file *filep)
>> +{
>> +     struct vmgmt_device *vdev = vmgmt_inode_to_vdev(inode);
>> +
>> +     if (WARN_ON(!vdev))
>> +             return -ENODEV;
>> +
>> +     filep->private_data = vdev;
>> +
>> +     return 0;
>> +}
>> +
>> +static int vmgmt_release(struct inode *inode, struct file *filep)
>> +{
>> +     filep->private_data = NULL;
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct file_operations vmgmt_fops = {
>> +     .owner = THIS_MODULE,
>> +     .open = vmgmt_open,
>> +     .release = vmgmt_release,
>> +};
>> +
>> +static void vmgmt_chrdev_destroy(struct vmgmt_device *vdev)
>> +{
>> +     device_destroy(vmgmt_class, vdev->cdev.dev);
>> +     cdev_del(&vdev->cdev);
>> +     ida_free(&vmgmt_dev_minor_ida, vdev->minor);
>> +}
>> +
>> +static int vmgmt_chrdev_create(struct vmgmt_device *vdev)
>> +{
>> +     u32 devid;
>> +     int ret;
>> +
>> +     vdev->minor = ida_alloc(&vmgmt_dev_minor_ida, GFP_KERNEL);
>> +     if (vdev->minor < 0) {
>> +             vmgmt_err(vdev, "Failed to allocate chrdev ID");
>> +             return -ENODEV;
>> +     }
>> +
>> +     cdev_init(&vdev->cdev, &vmgmt_fops);
>> +
>> +     vdev->cdev.owner = THIS_MODULE;
>> +     vdev->cdev.dev = MKDEV(MAJOR(vmgmt_devnode), vdev->minor);
>> +     ret = cdev_add(&vdev->cdev, vdev->cdev.dev, 1);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to add char device: %d\n", ret);
>> +             ida_free(&vmgmt_dev_minor_ida, vdev->minor);
>> +             return -ENODEV;
>> +     }
>> +
>> +     devid = PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn);
>> +     vdev->device = device_create(vmgmt_class, &vdev->pdev->dev,
>> +                                  vdev->cdev.dev, NULL, "%s%x", DRV_NAME,
>> +                                  devid);
>> +     if (IS_ERR(vdev->device)) {
>> +             vmgmt_err(vdev, "Failed to create device: %ld\n",
>> +                       PTR_ERR(vdev->device));
>> +             cdev_del(&vdev->cdev);
>> +             ida_free(&vmgmt_dev_minor_ida, vdev->minor);
>> +             return -ENODEV;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void vmgmt_fw_cancel(struct fw_upload *fw_upload)
>> +{
>> +     struct firmware_device *fwdev = fw_upload->dd_handle;
>> +
>> +     vmgmt_warn(fwdev->vdev, "canceled");
>> +}
>> +
>> +static const struct fw_upload_ops vmgmt_fw_ops = {
>> +     .cancel = vmgmt_fw_cancel,
> 
> Same concern.
> 

I will add all ops.

>> +};
>> +
>> +static void vmgmt_fw_upload_fini(struct firmware_device *fwdev)
>> +{
>> +     firmware_upload_unregister(fwdev->fw);
>> +     kfree(fwdev->name);
>> +}
>> +
>> +static struct firmware_device *vmgmt_fw_upload_init(struct vmgmt_device *vdev)
>> +{
>> +     struct device *dev = &vdev->pdev->dev;
>> +     struct firmware_device *fwdev;
>> +     u32 devid;
>> +
>> +     fwdev = devm_kzalloc(dev, sizeof(*fwdev), GFP_KERNEL);
>> +     if (!fwdev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     devid = PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn);
>> +     fwdev->name = kasprintf(GFP_KERNEL, "%s%x", DRV_NAME, devid);
>> +     if (!fwdev->name)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     fwdev->fw = firmware_upload_register(THIS_MODULE, dev, fwdev->name,
>> +                                          &vmgmt_fw_ops, fwdev);
>> +     if (IS_ERR(fwdev->fw)) {
>> +             kfree(fwdev->name);
>> +             return ERR_CAST(fwdev->fw);
>> +     }
>> +
>> +     fwdev->vdev = vdev;
>> +
>> +     return fwdev;
>> +}
>> +
>> +static void vmgmt_device_teardown(struct vmgmt_device *vdev)
>> +{
>> +     vmgmt_fpga_fini(vdev->fdev);
>> +     vmgmt_fw_upload_fini(vdev->fwdev);
>> +     vmgmtm_comms_fini(vdev->ccdev);
>> +}
>> +
>> +static int vmgmt_device_setup(struct vmgmt_device *vdev)
>> +{
>> +     int ret;
>> +
>> +     vdev->fwdev = vmgmt_fw_upload_init(vdev);
>> +     if (IS_ERR(vdev->fwdev)) {
>> +             ret = PTR_ERR(vdev->fwdev);
>> +             vmgmt_err(vdev, "Failed to init FW uploader, err %d", ret);
>> +             goto done;
>> +     }
>> +
>> +     vdev->ccdev = vmgmtm_comms_init(vdev);
>> +     if (IS_ERR(vdev->ccdev)) {
>> +             ret = PTR_ERR(vdev->ccdev);
>> +             vmgmt_err(vdev, "Failed to init comms channel, err %d", ret);
>> +             goto upload_fini;
>> +     }
>> +
>> +     vdev->fdev = vmgmt_fpga_init(vdev);
>> +     if (IS_ERR(vdev->fdev)) {
>> +             ret = PTR_ERR(vdev->fdev);
>> +             vmgmt_err(vdev, "Failed to init FPGA maanger, err %d", ret);
>> +             goto comms_fini;
>> +     }
>> +
>> +     return 0;
>> +comms_fini:
>> +     vmgmtm_comms_fini(vdev->ccdev);
>> +upload_fini:
>> +     vmgmt_fw_upload_fini(vdev->fwdev);
>> +done:
>> +     return ret;
>> +}
>> +
>> +static void vmgmt_remove(struct pci_dev *pdev)
>> +{
>> +     struct vmgmt_device *vdev = pci_get_drvdata(pdev);
>> +
>> +     vmgmt_chrdev_destroy(vdev);
>> +     vmgmt_device_teardown(vdev);
>> +}
>> +
>> +static int vmgmt_probe(struct pci_dev *pdev,
>> +                    const struct pci_device_id *pdev_id)
>> +{
>> +     struct vmgmt_device *vdev;
>> +     int ret;
>> +
>> +     vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
>> +     if (!vdev)
>> +             return -ENOMEM;
>> +
>> +     pci_set_drvdata(pdev, vdev);
>> +     vdev->pdev = pdev;
>> +
>> +     ret = pcim_enable_device(pdev);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to enable device %d", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = pcim_iomap_regions(vdev->pdev, AMD_VMGMT_BAR_MASK, "amd-vmgmt");
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed iomap regions %d", ret);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     vdev->tbl = pcim_iomap_table(vdev->pdev)[AMD_VMGMT_BAR];
>> +     if (IS_ERR(vdev->tbl)) {
>> +             vmgmt_err(vdev, "Failed to map RM shared memory BAR%d", AMD_VMGMT_BAR);
>> +             return -ENOMEM;
>> +     }
> 
> Deprecating pcim_iomap_regions & pcim_iomap_table is WIP. FYI.
> 
>    https://lore.kernel.org/all/20241016094911.24818-5-pstanner@redhat.com/

Thanks! I will fix this.

> 
>> +
>> +     ret = vmgmt_device_setup(vdev);
>> +     if (ret) {
>> +             vmgmt_err(vdev, "Failed to setup Versal device %d", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = vmgmt_chrdev_create(vdev);
>> +     if (ret) {
>> +             vmgmt_device_teardown(vdev);
>> +             return ret;
>> +     }
>> +
>> +     vmgmt_dbg(vdev, "Successfully probed %s driver!", DRV_NAME);
>> +     return 0;
>> +}
>> +
>> +static const struct pci_device_id vmgmt_pci_ids[] = {
>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_V70PQ2), },
>> +     { 0 }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(pci, vmgmt_pci_ids);
>> +
>> +static struct pci_driver amd_vmgmt_driver = {
>> +     .name = DRV_NAME,
>> +     .id_table = vmgmt_pci_ids,
>> +     .probe = vmgmt_probe,
>> +     .remove = vmgmt_remove,
>> +};
>> +
>> +static int amd_vmgmt_init(void)
>> +{
>> +     int ret;
>> +
>> +     vmgmt_class = class_create(CLASS_NAME);
>> +     if (IS_ERR(vmgmt_class))
>> +             return PTR_ERR(vmgmt_class);
>> +
>> +     ret = alloc_chrdev_region(&vmgmt_devnode, 0, MINORMASK, DRV_NAME);
>> +     if (ret)
>> +             goto chr_err;
>> +
>> +     ret = pci_register_driver(&amd_vmgmt_driver);
>> +     if (ret)
>> +             goto pci_err;
>> +
>> +     return 0;
>> +
>> +pci_err:
>> +     unregister_chrdev_region(vmgmt_devnode, MINORMASK);
>> +chr_err:
>> +     class_destroy(vmgmt_class);
>> +     return ret;
>> +}
>> +
>> +static void amd_vmgmt_exit(void)
>> +{
>> +     pci_unregister_driver(&amd_vmgmt_driver);
>> +     unregister_chrdev_region(vmgmt_devnode, MINORMASK);
>> +     class_destroy(vmgmt_class);
>> +}
>> +
>> +module_init(amd_vmgmt_init);
>> +module_exit(amd_vmgmt_exit);
>> +
>> +MODULE_DESCRIPTION("AMD PCIe Versal Management Driver");
>> +MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/fpga/amd/vmgmt.h b/drivers/fpga/amd/vmgmt.h
>> new file mode 100644
>> index 000000000000..4dc8a43f825e
>> --- /dev/null
>> +++ b/drivers/fpga/amd/vmgmt.h
>> @@ -0,0 +1,100 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Driver for Versal PCIe device
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __VMGMT_H
>> +#define __VMGMT_H
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/list.h>
>> +#include <linux/firmware.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/fpga/fpga-region.h>
>> +#include <linux/pci.h>
>> +#include <linux/uuid.h>
>> +#include <linux/regmap.h>
>> +
>> +#define AMD_VMGMT_BAR                        0
>> +#define AMD_VMGMT_BAR_MASK           BIT(0)
>> +
>> +#define vmgmt_info(vdev, fmt, args...)                                       \
>> +     dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
>> +
>> +#define vmgmt_warn(vdev, fmt, args...)                                       \
>> +     dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
>> +
>> +#define vmgmt_err(vdev, fmt, args...)                                        \
>> +     dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
>> +
>> +#define vmgmt_dbg(vdev, fmt, args...)                                        \
>> +     dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
>> +
>> +struct vmgmt_device;
>> +struct comms_device;
>> +struct rm_cmd;
>> +
>> +struct axlf_header {
>> +     u64                             length;
>> +     unsigned char                   reserved1[24];
>> +     uuid_t                          rom_uuid;
>> +     unsigned char                   reserved2[64];
>> +     uuid_t                          uuid;
>> +     unsigned char                   reserved3[24];
>> +} __packed;
>> +
>> +struct axlf {
>> +     char                            magic[8];
>> +     unsigned char                   reserved[296];
>> +     struct axlf_header              header;
>> +} __packed;
>> +
>> +struct fw_tnx {
>> +     struct rm_cmd           *cmd;
>> +     int                     opcode;
>> +     int                     id;
>> +};
>> +
>> +struct fpga_device {
>> +     enum fpga_mgr_states    state;
>> +     struct fpga_manager     *mgr;
>> +     struct fpga_bridge      *bridge;
>> +     struct fpga_region      *region;
>> +     struct vmgmt_device     *vdev;
>> +     struct fw_tnx           fw;
>> +};
>> +
>> +struct firmware_device {
>> +     struct vmgmt_device     *vdev;
>> +     struct fw_upload        *fw;
>> +     char                    *name;
>> +     u32                     fw_name_id;
>> +     struct rm_cmd           *cmd;
>> +     int                     id;
>> +     uuid_t                  uuid;
>> +};
>> +
>> +struct vmgmt_device {
>> +     struct pci_dev          *pdev;
>> +
>> +     struct rm_device        *rdev;
>> +     struct comms_device     *ccdev;
>> +     struct fpga_device      *fdev;
>> +     struct firmware_device  *fwdev;
>> +     struct cdev             cdev;
>> +     struct device           *device;
>> +
>> +     int                     minor;
>> +     void __iomem            *tbl;
>> +     uuid_t                  xclbin_uuid;
>> +     uuid_t                  intf_uuid;
>> +
>> +     void                    *debugfs_root;
>> +};
>> +
>> +#endif       /* __VMGMT_H */
>> diff --git a/include/uapi/linux/vmgmt.h b/include/uapi/linux/vmgmt.h
>> new file mode 100644
>> index 000000000000..2269ceb5c131
>> --- /dev/null
>> +++ b/include/uapi/linux/vmgmt.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Header file for Versal PCIe device user API
>> + *
>> + * Copyright (C) 2024 AMD Corporation, Inc.
>> + */
>> +
>> +#ifndef _UAPI_LINUX_VMGMT_H
>> +#define _UAPI_LINUX_VMGMT_H
>> +
>> +#include <linux/ioctl.h>
>> +
>> +#define VERSAL_MGMT_MAGIC    0xB7
>> +#define VERSAL_MGMT_BASE     0
>> +
>> +/**
>> + * VERSAL_MGMT_LOAD_XCLBIN_IOCTL - Download XCLBIN to the device
>> + *
>> + * This IOCTL is used to download XCLBIN down to the device.
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +#define VERSAL_MGMT_LOAD_XCLBIN_IOCTL        _IOW(VERSAL_MGMT_MAGIC,         \
>> +                                          VERSAL_MGMT_BASE + 0, void *)
> 
> Many definitions are added in a batch but some are not used in this
> patch. Please reorganize the patches for easer review, even for first
> version.
> 
> Thanks,
> Yilun

Hi Yilun,

Thanks for taking your time, and yes for sure I will make each patch 
more self-contained.

Here is my thoughts on upcoming patches structure:
1st patch, adding driver probe and FPGA framework; the actual ops
of handling communication channel message and remote queue message
will present as no-op with comments.

2nd patch, adding the communication channel services
3rd patch, adding the remote queue services
4th patch, adding the callers of using the remote queue services

Thanks,
David

> 
>> +
>> +#endif /* _UAPI_LINUX_VMGMT_H */
>> --
>> 2.34.1
>>
>>

