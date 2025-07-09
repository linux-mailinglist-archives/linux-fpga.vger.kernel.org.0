Return-Path: <linux-fpga+bounces-1278-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34250AFDF4A
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jul 2025 07:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855C17A4B3B
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jul 2025 05:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007225EF89;
	Wed,  9 Jul 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UUFZIeVS"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E91F0E55;
	Wed,  9 Jul 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039265; cv=fail; b=hgqbYvnQKDikLIBlavRYoAHsU1HrU5ftwXEwnx2TMIi0x9ctXmSpJP3s7EM09drEE9nZzLD93L+YHLPi28bcgaY/M1FYgyGPNzaEhHlwRVe70CCAwYVouxZ436xru6qkPhfp9VdlwblmFX4ihDm0QL1AdWCzDRREXF0ZXK1H4+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039265; c=relaxed/simple;
	bh=Vbe7wxTPpT+f52kaogmrTnF+57fKggAg3LlYhHlVECY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oFKAc7wqN5qBLG9l9SOk1FmoIKYIz4h7IJO40AHASRSZp0KpffkRH7YzXBbDhdHZ8h1KLA/TrDf0nyIhmJnkScYJvOtqxZISmCJ6M3JxRNkS7z+Mlcx+QgkIolrRZCYeBqNYWZPB/BWnvUazXg+yjbLkEs2Z4rjWjg9CHXqtTm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UUFZIeVS; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4saObyk5nz6aFnQph9BI3T3DvU12J74y6l5TwsD0pGOE1pdPn9ofiPYifCaLBpTdOWWr+q4OpVRKXZ4ba3x7SV1lT0faYVU22ZtWObdazlFzjNSDVtPSF7+TDKwCQOnFF6F7EWVX4o+8cJBZrdrBxurTSfIIBeU+EbzMRAmRPey7GLc2X/H7wQWhFeoOjNiXt2G4UBQbF+XnJ5IFahEhiYW/zKndMts6Pyniv2tpWnFSXN5b6dU0X/agVYBlDslfOXOXT53QbZx77j6l7r9VH0hAgHwoonFw/Fdam4xMYCZkhPCDfqzT5cfoPIYC7BrME8YX2ayQQsSnjwR8alAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn0MoRcWuyalqeFsXTK0cY+QhHsZlmrH/Q2o2xRLzKM=;
 b=XYlKPlwRlgZoUyud47uI7DmdgKkDWfYIv2oFc2g2ZoMJ+9l5KhXN6xjJ8na3/pNfA15orH4hz/QDDMN0sgQ8NHOHMdkH7r20kXsIls6u8B2J9zkur8/C2LGaIBVc25DJsH9RHeB477h2XBdZdzfz42bjCAM02tQBU54s97eXaxKbyNM1mEY6WX0ieycYk3QhhQ0gEdAIduyjbPKz8PYuFEtLSsGs4hukMU031NCOpTLWjE0coBps2LKg1f3xG0tHV7X/QDKqu/uihWyCaoGQyF1D+KOIvkvGMMKeLVSJowvE7xI8/Tx1uxKVRGv6UYEJn7cPyINd+LXZ94BmixNBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn0MoRcWuyalqeFsXTK0cY+QhHsZlmrH/Q2o2xRLzKM=;
 b=UUFZIeVSL5pkdFmeZXE6vj+Wgeu21q84YiquFYRRW2VTYlKpvicqqpNVJbZoldldvtTMdePI2ycvZNb/rK/OA60p3ypiqxi4tKC3/jUIYDiDteFPBxHudLSegQh8aJ1x/irVv56cZvUxVUFCA6rPHMvSl+BzeEBq3zzoczrFfkE=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Wed, 9 Jul 2025 05:34:17 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:34:17 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: "mdf@kernel.org" <mdf@kernel.org>, "hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>, "trix@redhat.com"
	<trix@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Thread-Topic: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Thread-Index: AQHbyHAvjfKTIyDsoE6M6pJ/SBy77bPue0MAgBDjfuCAAab5AIALDxoQgB1/89A=
Date: Wed, 9 Jul 2025 05:34:17 +0000
Message-ID:
 <DS7PR12MB6070785F5A9381D22D03536DCD49A@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
 <20250519033950.2669858-2-nava.kishore.manne@amd.com>
 <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
 <DS7PR12MB607015CAB2781E16A4EC110ECD74A@DS7PR12MB6070.namprd12.prod.outlook.com>
 <aEv48IZSinWjJgBt@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070BC635C899C637EDE71F3CD7CA@DS7PR12MB6070.namprd12.prod.outlook.com>
In-Reply-To:
 <DS7PR12MB6070BC635C899C637EDE71F3CD7CA@DS7PR12MB6070.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ActionId=822586c5-6b17-4234-be4d-27cf212f634b;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_ContentBits=0;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Enabled=true;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Method=Privileged;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Name=Non-Business_New;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SetDate=2025-07-09T05:33:16Z;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_94523dde-f9d1-4aa7-80a9-c0900420d3c3_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|CH2PR12MB4200:EE_
x-ms-office365-filtering-correlation-id: 89bafaf8-557c-4dcf-733a-08ddbeaa3f5c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?M2kyUGswdzJ4VUR5c1NqS1p0KytvOGRxb0xjTDVLTVlvelNPeDlKaEpy?=
 =?iso-2022-jp?B?MzcrU0w3aVZxYy9WVWNCR1pFTTdyaHJTL0F6enlxN2xCQ1N5anB2aXU2?=
 =?iso-2022-jp?B?c3JiRTdxVjhPSmNCakZuYXVYNHd5ZWVoTFlyV1prcHllL1ZkeC9wSnVS?=
 =?iso-2022-jp?B?bVpQelU0RGx1K0U3aVNrSmdwN2lUNzBOL3BadTJuNmRWSUIzSHROZHVP?=
 =?iso-2022-jp?B?TjVPbHg1aC9kcEE5V0RzODM1Z0NyekpvcHhremllTFlOdFFhYVI1TlVp?=
 =?iso-2022-jp?B?cVUxRjRFR1NrdG1JZC9lKzNLVEhQUzNlb0xrdnFpUkowc01yWGpLbDgx?=
 =?iso-2022-jp?B?VGV3SGRsUDNpaDBDMnRNcTRCR3pha2RsenZoN1dldm8rY1p2OEVnNFFk?=
 =?iso-2022-jp?B?RWltNVB1cVBKY0lKVW11OVV0RW1sTDdZWjVkT2x5eDZDR3hqNEJiNFBK?=
 =?iso-2022-jp?B?ZXp2eVozbnB1a1lJaktGSHpJcnVadU9ibjErVkJuZkFhdWRqU000Z201?=
 =?iso-2022-jp?B?N1BJOUZUalRhQzl3cDM5TGhWVXU3aXFiR1VlQmkxaE1DMzkrZFlkbFgy?=
 =?iso-2022-jp?B?dSt1M0IrNENDSzhBOWY3b2h4NzRTb0lqbmtkQk5UeUNIOFJTRFU5YVR6?=
 =?iso-2022-jp?B?MWtDUWE1Uy9DbnNQaHhyRnFZU3hJZEZVbmtheG5zSHBwVmdjaFd1cGtT?=
 =?iso-2022-jp?B?dllYNHk5ZHJnenpvNWdlbWdlSUxGRkJLVlhOdVJ2LzI3OUdLbTB5ZWxo?=
 =?iso-2022-jp?B?bUJ2MDd0WDEyUGduQW1aR3BkQWljQ2tBRlJVY0xlTnhuOGNoeEM4SmlZ?=
 =?iso-2022-jp?B?Q2JOd20vRVdETVVDMVZvWmZ0VjUweWxWTDNzS1VXdFBlYlJNc0NObzZo?=
 =?iso-2022-jp?B?UTdXVk1ndnRFTklETjVOa3dsT2JlQms5TlZRb0Z4VE03d244S1RmWnBN?=
 =?iso-2022-jp?B?OG1BS1pEVXZ3c2J2WURINWhqV1dCN0wzWHpRUGY3b2VtcXNNMHJSQ005?=
 =?iso-2022-jp?B?cVI4THhUQ1l0Tzk5OEpkNEFNYmJQa2NOVkZmcEtrNENoWlNVNmgwT0Nz?=
 =?iso-2022-jp?B?cy9MYzlXU25FYnV1dnFwYXcwcEpHR3d6anZHZnVsS3VZNnNxc1hTRHI2?=
 =?iso-2022-jp?B?OEE4NXVSWlhJZENRekcrOWJiSUtjWnNrOW1RYVo4YlhjbXJzZEhwYTdy?=
 =?iso-2022-jp?B?TDh1RVhvcmtZNjBrWFhvbSs3RGh4RnFqVkNyOWF3UHU1MlRoclVFUzNN?=
 =?iso-2022-jp?B?SU9Mb1l0QzhRZ2QrWXNzY3BldEU5d21QVzJqd3MvRFRjWnUwZ3ZYaWZp?=
 =?iso-2022-jp?B?K0VjRmIrWnJGVE1FeFd4eFpXaGNIZWpDUzFZSGFGczFGZnAwK3BCdzlK?=
 =?iso-2022-jp?B?WjhqOGVJVTRkQ283eDdhakoyZS9mVTlCODZmWUdVa3A1dUxoU2s5RWti?=
 =?iso-2022-jp?B?TEFOTysydXFtcS96aHJHT2pZeVE4SEl4T0FwaFhKN1NCVTg5TVgyQnlO?=
 =?iso-2022-jp?B?VXRhcGkyUC9DbGdvaFoxNmRRN1I5MXpOUS9ubjA4V05CeWlrSEZtWnBx?=
 =?iso-2022-jp?B?Ukg0RGJwSUR4UEZTZW9aL0h4anE0MWFYd1Z0Qnl3MWVNaFpabStDTzZl?=
 =?iso-2022-jp?B?R2Y3R1dIbjhJY21sQ29NYk9pV09rSlkwbCtoY1FYblpTcWN6ZnZRTUhj?=
 =?iso-2022-jp?B?QkJCQTh6NFRUNGhaQm90NVU5Q2UrRnlOeklldW04Q2VGMDFrNFlJVVRp?=
 =?iso-2022-jp?B?alRTdWRuU1JLUk1IVGlUN0s0U0NWUEtKaHdxazVWZCtoREN6NFRuK0Fa?=
 =?iso-2022-jp?B?MFE3b1QzNXFzVlFiK0xQaHhIUERxVWQzMitadFdVMElVZmtYM1R4UDNF?=
 =?iso-2022-jp?B?RVdRVWQvRGsrVlRpc3c5eU5Wb0NpTmNtdGtLOG9xVnNaaUt0bGVvMTlu?=
 =?iso-2022-jp?B?eS96OUVDSG1xbGZzcFI3WGdNUXNoRHFWbk82V2xLMGd4b2dSaDY4ZUZB?=
 =?iso-2022-jp?B?YzVKQkNiSERoUUg0Z2VWcDRJL2hJT0UvUlNLb0VHR1ROVW9nMHVPcXlU?=
 =?iso-2022-jp?B?WCtEK0hFTUYxRFA3ZjhLbmRUbngrM05KVVh4Y1c5cTliYm4ybmxuUDk5?=
 =?iso-2022-jp?B?dkovVmw1OFFqUUFUbUNxL3ZlWGIwbFp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?U2dxd295YzVkbG94bHFQQ1J1UDk0WHhGRFY3Q1BOZ3RWNlFZeVM4VXV1?=
 =?iso-2022-jp?B?ZVpic2MwUURHbU9pazdPT2dNMlBsSkQzQ1NkMC9QKzVJRnFja0lJaFp4?=
 =?iso-2022-jp?B?cjNmd0xuQUEvNDVFODBwazV2WHZnYTZzY2Yrd2o3RHRKT1RsN082eTlo?=
 =?iso-2022-jp?B?MVkzSmF2L1dISnVNaFdkWWlwUzBJS2RBQnVNOUN6ZDFkK1ZaenVNckk2?=
 =?iso-2022-jp?B?bFRBeHlyYmhkUVdIRUxjald6UU9lejZudk1sMjkyeStiWklkblZjQ3pU?=
 =?iso-2022-jp?B?VlJaSCtLQktJWjFPRVVWTHRkcTYxUklYNDVhdUZXeksxSGowZ2locFRE?=
 =?iso-2022-jp?B?Rm1XVng1ZWFiMk9obWRzaHZKaTBzYVRkMG1VUk95ZHQ3UDlLZjBpbCtU?=
 =?iso-2022-jp?B?Vy9LOXNUdjlqaUlQM2hHS0UrZ2VEUDlrMjNaSC8zWE1yRGNXRDUyOVZG?=
 =?iso-2022-jp?B?dE9iWUZFNGoxYVBtZTJkdFQyTzdWMW5Gb3gwQmRUdC9rcm15MnRTdGZP?=
 =?iso-2022-jp?B?OUwxSWNpcGZUTmh2dmZkWExRbzQ2S2RrNnpsMDhnQU9xQ3NFcC9ERmVm?=
 =?iso-2022-jp?B?OGNMYWtKVlZONjNqa0FxRDRZTytXbzJsbTAzTFRRdmRwRngxSDI2Nk13?=
 =?iso-2022-jp?B?TWxLK0tDZmxLUys1VmpBanErSHhPcHB3VWMzOURWRlFMMk5MWVhrYzdp?=
 =?iso-2022-jp?B?ZDRreTF3MUFmOHZZeDFFR1g4L0U5OTE0WXpib29Yc2ZKbDZqeW5Cb3Mr?=
 =?iso-2022-jp?B?Y2IrM3EyaklQMGFxK3ZNZW1wZUFpWHl3dy9Xa2hzamJtRXpZWFMrdUxX?=
 =?iso-2022-jp?B?M29JNU5iZ0hmL04xRWpSUTBWbG1PZ25zRnB3SkdmTjZ0YlZZMlJ4N0M2?=
 =?iso-2022-jp?B?MWgrZ2RBUTVwNmc0bFNNQ0NMYU5JYnJpeWNsVE52ZVlBUFc1S1dnZm9N?=
 =?iso-2022-jp?B?WFBSaDA0cElXUXJXclhOMHhXOVRKN0w0Ym92eXVSeTFGQ2RhUHovK1B1?=
 =?iso-2022-jp?B?bzlyRTBiYkJQTGxrTW1zTm1DbGtqYnpJTkFQZEtDWWhDbkUzRUR0Wk5L?=
 =?iso-2022-jp?B?eENobGR6K1pRZmFiNVliZkhQb1B6NDNaOWppZGVuVUtGU05uQ2hUZjJs?=
 =?iso-2022-jp?B?ck9EdEhEY1Nqc1FoanpBdXlCK0Rsdkk4N3lPZllLQkZTQU9xUmVEbE11?=
 =?iso-2022-jp?B?dGh4TGFGSFlwcGtJVk13dXI1NjVscnJuUmxiTnNMeTRDTWhEVmV3STd5?=
 =?iso-2022-jp?B?SEtBRWVhdVhNb05ZaXNQcjVJQzk0NmkwVG1kSnJQK2luTURYQ3RVay9F?=
 =?iso-2022-jp?B?WmNOK0xBRUVxeXNwTU9DTjl6VGlETHREYVNMZVdjakNqQVZVRzhGRHZx?=
 =?iso-2022-jp?B?L2JGdU5sM09YbVJQZTRNU1FReGEwVGJ5MW1NQ3JRZ1hKV254VzIreCto?=
 =?iso-2022-jp?B?aU1SRTB3K3YxYUF6bmNVK2NmS2tKSGc1WXFHT1N4VDM2R21VYStUNkRU?=
 =?iso-2022-jp?B?dFVJRlEzM3RRN1REMENUQTNuNDEwNEw2NlY3UmJaLzNDSlErQTJxQU9Y?=
 =?iso-2022-jp?B?TW82QTdMb0N0dnJtYmsrbEFrYjJhbTdmUXdVZ1QxbmlmWWUxMnZmVUlP?=
 =?iso-2022-jp?B?Zm9TZ3RaMzBiSVRVckpzd01GOFNoY09nbmY1VXg4SFhnWER2RWFZK0dV?=
 =?iso-2022-jp?B?WmJLcVlXWXVNNHNZdWpVR05pdUdONEVjVEp5YXhzWmZsVzlHcHFIVGJC?=
 =?iso-2022-jp?B?S2l6dHNhRUtxU0cwK3FXS3AwK091UVFoblR3SERzNU5BK2VWSUhGang3?=
 =?iso-2022-jp?B?akhmZjR1dXZqRHRuLzlXZTlVaytYN1pWRzBpbzZqajF5NWtpNEZ3dk5u?=
 =?iso-2022-jp?B?bE1SbC9rbmlybWlSNEszM2wzdllWd3BWa2tjYzlvUktvOUZQZjdwWTN1?=
 =?iso-2022-jp?B?YytZdTFIRDBFQjRPU2x2Rzkrb3RtTk4wc09RSnBQQmI5ODFKMGwvVjJG?=
 =?iso-2022-jp?B?ZlpEdGNTQURTWms3S09vREkyNDMzUXk1cGduT1FSZjhCUWFMRXRaNjc5?=
 =?iso-2022-jp?B?NVpJeDhSSmY5bFhYYnp0aEhod204cHVZZzI5NFVUOUNHZm8yOXQ5OXN3?=
 =?iso-2022-jp?B?MHFwbDNqR3BWWnE5clB5NEl5VlRhOG5HaTJjYTFxQ1pYd1kwY1FDa0pE?=
 =?iso-2022-jp?B?ZTUzOU9FblUzOUxXRVNGMkpLU1BKa3JtV0FSSnJ4TXlOUFV0SVRDcUFG?=
 =?iso-2022-jp?B?N21DU0YzY1ltVWIrbGN5S3BnTWFPU2xOST0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bafaf8-557c-4dcf-733a-08ddbeaa3f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 05:34:17.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAHCvJv4xE1gGSoYk+itCgOl1z7/Nk68THf8czLPBnGb/pW/qzF7IvnKfr/NmrJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

Ping!

> -----Original Message-----
> From: Manne, Nava kishore <nava.kishore.manne@amd.com>
> Sent: Friday, June 20, 2025 4:45 PM
> To: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com=
;
> robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: RE: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for r=
untime
> FPGA configuration
>=20
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi Yilun,
>=20
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Friday, June 13, 2025 3:40 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > trix@redhat.com; robh@kernel.org; saravanak@google.com;
> > linux-fpga@vger.kernel.org; linux- kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface
> > for runtime FPGA configuration
> >
> > On Thu, Jun 12, 2025 at 09:05:21AM +0000, Manne, Nava kishore wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > Hi Yilun,
> > >
> > >         Thanks for quick response.
> > > Please find my response inline.
> > >
> > > > -----Original Message-----
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Sent: Sunday, June 1, 2025 8:32 PM
> > > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > > Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > > > trix@redhat.com; robh@kernel.org; saravanak@google.com;
> > > > linux-fpga@vger.kernel.org; linux- kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > > > Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS
> > > > interface for runtime FPGA configuration
> > > >
> > > > On Mon, May 19, 2025 at 09:09:37AM +0530, Nava kishore Manne wrote:
> > > > > Introduces an ConfigFS interface within the fpga-region
> > > > > subsystem, providing a generic and standardized mechanism for
> > > > > configuring
> > > > > (or) reprogramming FPGAs during runtime. The newly added
> > > > > interface supports both OF (Open Firmware) and non-OF devices,
> > > > > leveraging vendor-specific callbacks (e.g., pre_config,
> > > > > post_config, removal, and status) to accommodate a wide range of =
device
> specific configurations.
> > > > >
> > > > > The ConfigFS interface ensures compatibility with both OF and
> > > > > non-OF devices, allowing for seamless FPGA reprogramming across
> > > > > diverse platforms.
> > > > >
> > > > > Vendor-specific callbacks are integrated into the interface,
> > > > > enabling custom FPGA pre_config, post_config, removal, and
> > > > > status reporting mechanisms, ensuring flexibility for vendor impl=
ementations.
> > > > >
> > > > > This solution enhances FPGA runtime management, supporting
> > > > > various device types and vendors, while ensuring compatibility
> > > > > with the current FPGA configuration flow.
> > > > >
> > > > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > > > ---
> > > > > Changes for v3:
> > > > >  - As discussed with Yilun, the implementation continues to use
> > > > > a callback-based  approach to seamlessly support both OF (Open
> > > > > Firmware) and non-OF devices via  vendor-specific hooks.
> > > > > Additionally, the earlier IOCTL-based interface has been
> > > > > replaced with a more suitable ConfigFS-based mechanism to enable
> > > > > runtime FPGA
> > configuration.
> > > > >
> > > > > Changes for v2:
> > > > >  - As discussed with Yilun, the implementation has been modified
> > > > > to utilize a  callback approach, enabling seamless handling of
> > > > > both OF and non-OF
> > > > devices.
> > > > >
> > > > >  - As suggested by Yilun in the POC code, we have moved away
> > > > > from using  void *args  as a parameter for ICOTL inputs to
> > > > > obtain the required user inputs. Instead, we are  utilizing the
> > > > > fpga_region_config_info structure to gather user inputs.
> > > > > Currently, this structure is implemented to support only OF
> > > > > devices, but we intend to extend
> > > > it by incorporating new members to accommodate non-OF devices in th=
e
> future.
> > > > >
> > > > >  drivers/fpga/fpga-region.c       | 196 +++++++++++++
> > > > >  drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++--------=
------
> > > > >  include/linux/fpga/fpga-region.h |  34 +++
> > > > >  3 files changed, 493 insertions(+), 211 deletions(-)
> > > > >
> > > > > diff --git a/drivers/fpga/fpga-region.c
> > > > > b/drivers/fpga/fpga-region.c index 753cd142503e..d583fc22955b
> > > > > 100644
> > > > > --- a/drivers/fpga/fpga-region.c
> > > > > +++ b/drivers/fpga/fpga-region.c
> > > > > @@ -5,6 +5,7 @@
> > > > >   *  Copyright (C) 2013-2016 Altera Corporation
> > > > >   *  Copyright (C) 2017 Intel Corporation
> > > > >   */
> > > > > +#include <linux/configfs.h>
> > > > >  #include <linux/fpga/fpga-bridge.h>  #include
> > > > > <linux/fpga/fpga-mgr.h>  #include <linux/fpga/fpga-region.h> @@
> > > > > -180,6 +181,158 @@ static struct attribute *fpga_region_attrs[]
> > > > > =3D { };  ATTRIBUTE_GROUPS(fpga_region);
> > > > >
> > > > > +static struct fpga_region *item_to_fpga_region(struct
> > > > > +config_item
> > > > > +*item) {
> > > > > +   return container_of(to_configfs_subsystem(to_config_group(ite=
m)),
> > > > > +                       struct fpga_region, subsys); }
> > > > > +
> > > > > +/**
> > > > > + * fpga_region_image_store - Set firmware image name for FPGA
> > > > > +region
> > > > > + * This function sets the firmware image name for an FPGA
> > > > > +region through
> > > > configfs.
> > > > > + * @item: Configfs item representing the FPGA region
> > > > > + * @buf: Input buffer containing the firmware image name
> > > > > + * @count: Size of the input buffer
> > > > > + *
> > > > > + * Return: Number of bytes written on success, or negative errno=
 on failure.
> > > > > + */
> > > > > +static ssize_t fpga_region_image_store(struct config_item
> > > > > +*item, const char *buf, size_t count) {
> > > > > +   struct fpga_region *region =3D item_to_fpga_region(item);
> > > > > +   struct device *dev =3D &region->dev;
> > > > > +   struct fpga_image_info *info;
> > > > > +   char firmware_name[NAME_MAX];
> > > > > +   char *s;
> > > > > +
> > > > > +   if (region->info) {
> > > > > +           dev_err(dev, "Region already has already configured.\=
n");
> > > > > +           return -EINVAL;
> > > > > +   }
> > > > > +
> > > > > +   info =3D fpga_image_info_alloc(dev);
> > > > > +   if (!info)
> > > > > +           return -ENOMEM;
> > > > > +
> > > > > +   /* copy to path buffer (and make sure it's always zero termin=
ated */
> > > > > +   count =3D snprintf(firmware_name, sizeof(firmware_name) - 1, =
"%s", buf);
> > > > > +   firmware_name[sizeof(firmware_name) - 1] =3D '\0';
> > > > > +
> > > > > +   /* strip trailing newlines */
> > > > > +   s =3D firmware_name + strlen(firmware_name);
> > > > > +   while (s > firmware_name && *--s =3D=3D '\n')
> > > > > +           *s =3D '\0';
> > > > > +
> > > > > +   region->firmware_name =3D devm_kstrdup(dev, firmware_name,
> > > > GFP_KERNEL);
> > > > > +   if (!region->firmware_name)
> > > > > +           return -ENOMEM;
> > > > > +
> > > > > +   region->info =3D info;
> > > > > +
> > > > > +   return count;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * fpga_region_config_store - Trigger FPGA configuration via
> > > > > +configfs
> > > > > + * @item: Configfs item representing the FPGA region
> > > > > + * @buf: Input buffer containing the configuration command
> > > > > +(expects "1" to program, "0" to remove)
> > > > > + * @count: Size of the input buffer
> > > > > + *
> > > > > + * If the input is "1", this function performs:
> > > > > + *   1. region_pre_config() (if defined)
> > > >
> > > > Please define explicit workflow, and explicit expectation for each
> > > > callback, or this framework makes no sense. From your
> > > > of-fpga-region implementation, seems
> > > > pre_config() means "parse image", post_config() means "populate dev=
ices".
> > > >
> > > > > + *   2. Bitstream programming via fpga_region_program_fpga() (un=
less
> > external
> > > > config flag is set)
> > > > > + *   3. region_post_config() (if defined)
> > > > > + *
> > > > > + * If the input is "0", it triggers region_remove() (if defined)=
.
> > > > > + *
> > > > > + * Return: Number of bytes processed on success, or negative
> > > > > + errno on
> > failure.
> > > >
> > > > Please put the uAPI description in Documentation/ABI/testing. Then
> > > > we could know the file path layout from userspace POV.
> > > >
> > > > > + */
> > > > > +static ssize_t fpga_region_config_store(struct config_item *item=
,
> > > > > +                                   const char *buf, size_t
> > > > > +count) {
> > > > > +   struct fpga_region *region =3D item_to_fpga_region(item);
> > > > > +   int config_value, ret =3D 0;
> > > > > +
> > > > > +   /* Parse input: must be "0" or "1" */
> > > > > +   if (kstrtoint(buf, 10, &config_value) || (config_value !=3D 0
> > > > > + && config_value !=3D
> > > > 1))
> > > > > +           return -EINVAL;
> > > > > +
> > > > > +   /* Ensure fpga_image_info is available */
> > > > > +   if (!region->info)
> > > > > +           return -EINVAL;
> > > > > +
> > > > > +   if (config_value =3D=3D 1) {
> > > > > +           /* Pre-config */
> > > > > +           if (region->region_ops->region_pre_config) {
> > > > > +                   ret =3D region->region_ops->region_pre_config=
(region);
> > > > > +                   if (ret)
> > > > > +                           return ret;
> > > > > +           }
> > > > > +
> > > > > +           /* Program bitstream if not external */
> > > > > +           if (!(region->info->flags & FPGA_MGR_EXTERNAL_CONFIG)=
) {
> > > > > +                   ret =3D fpga_region_program_fpga(region);
> > > > > +                   if (ret)
> > > > > +                           return ret;
> > > > > +           }
> > > > > +
> > > > > +           /* Post-config */
> > > > > +           if (region->region_ops->region_post_config) {
> > > > > +                   ret =3D region->region_ops->region_post_confi=
g(region);
> > > > > +                   if (ret)
> > > > > +                           return ret;
> > > > > +           }
> > > > > +
> > > > > +   } else {
> > > > > +           /* Remove configuration */
> > > > > +           if (region->region_ops->region_remove) {
> > > > > +                   ret =3D region->region_ops->region_remove(reg=
ion);
> > > > > +                   if (ret)
> > > > > +                           return ret;
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   return count;
> > > > > +}
> > > > > +
> > > > > +/* Define Attributes */
> > > > > +CONFIGFS_ATTR_WO(fpga_region_, image);
> > > > CONFIGFS_ATTR_WO(fpga_region_,
> > > > > +config);
> > > > > +
> > > > > +/* Attribute List */
> > > > > +static struct configfs_attribute *fpga_region_config_attrs[] =3D=
 {
> > > > > +   &fpga_region_attr_image,
> > > > > +   &fpga_region_attr_config,
> > > > > +   NULL,
> > > > > +};
> > > > > +
> > > > > +/* ConfigFS Item Type */
> > > > > +static const struct config_item_type fpga_region_item_type =3D {
> > > > > +   .ct_attrs =3D fpga_region_config_attrs,
> > > > > +   .ct_owner =3D THIS_MODULE,
> > > > > +};
> > > >
> > > > I think this is still the sysfs methodology. My understanding from
> > > > configfs.rst is, use userspace interfaces to control the lifecycle =
of a kernel
> object.
> > > >
> > > > Now for existing kernel reprogramming flow, the image object for
> > > > fpga_region is the struct fpga_image_info. We need to associate
> > > > the struct with a config_item: alloc the struct fpga_image_info
> > > > instance by mkdir, expose necessary fields (enable_timeout_us,
> > > > disable_timeout_us, firmware_name, and the most important for
> > > > of-fpga-region - overlay blob ...) for user to fill/query via
> > > > configfs attributes. And
> > finally use a writeable attribute (e.g. load) to trigger fpga_region_pr=
ogram_fpga().
> > > >
> > >
> > > Thanks for the inputs. We've now implemented a ConfigFS-based
> > > reprogramming interface for fpga_region that aligns with the
> > > intended lifecycle-driven model described in configfs.rst.
> > >
> > > New Interface Usage Instructions:
> > > # 1. Mount configfs (if not already mounted) mkdir -p /configfs
> > > mount -t configfs configfs /configfs
> > >
> > > # 2. Create a region directory (e.g., region0) mkdir
> > > /configfs/fpga_regions/region0
> >
> > FPGA region is the device driver generated kernel object, so this per
> > fpga_region group should be created by kernel, not userspace.  User
> > should create fpga_image config_item under region group.
> >
> >   mkdir /configfs/fpga_region/region0/my_image
> >
> > >
> > > # 3. Copy your bitstream or overlay files to firmware path cp
> > > pl.dtbo /lib/firmware/
> > >
> > > # 4. Set the firmware name (e.g., overlay .dtbo) echo pl.dtbo >
> > > /configfs/fpga_regions/region0/image
> > >
> > > # 5. Trigger Programming/reprogramming echo 1 >
> > > /configfs/fpga_regions/region0/config
> >
> > My idea is, when an image item is first created, it is not activated,
> > user needs to read/write its attributes to initialize it, then we
> > could have an attribute (e.g. enable) to activate/reprograme the image.
> >
> > For example:
> >
> >   echo 1 > /configfs/fpga_regions/region0/my_image/enable
> >
> > >
> > > # 6. Unload/Reset the Programmable Logic echo 0 >
> > > /configfs/fpga_regions/region0/config
> >
> > Maybe we could just delete the image item for unloading
> >
> >   rmdir /configfs/fpga_region/region0/my_image
> >
> I=1B$B!G=1B(Bve implemented the FPGA Region ConfigFS interface with the f=
ollowing hierarchy:
>=20
> /configfs
> =1B$B(&(!(!=1B(B fpga_regions             =1B$B"+=1B(B Registered via con=
figfs_register_subsystem()
>       =1B$B(&(!(!=1B(B region0                =1B$B"+=1B(B Added using co=
nfigfs_add_default_group()
>            =1B$B(&(!(!=1B(B my_image      =1B$B"+=1B(B Created via mkdir =
from userspace
>                 =1B$B('(!(!=1B(B firmware    =1B$B"+=1B(B Write firmware =
name here
>                 =1B$B(&(!(!=1B(B config        =1B$B"+=1B(B Trigger progr=
amming/unloading
> Observation:
> If configfs is not mounted before configfs_add_default_group() is invoked=
 (e.g., when
> regions are registered early via base DTB), the path
> /configfs/fpga_regions/region0 does not appear in userspace, even though =
it=1B$B!G=1B(Bs
> properly initialized in the kernel.
>=20
> This appears to be due to how default groups function.
> they require the configfs filesystem to be mounted prior to the group add=
ition in order
> to be visible. As a result, the mount order becomes a strict dependency, =
which may
> affect or break early-boot FPGA flows where regions are created before co=
nfigfs is
> available.
>=20
> Proposal:
> Use configfs_register_subsystem(&region->cfg_subsys) for each FPGA region
> instead of relying on configfs_add_default_group().
>=20
> This approach places each FPGA region directly under /configfs/region0, a=
voiding
> the timing issues associated with default groups.
> The interface becomes available as soon as configfs is mounted.
> regardless of when the region was registered (boot time via base DTB or
> dynamically via overlays).
>=20
> New user hierarchy:
> /configfs
> =1B$B(&(!(!=1B(B region0              =1B$B"+=1B(B Region appears as its =
own root node
>       =1B$B(&(!(!=1B(B my_image   =1B$B"+=1B(B Created via mkdir from use=
rspace
>            =1B$B('(!(!=1B(B firmware =1B$B"+=1B(B Write firmware name her=
e
>            =1B$B(&(!(!=1B(B config     =1B$B"+=1B(B Trigger programming/u=
nloading
>=20
> Would like to know if this approach looks good, or if there are better su=
ggestions to
> handle this scenario?
>=20
> Regards,
> Navakishore.


