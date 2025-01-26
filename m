Return-Path: <linux-fpga+bounces-1013-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C0A1CE36
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 20:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F87216363E
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 19:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877F415DBA3;
	Sun, 26 Jan 2025 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3aVDC+nR"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E60156C74;
	Sun, 26 Jan 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921047; cv=fail; b=afTdjpWXgQj8IyI9PCa2JxIiGo54SNRvJ7ptl9+9SjGJ7VFU924NP1jLR8JWAz3hqPJdknE/qPoKGacZc2dZ0kklN939JgAOxlVAz932lUQZ+mOjx6aNIKLVG/5yyPRVaMuEd/usFL2jsLxgBQO6wvkKP8UZdr4rWKrYb+CxJvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921047; c=relaxed/simple;
	bh=L2QO1cucTdALxgpWzlu6rGBSGfuDNjYm/x3aTOriuUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UNLyUEq36/LobBHgjCCe0HpFkTrfLaObxI2I5A1AabnFGwPmZMB1CWHXcbFOOWKez57wT9xxSbRtB19/kaJusGBOmTplbeq+pHUELe+y3AvElnyPCebRUydYpMJHntqfXPReelUlgmICeGA7rkaJz2wslu0X+4oUFvqIzKp119w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3aVDC+nR; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2Ppw25WvA6SeeMBNLQlwH48glZEssvi+euuZrqLUgA6G12pgcOsPVf7UZ4r4gKG7+vdrCMMQK4XPHFCoelJ/IGStm3sP0gmIRWHqEfQe+jd9Vb7E4RkAzWkOINcd9JEBXF80AFuz4GIE7dE680azzlJVFqvyLS7FljUVMyjVWOtEZpO1jnziu8Hfhtp6tQ2jtMHO75Z0+Q6EQN8lct9WtZar0QzhYpz5lF8qddXwPdYsVV4pPcDs5JY8lrRHJbg0ncqq184i/2bF5hzOIBJAfYoxKJXqR4SxJ82/2R/yG9LTdghtphvQwHyhP17IE+TPx2FBl0kBDBYaAg4aga3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m1s8tEvex2A2zLwTrOJtUlmWmfpv4ZBJJPsVE36Cd0=;
 b=V0SxTrXtAJ8E/CqVUYhc7rKwaOcZZvebeLmY6s8r9ePLf8iIW/7KAj7aGVjPV49/xIdSzxI6JMdOl+N41UbGp3aYwbA7/Fu3kmUuQmBGIJzw3L5fYEx+BEgCMDNYe14ymnl7D98DiESacbxq09Z+1RdketO3mdB9X9qqnWgYqK0bkyT6wcS5oozH79kP7zmfCA+0TatZskdp4w/HQnZhLFUKKPf56aVAXFcAVkQMHQgCgvk5mtNpqVbrEMrzERVFnlEgC6KpUbMtdIsCn6K/lIRAORrfQMfUCU5x/sZIlmfxzpfrceSpVcKFtfk5wCgpKt9LlUsTTEHoqIYeUQyQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m1s8tEvex2A2zLwTrOJtUlmWmfpv4ZBJJPsVE36Cd0=;
 b=3aVDC+nRKtxzyC5Ob7dyBtGeLrcNPIt7D06nT/y8fiTuNzRbwbRuqNGn3VfnVovADJWCTMu0nczo9kYS2iko4pgQ4UteRLsavQhkOfJCx4XnAap4nhyS9f2i55j1iQYAYdKl8H3Z+Cjomxw7kGGY8LnS04StjgX8IstTC3OUvC0=
Received: from MW4PR03CA0234.namprd03.prod.outlook.com (2603:10b6:303:b9::29)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Sun, 26 Jan
 2025 19:50:41 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::43) by MW4PR03CA0234.outlook.office365.com
 (2603:10b6:303:b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 19:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 19:50:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:50:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:50:39 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 26 Jan 2025 13:50:38 -0600
Message-ID: <8dd847c8-6380-4364-ba47-c6c014f0d23b@amd.com>
Date: Sun, 26 Jan 2025 11:50:38 -0800
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
 <Z5X/QeJ49s5Y3SuH@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <Z5X/QeJ49s5Y3SuH@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ccb339-e904-4f51-81ab-08dd3e42b698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmhaY2xxWC9LTmw3anA0Ry95UTB6MVdUWXc4cjhNK1JPZHZrNk4raFZrTWU1?=
 =?utf-8?B?MU80VVhBU0pyRVhLbUc0aDJMbEszMnkzdHpxZFFsT3VUaFB3ZlY5Y3VET0Ur?=
 =?utf-8?B?aW10Rm43eWRxT251K1ptTlJNa2kwM0lzaVQySG9GendVTEtHcHVPVUpwYWVn?=
 =?utf-8?B?MUlIUHhIa1pZRi82eW1xdGlRd2Rra1V1aTNqUzRYV0hWaDBKTXpQYklyb1VB?=
 =?utf-8?B?MHdVb1U2V2p1WTluOXllQjNJRytPWHh0THBsSDk1dDRISGhTMnp3Q3hpTFBq?=
 =?utf-8?B?OU4rNkxqY2RTdUEybm5FR2R1K2YzZG9wV1p2TzBiU2t6dE5TeHdTaW96STVy?=
 =?utf-8?B?aW1JWnJ1bWViaGlLOEdrYUdYTjFOVXN5ZjVJTld5YVp4YWE1QkV5R1VTYTBj?=
 =?utf-8?B?R0x1MUpaK2JPT2liQzJReUtnOE11R2h1bDJvVnhCaENROWJLN3NEelVFWFds?=
 =?utf-8?B?NHhsQ2FRQzFRK2RDVWVNRmNyK045OWR1VGhvUWZrOGpzeFkrTVZKcE5UN3VT?=
 =?utf-8?B?aWJxZW1Gbk90QnRoUWRVN2NhY1BkaGEyQXZBeW9sMHliclAzMzNvVVdzK1VN?=
 =?utf-8?B?M2F6cktlRkN6aUJMT3M2OW10Q2pVcDNwd04vQ044eXhvVDlsUXVKdlg0cmpu?=
 =?utf-8?B?NzJGbW9JOU5HZlNEc3d0R3d0RHM1V1h0MHY5S01LR3NPUUlCaEdTei9JWjZn?=
 =?utf-8?B?WCtrLzVydUt3ODZBNDlaeEV2eDczTVFjRzh1VlNTcHBBTllSRXMwd1M3RER1?=
 =?utf-8?B?Ymx1RnBNL2k3R0p1THFvMW5JRjBaS2hqdHBJOUdxc0VIZ0dFbTlkMFdXREtQ?=
 =?utf-8?B?Z2psWmZtUnVnb3dBTGRLUWxCWmxNbm1tSHVJQzFOa2tzdUEwR3FmUE5Fb1ZE?=
 =?utf-8?B?UjNtTXFucFpkbFhOYUpKSHFHMndhWEZXc3dkZUt5dDhIa0tOVTlYaE5VQ01I?=
 =?utf-8?B?YTgvY1lQbkg5QVFVNVprQXd5US91RHhUODAwTHF1YlBpZlVIa1laeDJMb2RN?=
 =?utf-8?B?NXlJMSsvNVZ6RzZrSzJiajJaZ2lKcDlzMVVkSzk1SkRuNVJqYzVuT0FOOEhh?=
 =?utf-8?B?aHcxYkowcEFhaTJ3WGY1UkdvUC90ak5HS25MUWNhRXB2R0JRd0FmOGErMXpX?=
 =?utf-8?B?eFAwNVBuQndOMUlWOWxHcEVmcEIzdVVRZkJra3Q4Q2hRb1l4WVcxUllRaVMy?=
 =?utf-8?B?TkM2ZGNTc2E4L2hBTFVqUUFGZFRERmJQb3RzTTFqMVRXRTlNaHRITDl3blVa?=
 =?utf-8?B?TmdnakhWbHFMQVAwd0xsREg3cHEwcURWc0dTcjRiNUxGc1NKYjVJWkFDdGw0?=
 =?utf-8?B?TmJPV2VzY0lPN3dHekxWaTl5aWc2dTRDT3gvMXl6QWcxSEhGcE4wUWdHbFlD?=
 =?utf-8?B?NzJBVkdvZStkRUt0UGtHcTBtRTNHNDc5SnI1cnZ5Qlk2eDFMNk5LaDZzUW50?=
 =?utf-8?B?eVVHdEVIZXlML3hldThwc3pWQ0RNYmFjM2lHRnl3RXlVNUVYeE1EQmUrK2t5?=
 =?utf-8?B?YzNJczlsSGlsVHRMZDAzeE1hYkVhSC8xOXlmVzVIYmV5TXRWa1NTY3IwbC9s?=
 =?utf-8?B?MGVZVkNnTkh0UkNlZkpFc1NQZXhhMTl1dHp4WmxqOEVQeXFxUXdkL1ZtOVVK?=
 =?utf-8?B?R3VrTmViNElheU4zd1FvdFlDTHR3TTZtd1FkbE5WRXlzZTRIQmxVenBBcExQ?=
 =?utf-8?B?NFJWSzRhcHVpSlJBNnpOMHNJYVE2QzIyMzN4VTRkWVpmTE1VQW12ZGt2WGVy?=
 =?utf-8?B?QnBTYzh4QnpuYldKQWw2eWZMOTBOaUhQMmdld0drOTVCSWNYTGpLREhENngv?=
 =?utf-8?B?WW5nSXN2VEpDQmNTbWpqdzNxVHdXZVh5Nml2UUJ5S2pFdDhQN2dJS1ZzeGFx?=
 =?utf-8?B?bFpYK2o1SVljd1ZoeThyNWMyMXZGRDBlVVZRR0gwMUZ0SlUyRFhHazhoTnVK?=
 =?utf-8?B?a2tWUE5ZcHI2enRnbFVmWTNXUnplTDhGcXNwVDBmd09wMERRUjJ4ZVNvZjFL?=
 =?utf-8?Q?gwXaEfFbk1rwPY2eT2/Fakhbjc8PnI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 19:50:40.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ccb339-e904-4f51-81ab-08dd3e42b698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003



On 1/26/25 01:24, Xu Yilun wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
>> +static int versal_pci_program_axlf(struct versal_pci_device *vdev, char *data, size_t size)
>> +{
>> +     const struct axlf *axlf = (struct axlf *)data;
>> +     struct fpga_image_info *image_info;
>> +     int ret;
>> +
>> +     image_info = fpga_image_info_alloc(&vdev->pdev->dev);
>> +     if (!image_info)
>> +             return -ENOMEM;
>> +
>> +     image_info->count = axlf->header.length;
>> +     image_info->buf = (char *)axlf;
>> +
>> +     ret = fpga_mgr_load(vdev->fdev->mgr, image_info);
> 
> I see, but this is not working like this. fpga_mgr_load() is intended to be
> called by fpga_region, any reprogramming API should come from fpga_region,
> and fpga_region could provide uAPI for userspace reprogramming.
> 
> If your driver act both as a fpga_mgr backend and a fpga_mgr kAPI user,
> then you don't have to bother using fpga framework at all.

The versal-pci is more like a util driver that handles requests from the 
separate userPF driver.

Thanks,
David

> 
> Thanks,
> Yilun
> 
>> +     if (ret) {
>> +             vdev_err(vdev, "failed to load xclbin: %d", ret);
>> +             goto exit;
>> +     }
>> +
>> +     vdev_info(vdev, "Downloaded axlf %pUb of size %zu Bytes", &axlf->header.uuid, size);
>> +     uuid_copy(&vdev->xclbin_uuid, &axlf->header.uuid);
>> +
>> +exit:
>> +     fpga_image_info_free(image_info);
>> +
>> +     return ret;
>> +}

