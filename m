Return-Path: <linux-fpga+bounces-1088-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B27A4BC7C
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 11:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A237AB591
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B41D79A3;
	Mon,  3 Mar 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W1ttqgRL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F31F0E4C;
	Mon,  3 Mar 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998073; cv=fail; b=rpZHyASGKPV5/lYhmkhGzi1c4Oo9GWpPGwW2HqdyFaZ8ZFN+dzogJ3pzRyDXkdziyhkl/rhCHbguqD0o428usd3bWh75wDmvQoYJZWUoU9zDu+a/hBRT0eZHicc13fqmlxcrJ5v3LfCiSQocl9WIp95PvSFbovcbIh/Cm1YKA0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998073; c=relaxed/simple;
	bh=bw+Gn1NNUmniVJey2eHfwiizegP+IEK42jHprrejuLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i62uScWWLdG5wXu466foshZjMLF3GwIjXIhQbeat05fjm56kYLnbRhkITq10kOeQ+hvxMGgc2jHr9WvTuM04ZOHH72pudlp+nLPG5g8K750WGlH/ij54Ygri1hMBOITn3hf0/3vjAPi0hSY2kowTf8cc1laMfDA0MgCIAFfraxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W1ttqgRL; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gojSexTrUckwqQ+ksKZQeWYtGSqv0sEqNlxTpBbfWx16v9cgyQQfCkt68OjnHm3JdME19g3le5JmjdoF9FsmKCUgUfpXnk3+KJBqpSSEpRhVzcPPH98JQsaUqZeBCHMm5taunAgdzsvj1FMYR5oRGYxlLaP4k8NzLIdS9TFrO0G7Kgo+SRRIjvh2nkhv8VSDx90StCUfOHXB35wpbKkbCY3HawOIFOIbxGJEQsE0CAmep6FcmLatRAWIc8xPPL3Iiuqvjcr5wy10mckcCBERX69SoypkAaqQRX2ou0A9tCxOIOPySwl6Ro67cUazQ37SLqkrC4tFfgkufcJZbEPuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw+Gn1NNUmniVJey2eHfwiizegP+IEK42jHprrejuLU=;
 b=jHGth3rdR/JS3cZw7nMo7aEtDHZ439ed1dg2KEGpGiDy1BhZgOCaVM4+u+PbeWUHrbDjJb1WG8fyOXYWUHReEmh+GMiZ7qT7hHK6yTngWYS6i/u+H6zv8LP0DZLut1OPHfaNar5dfgH+iPYWX3Yxzh3ehnbO2NJLnPf7svGuVGpLAhFYqjE+OfO/uK9wnyn5PZQLhWbCV0Cx22gtrE2MeoZRiQ+pSwyk6n4JNoOKW3mwVJue5i3Q8vbvxFVVj7gFYsPA+NBgUpLXeG5vwl/JotJyMWNt06lYFmIJISd63+YIvCtJLT1/0I0BgTkAzg/Km2eH7ABY9DFwQZBDSJQtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw+Gn1NNUmniVJey2eHfwiizegP+IEK42jHprrejuLU=;
 b=W1ttqgRLoMumjLyvjQMuRAYRH1G247+i0OgA8zxDf4IEsQugheiu6I2IqXFeyjbYjmPwLfs50HEnbqv6fd7YUe2WuRE2bvPtEZm5KGLFcFIe01XrYdMpIYL1rmyUs9pOtqjZlRPkIxbrAjgIER8ZTtJpNoHlVR6WK6FX55PcB1E=
Received: from DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) by
 MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 10:34:28 +0000
Received: from DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4]) by DS7PR12MB6070.namprd12.prod.outlook.com
 ([fe80::b847:e013:8f93:f6e4%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 10:34:28 +0000
From: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To: "nuno.sa@analog.com" <nuno.sa@analog.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>
CC: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Moritz Fischer <mdf@kernel.org>, Wu Hao
	<hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: RE: [PATCH 3/6] include: fpga: adi-axi-common: add new helper macros
Thread-Topic: [PATCH 3/6] include: fpga: adi-axi-common: add new helper macros
Thread-Index: AQHbgvKQB5FrVgyFQUaBjz0qW2XjfbNhR+Tg
Date: Mon, 3 Mar 2025 10:34:28 +0000
Message-ID:
 <DS7PR12MB607039BAB0F020C2CD726159CDC92@DS7PR12MB6070.namprd12.prod.outlook.com>
References: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
 <20250219-dev-axi-clkgen-limits-v1-3-26f7ef14cd9c@analog.com>
In-Reply-To: <20250219-dev-axi-clkgen-limits-v1-3-26f7ef14cd9c@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b79efde9-d535-4928-8710-6421843b677c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T10:27:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6070:EE_|MN2PR12MB4408:EE_
x-ms-office365-filtering-correlation-id: d189af02-ef94-49f6-c339-08dd5a3ef9ef
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y21HMjRlVTdvR0paYnk0WWsxWXRYVSs0ZkFweVJ5QWd0TXhoak9pZnl1RWVC?=
 =?utf-8?B?aVhlS2M1NnRUeEhHbHlYcHE2Z1BtS2FBbGVQY3ZQc3p6Nkt4Sm5kLy9uajkz?=
 =?utf-8?B?RTZ4ajA4ekJpOTNYOEVZd3I3NlI0WXFnVFVWOGg3Kzh5SkhxM1daUWJVcXhD?=
 =?utf-8?B?Z29BdnkwRHhmejZVWEEvNFROWW9CSVoyKzJiY3RzbzFTSU52R1VWZUtEUk5I?=
 =?utf-8?B?eXRHbEQra2ljTzdtV3VNaGNoY0tYS1kwZisraE5aT1JWNTN0VUpmem84TFgw?=
 =?utf-8?B?bHk2K3cvc1dDbDVOdUZXT3FOS2NVMjZSSTl1cTkwMkttRmZva21HRHp6NCtR?=
 =?utf-8?B?TzJFYllUMlFmVHhlbWUxdWJpcnVRVDQwUlR2ZTNHTkxlNGZ2SVJuQVprZkV1?=
 =?utf-8?B?Q0tDYjlBZXdscFptcTlWZkFNdkowcThEVUE4WDNDbkRmbTBIYWMvTkIzMlAw?=
 =?utf-8?B?Y09GZ1pZbTY4ajNJRGo1V0xFK3cweHZzOXgyaHBUc25neUhKRW5TOWJHWXI2?=
 =?utf-8?B?MGVmdWhnUjRPRHU3aDVXSE44T0htU2NMUFFIejFmR2pYSnJrS1M4MWY2cGxI?=
 =?utf-8?B?ODNZRkd2cGdVd2xMZk13RlFxV0ZGNlBtVnNEZ043NU1WWkN0Vy9NeTlEQy8v?=
 =?utf-8?B?M0VIM0RpWXczemQyWXZ3Y0pTMDRUOVVTWDZOcGVZRWVQYkM1THI4dmZGaVpR?=
 =?utf-8?B?WExuZ1dTUENhYkNLT1hvMVFZd0h1TEFrTFI3emZpMFBkcy9HUnQ3Q1dJNUlh?=
 =?utf-8?B?VUUxb2VTVCtWMGNTcHJKcnZuZ1BZNTBROVlNQ1RIQXk5SGJaOG5zZVhGKzVy?=
 =?utf-8?B?bjFHZVhoSjRiaXoyd3cwZ3d0bVA1cnQybUpEUVpsdTVZcEdBZHYvMnZ2ZWtE?=
 =?utf-8?B?YXhBVGFaZFQzNWlHSFNFeVRaSFQ3UE1QVWJ2NmNkcHR0UlJ5bkJodFUyeE0r?=
 =?utf-8?B?OVpJbmxFdlZvTlhFSnpjN0RtQW9PN0FVVkdFajR2QkNQNXdTMU5naEVmTUZ3?=
 =?utf-8?B?U3ZISGkzLzc5em9KQTF5L3d6YU9UVzVvcWhiM1ppZGNWc05qdC9KWThpK0VS?=
 =?utf-8?B?Q3ozdFEvOUU5bFNoTXA2YTZ5NGd4dzh2TUt3bGMvUUxoNElOKzJSdkpxczhp?=
 =?utf-8?B?N3ZMMnluNHUxbTBSUU1xbTBrTi8vUG0wc28yOTNhSlV5SnQwbldvVEhkNzRo?=
 =?utf-8?B?eDVPRzNFTER1M0dOT2habDJIaG5oampPUW5lNFhFNytMTnJRMHJENTlobllK?=
 =?utf-8?B?YklBRE1wa3RrK1o1NUNsK2ZKYnVnRGNuL0ozQzFVbE8zNU5EK0wxNVVFZlJ6?=
 =?utf-8?B?OTZLR2VZdHBYYzh6ZnM0SGlISGJSKzlUMWQyVUUvQ2xWbFVsWk9JbzRsekto?=
 =?utf-8?B?YmNKQXV0MmE1QkdVVVZ5Tzg5UEFSbzR3ZjBaNmZMSHZCT0JFSFVYeUQvdHYr?=
 =?utf-8?B?d2dLbWFyUlpCbzlTWlpITW1BTUduZktxdzdsNktONC90OGZDMmlDYzc1NmRW?=
 =?utf-8?B?NEpuaUhNOWJqSm8wM0hJMG1JaFUwbGlBeVdmNEhtWTZ4ZnpXNkpOd290OGts?=
 =?utf-8?B?LytjOVI1Z0xucll0MXNMNkJuTW1ZZlZqVGJvSEhSRXZBaGRrUFV0czYwMmtx?=
 =?utf-8?B?LytCclhubFRNUTR4TmtFdmRWbVZmc3phNm0zSkFpUlpzOEZpWmpYeUsyc0RU?=
 =?utf-8?B?Q3RuM0I1QXk1aHN2a3pKTjVKZk5JeGQxcUIyQ3hXWGZJc3VHMTJHRTRnYis5?=
 =?utf-8?B?Q3FtbWdUOEEwTGsxdzhjNThkTnNKVkhjL3dmamY2bnZJNkh5WW8vUVZPVmxD?=
 =?utf-8?B?T3hYL0phTnNCY3pyaXhlRUJOUUdydVdVY2hQSDhjbVdubGRsWFNDSUxHVFZE?=
 =?utf-8?B?RDNrT3hkbzFGNmNRbnRXUk9hdHNieGNDME1SbXc4dnV4WTZMOUk5MFU0RnpS?=
 =?utf-8?Q?q8E8Hg/CoDLR2my3pIa+vamfYlUlyNUo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2s4VEZlYUpYVlpBZTFtdU9kbHhzWE1nOTArdmVqU0FESUM1bnpBd2VZL2lI?=
 =?utf-8?B?c3JWaUtjc01QOERCU0x2djdMV250YWhrc2pqMzVsdWZySUFVYnRoRkZGTm15?=
 =?utf-8?B?SWZJSE9yQWkyb3NNRGhPaWdPQllsWEMyazZpWXlwZXBabmtmNE8zcVlYeXhl?=
 =?utf-8?B?WjlFM2xuYkpESi9KcFZBVTRjZTIxVlJNUi92amNmbGpuMWRRK3hMOXNpbklT?=
 =?utf-8?B?RUlCK3FtazhseGovTEZzOTV4bDdZUERMRkNQUXpSMndrUG0wN3F3ME5abWxI?=
 =?utf-8?B?dXNwZ2dmWlhyZzBGaXVMTVhMSVlIelh4SFBtRjdiY29DQkZvWUxZejRuR2VM?=
 =?utf-8?B?eDhrR21NMk5HWWJadER6N3ZPN0tOMVFhalJTbG0wa1hsc2NSLzl2UXRLQ3U3?=
 =?utf-8?B?YW1aRWVLN01lYXU5UmpLVHlhNmlIczJhY0t2emdaRlBSSHFEdkg0RWh2aHFm?=
 =?utf-8?B?V1BUekJpRlNxZU1uMlhhZENVUGFvVVBWUXR2bDJFZmFmSFZwWStha3N3THRX?=
 =?utf-8?B?N1FMbTZjdlhFT1dQQlJsN2EzY3p4YXRKUjlIckxYajQwZFlmQ20yU1VtMU9o?=
 =?utf-8?B?c2dwaWdCUUFXNVFFYlIxWVo3R2dJZ3JIRDFPUmU1L2pKYmRmeFRyTnZ1S1h6?=
 =?utf-8?B?SWJPd0Nyb1FOaFg4YytHUGJMWGU1VmRPQ2dLdWlGYmR6Z0l1bGdZTFZ4Qklh?=
 =?utf-8?B?bktqMUEvOFhXNlFJNjd6c0xGS2Y4eFdGMUR6azBiVnl6R0wzWHZOWW82Skt1?=
 =?utf-8?B?aFo0U1FhS3BZdElFcnE0R0xWNllwREdIOHNQSWhhRW55WHdteWRGZkRPOCtk?=
 =?utf-8?B?R2VpOHpNS3pwQXVwYS81NXl5TUh5dm8vNTk2aUI1WVlRcm41U2NXQ0plQXRW?=
 =?utf-8?B?bEJKZTY5VVBheWhIRmdMVlJHSWlZZk5uL2xlZDRWeVF2bGRJcVNTYktrYWlK?=
 =?utf-8?B?WGFNbWhYVXE2VkN3QTlVUk5WcHNBam55dWRTcWJpQlB6bzRWMS9wUzg4QTdF?=
 =?utf-8?B?YktQelpab2dIakxFamtqQk9xV2g1aVplcUwySUtRaEVwaUN6ajkyWk5XdEw2?=
 =?utf-8?B?MURoeVp1QjZHbGFHWkJ4Ri82dGRTZ1dySll1dTFtVjhpNmFaV1ZBeWE3SXht?=
 =?utf-8?B?RmxjanZJRjNoRHh5cG5GWFdHcVE5UFlDbUVFRFdRME1sMHY3UUQreVdtUmcw?=
 =?utf-8?B?dVZNM0ZqdUU5MFFsNU9SRGlDVE54SDRwL1lqUG00MWpoVGFCUFNBYXdJaGVU?=
 =?utf-8?B?ZGxqNTltRTk4VmdONHcyb0ppbnNUV0NGc2UwcWMxaDZpdENSYjZ5ZnhBSGpW?=
 =?utf-8?B?eXdwZGJFYUYrZllTMnZCaGtaS3ZJYVFVa0Z3ZCtwSlVSWFRQSjdid3VQSVVB?=
 =?utf-8?B?VDQyQlF4MDBsNzNmL3FJcHhFVy9LZXlsMmRucEVUY1dpaUh0bTJYV2E4Q2dJ?=
 =?utf-8?B?QkpiVGxkTWViMS9iUzVxY3VvQUhqU1FPMXJ2c3RWNXMxNUF5YVByV3dqVjF3?=
 =?utf-8?B?dk0vOEFLL2VHNmVETEY0QVJCaU8wTmZtb1o4WDViZ3VQYU5KSXo1SFJBQUhI?=
 =?utf-8?B?N2dwczR2RXdrYUNJa01FVjlIRWlPbDQrdjVtM2dPZ2M2RWxxdzlnL2RvWXVl?=
 =?utf-8?B?bmRBSXdBTkJBREpBR3J6VjJ4TGpTQklGa0F1UzAwSjV5a0tDMGNNVTZhNmlU?=
 =?utf-8?B?dDd6NEt2SEJUcHd2Q0oycS9hQlhkMGlYTjNtMmVMVDkxWFpVYlNpYXdxQzlv?=
 =?utf-8?B?TllDeUlEaVZLU0NEREhnN3NRK1krMGVDTHp3R3ptKzcwQUUreWFJbDQ4RERl?=
 =?utf-8?B?V0lvRWU4cmNISFJoVFM4QUVEcUM3aGJaYU5yNWJ3eVE0VXNPMy9tY3Y1c2p5?=
 =?utf-8?B?bWhpQ0xoSmZ3SE5qZmpYU2RwUjRPRVIwVWU1Q0tLZW5zWFZ3OGhQdzdvNmF6?=
 =?utf-8?B?cWpMOXE2VnMvNlUvYkh5N1lpOVpEQXRuRHNlWUtFK0xqa3pxcHJ4d2VqeFYz?=
 =?utf-8?B?eGhGMkk0a3pWaHJqMFB0VWZLRkd1QktlWFJFeTNWOW9KL1pwQ2o1Z1pSaEtE?=
 =?utf-8?B?YmJnNndCVktodWxqbCtXRVVYZzhNUk90bTg0WVFCc0RhUUg0YkhCdVRTeGlI?=
 =?utf-8?Q?tAzE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d189af02-ef94-49f6-c339-08dd5a3ef9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:34:28.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsE9YPTBdq216fM7L0avWn+XTLdxrKpjFm22xdFxp7VAvIgWQHUF207WJZIoAlM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOdW5vIFPDoSB2aWEgQjQg
UmVsYXkgPGRldm51bGwrbnVuby5zYS5hbmFsb2cuY29tQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgRmVicnVhcnkgMTksIDIwMjUgMTA6NTAgUE0NCj4gVG86IGxpbnV4LWNsa0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnDQo+IENjOiBTdGVwaGVuIEJv
eWQgPHNib3lkQGtlcm5lbC5vcmc+OyBNaWNoYWVsIFR1cnF1ZXR0ZQ0KPiA8bXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb20+OyBNb3JpdHogRmlzY2hlciA8bWRmQGtlcm5lbC5vcmc+OyBXdSBIYW8NCj4g
PGhhby53dUBpbnRlbC5jb20+OyBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsgVG9tIFJp
eCA8dHJpeEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMy82XSBpbmNsdWRlOiBmcGdh
OiBhZGktYXhpLWNvbW1vbjogYWRkIG5ldyBoZWxwZXIgbWFjcm9zDQo+DQo+IEZyb206IE51bm8g
U8OhIDxudW5vLnNhQGFuYWxvZy5jb20+DQo+DQo+IEFkZCBuZXcgaGVscGVyIG1hY3JvcyBhbmQg
ZW51bXMgdG8gaGVscCBpZGVudGlmeWluZyB0aGUgcGxhdGZvcm0gYW5kIHNvbWUNCj4gY2hhcmFj
dGVyaXN0aWNzIG9mIGl0IGF0IHJ1bnRpbWUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE51bm8gU8Oh
IDxudW5vLnNhQGFuYWxvZy5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9mcGdhL2FkaS1h
eGktY29tbW9uLmggfCAzNQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oIGIvaW5jbHVkZS9saW51eC9mcGdhL2Fk
aS1heGktY29tbW9uLmgNCj4gaW5kZXgNCj4gMTQxYWMzZjI1MWU2ZjI1NjUyNjgxMmI5ZDU1Y2Q0
NDBhMmE0NmU3Ni4uNzQ3YTRmZjU4NjcwOGEzZGNmMzRjMjZlYzVhZWMNCj4gMzQ3Y2Y2MTdiMTUg
MTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oDQo+ICsr
KyBiL2luY2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oDQo+IEBAIC0xMiw2ICsxMiw4
IEBADQo+ICAjZGVmaW5lIEFESV9BWElfQ09NTU9OX0hfDQo+DQo+ICAjZGVmaW5lIEFESV9BWElf
UkVHX1ZFUlNJT04gICAgICAgICAgICAgICAgICAweDAwMDANCj4gKyNkZWZpbmUgQURJX0FYSV9S
RUdfRlBHQV9JTkZPICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDFDDQo+ICsjZGVmaW5lIEFE
SV9BWElfUkVHX0ZQR0FfVk9MVEFHRSAgICAgICAgICAgICAweDAxNDANCj4NCj4gICNkZWZpbmUg
QURJX0FYSV9QQ09SRV9WRVIobWFqb3IsIG1pbm9yLCBwYXRjaCkgICAgICAgXA0KPiAgICAgICAo
KChtYWpvcikgPDwgMTYpIHwgKChtaW5vcikgPDwgOCkgfCAocGF0Y2gpKSBAQCAtMjAsNCArMjIs
MzcgQEANCj4gICNkZWZpbmUgQURJX0FYSV9QQ09SRV9WRVJfTUlOT1IodmVyc2lvbikgICAgICgo
KHZlcnNpb24pID4+IDgpICYgMHhmZikNCj4gICNkZWZpbmUgQURJX0FYSV9QQ09SRV9WRVJfUEFU
Q0godmVyc2lvbikgICAgICgodmVyc2lvbikgJiAweGZmKQ0KPg0KPiArI2RlZmluZSBBRElfQVhJ
X0lORk9fRlBHQV9URUNIKGluZm8pICAgICAgICAgICAgKCgoaW5mbykgPj4gMjQpICYgMHhmZikN
Cj4gKyNkZWZpbmUgQURJX0FYSV9JTkZPX0ZQR0FfRkFNSUxZKGluZm8pICAgICAgICAgICgoKGlu
Zm8pID4+IDE2KSAmIDB4ZmYpDQo+ICsjZGVmaW5lIEFESV9BWElfSU5GT19GUEdBX1NQRUVEX0dS
QURFKGluZm8pICAgICAoKChpbmZvKSA+PiA4KSAmIDB4ZmYpDQo+ICsjZGVmaW5lIEFESV9BWElf
SU5GT19GUEdBX1ZPTFRBR0UodmFsKSAgICAgICAgICAoKHZhbCkgJiAweGZmZmYpDQo+ICsNCj4g
K2VudW0gYWRpX2F4aV9mZ3BhX3RlY2hub2xvZ3kgew0KPiArICAgICBBRElfQVhJX0ZQR0FfVEVD
SF9VTktOT1dOID0gMCwNCj4gKyAgICAgQURJX0FYSV9GUEdBX1RFQ0hfU0VSSUVTNywNCj4gKyAg
ICAgQURJX0FYSV9GUEdBX1RFQ0hfVUxUUkFTQ0FMRSwNCj4gKyAgICAgQURJX0FYSV9GUEdBX1RF
Q0hfVUxUUkFTQ0FMRV9QTFVTLA0KPiArfTsNCj4gKw0KDQpUeXBvOiBSZW5hbWUgYWRpX2F4aV9m
Z3BhX3RlY2hub2xvZ3kg4oaSIGFkaV9heGlfZnBnYV90ZWNobm9sb2d5DQoNClJlZ2FyZHMsDQpO
YXZha2lzaG9yZS4NCg==

