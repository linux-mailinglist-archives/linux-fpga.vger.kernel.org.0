Return-Path: <linux-fpga+bounces-1015-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FBA1CE47
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 20:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CDA164EB0
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FD1632C8;
	Sun, 26 Jan 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j6lRa2Ia"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183C156C74;
	Sun, 26 Jan 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737921486; cv=fail; b=PK7NAHdac5k8LAB7KEBQ/vDUOzdjEkYPTKkYPpJkJGMs0CW7gduXJnl+ZyXpZwJwFOm89+tpzIEU5mRspOtdBS9ujkTA02jWr2rGdtG7kcr51cFGKx8rUhv1eSczZJ54ZwXFTlRIFX93V2MEhwdMDCLQu0VZTx1fTR3sCduwUR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737921486; c=relaxed/simple;
	bh=Kv2bQsa3e798UH9+lVQbMi1CmLd5ZZICCiUwqWKXiFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G0Ys5grj/ybJvTIDAzR9LGs4vZdlZjGCD1ZjQ+wwZj5Rz9SUUMhBXQkPGtNpfnAOHTmF61Bu8OIZNrc5Q2CZhx/lfPY4I9P9dI/Bi9dI2ZxAIcrDOLIkxwfaEZWbYRytDcZqF0QKnytrHp1DLrPj7fndY5oYSqe9FtAD6oC17NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j6lRa2Ia; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/1a7VU+xoIIhyVjaXrvVsdk/qK6gzMIoYGmPtiCitJVn+147+v02UZOXJI4e5SSJ9j9ALMX/b+dp8e8vBWnOm566ag1T+PLRavg13KzixTY9RK9tiFPEj5EO/gRwaOveH7rYj6Q1q8QF8aq5LbNsTmlfIirYwZU8fpjIDBgSyM6HPwkhklrXC3eq706NY97Y2KVVJAkYnV+CVCvSz+BpT2+pqR0oi+lx2epYG0xqre3ce1RtlBinNNS4IWXdTrk4+z6sUFpNzc/UYgG1IlClZcUEfkpU6SnoRu1KURw9+Yz6Jf7NV3/L1Z/OQpnhpFXnQ+0Q6H5suLygovnlHFtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKYqb6OkTJFipDpP8RK/ut3Mrryv+CPT9F91SMGgKgg=;
 b=tFyCYdz/TtE9NcVGt7QeYpYK2wHQURoFX+Ai1B0tPTRFs0ITdgdC4Kwe7zsH96ErfjjbfdkCVfQtFT3e+b1wofmWeIZ7msFHIunLEfkEwDfamg7Rxo5WMvPK3EYeaHtyBmHup5cxDeb4qDH1AT4rrCJWILtZ3nZoVqCVgX3aNoQvEdZ7R5V1bz8DWGoo+y+EP3Pw7kpexpfG6kGRs3X9UdrNEmhCaGdUlhXMr9kesqZvCAihEgJ0tLziINHNE3t/A+/1u4UY59dQlwNBUkssqSW5DYgnLFMlFzcAP91VewqcDhHQ9NRL6x0WMnn9B0eeFMszzzxVK+II0fYZ4d+dBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKYqb6OkTJFipDpP8RK/ut3Mrryv+CPT9F91SMGgKgg=;
 b=j6lRa2IaUUmQvl5BGDuXgQIJ9nbG6FU/YOMRVzJiquQR92GSvFHugQ7iFaBtTcDobU3fLGTT678L3fnln1UlOSCFo07Npk82B+l4Wv5VYDQ6JDSSbRwljhjvK65SEDzhvWi+ViAWiTZN60Y4qLkPzhzlRUBdKYWs6O/AMQZG8hg=
Received: from BN9PR03CA0789.namprd03.prod.outlook.com (2603:10b6:408:13f::14)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Sun, 26 Jan
 2025 19:57:58 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::ff) by BN9PR03CA0789.outlook.office365.com
 (2603:10b6:408:13f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 19:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 19:57:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:57:57 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 13:57:56 -0600
Received: from [172.19.74.139] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 26 Jan 2025 13:57:56 -0600
Message-ID: <eb0eae5a-8429-48ff-85a8-43c0a94c07de@amd.com>
Date: Sun, 26 Jan 2025 11:57:51 -0800
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] drivers/fpga/amd: Add communication channel
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: <lizhi.hou@amd.com>, Nishad Saraf <nishads@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-3-yidong.zhang@amd.com>
 <f35c40fc-7afa-4fef-bab2-0b30302b9b21@wanadoo.fr>
Content-Language: en-US
From: Yidong Zhang <yidong.zhang@amd.com>
In-Reply-To: <f35c40fc-7afa-4fef-bab2-0b30302b9b21@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: f45e1cd8-2765-4163-4a09-08dd3e43bae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDJOS1gzYkU4YmZ5MG5IaTRCcWJCLzN2QnljZHBrYlFZOGpaSERwOHh5bDZp?=
 =?utf-8?B?eUsxTWN1ZWZ1VWU0RWJLT2ZTQW9oUWZoZlI1SWNwQ213am02SEM5NWswN1g2?=
 =?utf-8?B?bDdrKzN3NTFsTzRGaytUQkNDejA2ZjgvOHJISXU5a3ZsNXA5eFB0MGE3Qmxn?=
 =?utf-8?B?UmFOVk1iRGNqTVpkWHkydk05TGFPWXR3cXBhTFdGUEcwTnhlbDB5T1FpL3dT?=
 =?utf-8?B?OHQ0TFYxZXhZd1VGSmlmMTBMejRqc2pDdHN6NWZrRUptekdSSVNKV3dPUGlw?=
 =?utf-8?B?ZkVHSDhqK09BNFlQOUlIZFdRV1E1MnR1SCtLUjB1L21NZkRrS0ZKZE5VSEkx?=
 =?utf-8?B?cTM0Mll1Mlo1RkF0dmx3MmYwUzU1MlhteFZtTVo5LzJjNW1ZbG9CTkZrUXZ4?=
 =?utf-8?B?MmwwZ284UG1UcWdDeWJuZzFreXltbitOZGNaSVZ2R3Z2YXZTR0Fobmt5TE43?=
 =?utf-8?B?YUZBdkh1b1VMSXAxdVZsVGh3blhrNUhjTU96MVdMcGhiMWRSditBQnh5UFYr?=
 =?utf-8?B?N05GaEp3NGl4Q0p3M2tsZDdDK0dKYUNUT3FJc0JHTUduL2picVNBQ005RjVK?=
 =?utf-8?B?dTFXMDNDb1VPYytRb3RaZkVjSkJJUkNGZ1lSb0RSTTVhVEx1RkQ0NWxlMGRx?=
 =?utf-8?B?TVhqejVvQjAwSE53dllKc1JkV1REbVR2S1FtN2tuV3QvZnlHalpQL042S3ZF?=
 =?utf-8?B?TzdGNTJyTElDQUFjTjJjcG9XKzQ4NC9lQUFuN2JKNld2dElna0tMMjVsUXV1?=
 =?utf-8?B?VHZRc0dMdExqOVVpR0tKVzYyTFdxQkxqbmcwbTBwYVlFeHMwVFNnSlpCdGpW?=
 =?utf-8?B?cERlU2ZON21UU1ZoanNjMTYzVFZHYitSN09DTWFINGlPYkhkb3NCalNpUVUw?=
 =?utf-8?B?czI0ejhmclhoVGR5K1BjeEttM2IvOXFVWVB1cVNWdjh5cVNSVzg5ZXY5Kzdz?=
 =?utf-8?B?Z2F0a2RiWnNWUFUzRkxOY1MyQzRhYUI5MC9ScjMxVmFOaDVITjNyOHV0eVVE?=
 =?utf-8?B?VmMzNGVWSDVScTQwTkJ0WnphVENwYTFxcHM4R1V4Z0JQc0hneTRTWmpsKzd5?=
 =?utf-8?B?YkRoNEV2aEliTWlIcWlLaXFNa1hKWXNDRFVxV2xadWlidTlHRGJzS1hwNHUz?=
 =?utf-8?B?S1E2dzNycVUyNURPcnFjOGJZMnBkeGU2d0tFNSs5VkJlSytIMW9MS2VyYjFp?=
 =?utf-8?B?UlhzYnduR3Q0WkhoNGU1dWVIelFDZzRxd2NxMVB6THJqcUdENDNmMzF4TXFv?=
 =?utf-8?B?R3d2bHRDSWJkbFNjR1U1MG8xN1NRYXRmakhOaitpdHlQQmozVE5qS2ZoSWE1?=
 =?utf-8?B?R0M2NkNjZFZVZHdwdDJOdHdyajdIek5zVEtIdkcyNElrSlZmV2tXSXNaYUVW?=
 =?utf-8?B?K0hNcU04NUNIcVQ0Y1gyZDJESlJIZ0EvT3NORnc4OHZVK1RHelV4MFdFNkY4?=
 =?utf-8?B?OFkwZFZYUDFpa0ROV1puN0t1VkpkeHlLSEM5ZEpSVFVRMWNpbVQvOG93a2ZM?=
 =?utf-8?B?TERtS0VDLzJCWkVqT2xvUWg3UzNqSE9jbGI3bVRVa20vWHd2UVRqa05DM3pG?=
 =?utf-8?B?UmpYeExhVFZOMDErdlIvU0pieklkUE41Z2tZeU9rSHZ6TE9IOHRkQ04zSnJz?=
 =?utf-8?B?ckJuUWpYa2poVU9jcGFtNGgwVmE0UG12QWRQa2gwc0VhU3YydktKSU9TZ0dq?=
 =?utf-8?B?T29mYlAvNkhleFhIZThJenZzcG1Kc0xQYXZ2NTJBMExob0ZHSldEaWNKdnF4?=
 =?utf-8?B?ZFVPbUxhMkdqTHppRFEzRWNSZlBueXlySzZIeGpSd0FFbEE0aWxzYXZ3M0dR?=
 =?utf-8?B?S01PTGFzNzA0V0VlbEhza3Y1TFNjQjZDQ3BEcUZPMmZGN0VodzZlL1Y1eVFh?=
 =?utf-8?B?RmtlQUFhL1pPT2QrSnkvNGt6VzFpQTFvTHNnYVpvNW9Db1R5N251dEs0VWt1?=
 =?utf-8?B?dC9FUHY5c2o3d1FEbnhaYzl6L1Nib0ZFZXc2dE1ENTd3NVhxRjhDQ2cybDJP?=
 =?utf-8?Q?IvgdWOXZo6pJtp6rKu2Wo2aZJBrTkU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 19:57:57.5017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45e1cd8-2765-4163-4a09-08dd3e43bae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179



On 1/26/25 02:19, Christophe JAILLET wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> Le 10/12/2024 à 19:37, Yidong Zhang a écrit :
>> The communication channel (comm_chan) service is between versal-pci 
>> and the
>> user PF driver. When the user PF driver requests PL data download, the
>> comm_chan service will handle the request by versal_pci_load_xclbin.
> 
> ...
> 
>> +enum comm_chan_req_ops {
>> +     COMM_CHAN_REQ_OPS_UNKNOWN               = 0,
>> +     COMM_CHAN_REQ_OPS_HOT_RESET             = 5,
>> +     COMM_CHAN_REQ_OPS_GET_PROTOCOL_VERSION  = 19,
>> +     COMM_CHAN_REQ_OPS_LOAD_XCLBIN_UUID      = 20,
>> +     COMM_CHAN_REQ_OPS_MAX,
> 
> Unneeded comma after a terminator.

Will fix this.

> 
>> +};
> 
> ...
> 
>> +static void comm_chan_check_request(struct work_struct *w)
>> +{
>> +     struct comm_chan_device *ccdev = to_ccdev_work(w);
>> +     u32 status = 0, request[COMM_CHAN_DATA_LEN] = {0};
> 
> These 2 initialisations are not needed.

Will fix this.

> 
>> +     struct comm_chan_hw_msg *hw_msg;
>> +     u8 type, eom;
>> +     int i;
>> +
>> +     status = comm_chan_read(ccdev, COMM_CHAN_REG_IS_OFF);
>> +     if (!STATUS_IS_READY(status))
>> +             return;
>> +     if (STATUS_IS_ERROR(status)) {
>> +             vdev_err(ccdev->vdev, "An error has occurred with comms");
>> +             return;
>> +     }
>> +
>> +     /* ACK status */
>> +     comm_chan_write(ccdev, COMM_CHAN_REG_IS_OFF, status);
>> +
>> +     for (i = 0; i < COMM_CHAN_DATA_LEN; i++)
>> +             request[i] = comm_chan_read(ccdev, 
>> COMM_CHAN_REG_RDDATA_OFF);
>> +
> 
> ...
> 
> CJ

