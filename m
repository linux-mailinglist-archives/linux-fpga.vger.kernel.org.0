Return-Path: <linux-fpga+bounces-530-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351408BC924
	for <lists+linux-fpga@lfdr.de>; Mon,  6 May 2024 10:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D413B2177C
	for <lists+linux-fpga@lfdr.de>; Mon,  6 May 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4150A73;
	Mon,  6 May 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xj/QO4Bg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711C3D76;
	Mon,  6 May 2024 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982943; cv=fail; b=JArfzQaZjWaZvBYlTq2fIXYF3jYxnap0DwCePrBFDoDdLlMLk05+ur0xp61EybOH5hu85pSwMFV/gmXgas4fzR8Y6nrEnWDK8q8PU1ABaEbbdkhNvLbQGp8jJCLtfuyFkTKTpT5ILSa9ey2B9SvVdG2H+iD8+dJC4Agct6ZWe50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982943; c=relaxed/simple;
	bh=PwGWd2Z8926v8NqjA1hRTHV2q2WxkXT9E16yBgb3Uzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MudRw20bth+5jzo8AAfVVNTXxfWvAVD6ausrqU6cH/z/qmRqaKmXSJLI7pYBiOGEUHtCLEmYT1poPDYL7ZCaat0WKCSXJ9pUV7dGosiOOs3GRaEGw9nrz+xnKYMA6GaQ1LXsNtFLWsTuq9mc4xHqw6Rt/965rQQXO2+MRER209U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xj/QO4Bg; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLoQ14LKlJIY61MG/77WGt7jl+sq11fMK6m4/ipJYmwCotIWLMT08s5hjIYsupf6WzKU98cqB6Lf3/uTBYg7hcVm8OQRPXaQl9UYGoze7AJGsEcVJTRVC7r5siH/rhOSF2q8f2TOD3VGaTA/JUCmoAi4yYR5aDgklAssV8S84ZaPFcFr+hQQs/AC5ulNaH6X63PBjyDB9iEW9yKcm5wmH8jjWE+u7FGZ/M4tgvaZMDVxIzhYFrAVNp6n1mR2mEFqs1IbMmJcfb4BGunmxp9ySNcqOw4PKjZCgvuJIF3SX4qhaJZbzW9myUFLqomMLXwPSFhMkHtbUD/Gc0lVIrmnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGMPjqsbizEf4Jos7MzzFpyTju9+kZ8hx6rCAkzQxsQ=;
 b=W8bzRiE0eCbUFL+wsC7XitLsjssLQUUc4qhPbCza4s5abauL4nmZ/GT4vUno2HiBmoSuwgbWeAYnf26I9NU08AQ5W4cERp6B4YSa+rOh8VYaofDtSBhghfvdMwCvEF69AfC5zHVkKqJyqt2bWxgNb2VfGj3IcIDI9Ki7gmXhYuOk19SGCBzUosGuhCUZp0BUvLcT/lyPEwcusn6Y8wM7qsh+KzSboh+/9FRvOGH5gKDeFXZlGscTk3LaMPisW37+2O7cxNSGcaaVb96E7EThCkoAd0hT25wLROHmW+/+pXO/5XMgAkcJkx6OsV4a12bxhDeRlWKu6k5LcTp49Swdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGMPjqsbizEf4Jos7MzzFpyTju9+kZ8hx6rCAkzQxsQ=;
 b=xj/QO4Bgm1TTQ2G6eYp+qngQUVewMQsHqVh31U8murZq7r4MfPvbS/5JS06IEFN8A5zgzFk/yTACvZw56wvYySWfoVKLHJRkyaMb0VD8ZAxdSLcNzW0mpS/0nxeUoNuBe+Ftql4Mn538aEcl46gRl+9/iXx9g4vBXMjQZFeqF5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9109.namprd12.prod.outlook.com (2603:10b6:408:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 08:08:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 08:08:58 +0000
Message-ID: <fcff2634-21ba-4fe8-bb96-2c097adb0656@amd.com>
Date: Mon, 6 May 2024 10:08:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fpga: zynq-fpga: use 'time_left' variable with
 wait_for_completion_timeout()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-crypto@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240502210038.11480-1-wsa+renesas@sang-engineering.com>
 <20240502210038.11480-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240502210038.11480-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 430ddaf0-7829-42ba-8677-08dc6da3c7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHEzVW9taVBKMUVSZDlBMUZwT1BqWGJNdVpjbElYcEpSTjBQeGQvQ2pTREpm?=
 =?utf-8?B?NXdmRWV0RElHZEdvRHFMc2tTZXpUZ2tJcGtySXl0cmk5VjJxVmpBdklVZGhP?=
 =?utf-8?B?eDRHWGNyQkVsSzFITzcrQ2J2NFhObUo0SnY1Q3VCY1NJYWhXc2xJeUl1Ykt4?=
 =?utf-8?B?ZlRBenorSDZSdlRWUDdlNExFTnJ2Q2plb1NPQkR4aXhOdUp0eFUwRjlBN2xn?=
 =?utf-8?B?Sy9keG94WTEyTk4veE93cURjaDkxUWN0SFJkbkkvbFFQSEpUeGYyUzBuWTFa?=
 =?utf-8?B?R0NSYkxhT2Frb1duWWhKUWEzcDRqdGJTNmhLTW1UV2UzOUhWUVZMeS84MU9t?=
 =?utf-8?B?WTRQeDA1RzhwN3FEYnB2QXV4L21vU2V2eFFEdmlPbCtWQVhsOWdkUmNOYTda?=
 =?utf-8?B?aC8wbmwyQnMvbWEwcUJ5UU41cG05Um9vWDZsN0E2cU4rclNtUmN2SUpZVUVs?=
 =?utf-8?B?WkVFRUM4VUt4Tng0VW91d2VNQ1MvOTBTTVFROVNpdXkrOEVkSmQwQmRZcFRy?=
 =?utf-8?B?QytBMGVzN0JRcWQwdFhsSmo5TTRhTUVQenNibitRdmFaTmVGVy9NUm1lZDhl?=
 =?utf-8?B?UmVqYWkxNkxUVmlsTExNbG1ERjBxMU5LZVNoeTRzbGRSZmFSRzVLazl4RWtR?=
 =?utf-8?B?Mm1LaU1aTzdTRDBOWjhtQUh4QmhtSDM3NVhwai9LVWlTcXduNG1PRkUxQXF0?=
 =?utf-8?B?YU8xR1FNWVNjc2ZHU1pNMnRWTUI0aFRXR0hSK3RaM3p2Y2lmSXVCR2ZVK2RL?=
 =?utf-8?B?Q2NNdUJUdXdkQ2FNZ3BBbXpBZU5WejhOQWZaOG9qaGxmWGhnQno0eE10KytJ?=
 =?utf-8?B?R2ZwNzk5VGxwUHFBdzlReGlPN25UNHFnL2kzQ2FaSUMxQmlwWlZnSlRrb001?=
 =?utf-8?B?UzhiVGZlU0dOaDRVa2dNVW5GdFJubVo4aURRT3ZDTi9EaUs5YkRJeXZEaXVj?=
 =?utf-8?B?QnJsdWYza05OWWRvcWJJeXcwcks4L3FGZmR2V1dVdTZJZFJsS1NOeFV1S3lr?=
 =?utf-8?B?eE90MWJKRmlZZ08rbUwrNis0OXZnNEVWNllOZ2J1c0g0NUN3ckZBejRtb09s?=
 =?utf-8?B?aXo0TkdrNXF4NkYvS2w1Q2YxR1d2RzVzWmVrcHM4d1dZQXF4M1V3TFB4Wnls?=
 =?utf-8?B?cnhKR0RMeTNSeC9jQXkrSjBuZUZkc2p4cFNRdDJEWUZWUzhKVHJFYktlZytu?=
 =?utf-8?B?M21OQ1RNaGZJR1oycEdKNG9FOU92dmdQcjFKV1RBdnNPc2k3MTUvekZ0ZkF0?=
 =?utf-8?B?WUNyb1hBcXdZT05WcUpvQ0ROTWtMN2N5SlV3S2dpMDg5N0JTYU1RMnUyRUxl?=
 =?utf-8?B?ajZPNU9HL2NsQTRpd0RZMmVSLzl1Nk5oT1VFWXEwMjcrV0hjbGVqbmFvenNH?=
 =?utf-8?B?NmtkUXZwMCtPbG5hY0x6Z1ZNcm5RMjBmNUdMMVZwSnpBVHJxOUxOSXlkc3ZB?=
 =?utf-8?B?R1NidHcxNFIwS1dPQ0ZQcHV3Y2FLQ1p4UUdvRHlGdmlmK1ZwcmQ2UlJnUmhU?=
 =?utf-8?B?SThGTUpLZTFpMmlZZEVvaGtNUjRLL1YveW1RWng4SEtCQzQwaVM5QURuL05W?=
 =?utf-8?B?NER2cTEyMktLUHByRzFLNHVzKzljTnFtWWVsczJrcFJPVE9KR2h6VncrQi83?=
 =?utf-8?B?NlVxYmlpc1RHaUV5NVlOVlV4cDZyMU1INTNhRFd3TWVtUllUU2MxSitRMlNq?=
 =?utf-8?B?cEFwVThPK0NLT3puTmwzbktZcnRqdDBOZGs0R1FvWDRQRm9OV25GY01nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2RyNndIcFY0UitKZDZUVTNZQStEZjVOUHVjTXFXWmxOTkM3OXhtQVZIN0Yz?=
 =?utf-8?B?MnFVV1hxY2NmTUtxc2hIQ2pnUjE3YzVuUGhmblpDbHNhRW10Sjd5cU1DWUdR?=
 =?utf-8?B?VUQwSTdDM3IzNFg1VmpWbDlONXh1TCtpQmlMWXEvNFZkcHdSMUErVG9NSnA5?=
 =?utf-8?B?ZUhpOXNVazZ3dkZxejBPYVQ2dm0zYjZhYzV0WGpqREdPM0NjVDFrVmZrZlZP?=
 =?utf-8?B?bWFQTDI2alNlUjdtbEY3Z2Z2MWVhRytneDV3Um4vWk5ONWRGTmhiQWNQdzhn?=
 =?utf-8?B?VVRldDBvTE5HemY0aGpYT2JWcTQ1Z3BUTjFubVAxM2Y4RFlnWnM3V2dXYjNv?=
 =?utf-8?B?Ny9qd1d6Z2w0MzVFcys1Q01xSXhTZjF0NENHeWN4MXpPZExrK21jV084Y0ZO?=
 =?utf-8?B?eWxQMHU2Z3BONUpOc2pnU2JCWkdDWUk0SGFPSmc0Y3lCUEszczIzUXRNdXpJ?=
 =?utf-8?B?TXZCYkoyMjd3T3pqYk9GM3ZRdit2T0xpY2hGTWNqVWRhOVk4cUw4a3JSSTIr?=
 =?utf-8?B?NVpqQ3doSFdLUlo0MFMvZUlQMlV1N0xjdHd2Rkx0RFFoa0J0RkhPUWIyUWRT?=
 =?utf-8?B?YU12YnVqMm0wb0U1RFd2UGtMeEJGMm4xUlh2cjJiQkdoSm9wU01mTkxZNUVw?=
 =?utf-8?B?TjZlTjd6ZXVxMHlRajgvMUwyTVQvZjZaRExBM0ZXbWNTN2hZSEE2WU1YSFd5?=
 =?utf-8?B?WGNUYXc2a05BSGx6aWVPQ2VPeEZ5Y0lUSmVOeHJBU1FmTTRETTRmazYzZjhz?=
 =?utf-8?B?VXorM0xCOVVhd1R2S0pWbE54UVZYYzVvQ2dzRXMyZW5zVHdsRzFKU3Jqc2xk?=
 =?utf-8?B?bE94UWNlRzk2bzVHRksyZElzdzZUdHFnZDNHNkQrOG95ZzhDcW8vM2loSnRH?=
 =?utf-8?B?ZldEQXplSDZSYnZqcEc2ZUYzV0IwUkFodGcycVRZM05HZStjVXE2WnVIVUEw?=
 =?utf-8?B?OEhheVlxc09yM3V3NENXVnlpWVErdGo2cTV0dkZHY0xCRWtHQVdjY0xobW0w?=
 =?utf-8?B?cEZ2dkRoMk9uNkF6N1pmcFkwOFZHSkIwdVFwZUdqeXd5Z1VSaTNDK2lnbHMy?=
 =?utf-8?B?Vi8zTG82dWlER2YyMUgvTkJIVTNnUXpRVjVJeld3dUVPRkpFMXJkT0FndVJI?=
 =?utf-8?B?SlcyRDI3VTI3T1hFc0xqVE95dERpb3NMSDM0YWJxNzJoZ2lzQ0lXMWJIWDNo?=
 =?utf-8?B?SFVRTDZxTDhSaEZaTGN0bHRJME9qNVZRZ25oV2ZzRTF4WEdGRGJnMGtFMFlm?=
 =?utf-8?B?K2NXeG13SXMvaktxN0wwRk9OSjJGWEZ0L2FSa0RvRGRwMXlrMHFtaEh0NnZO?=
 =?utf-8?B?TlpmeG5EakxXeUJSSFpveWZwa1lGNDR1MFVqOWtvK2RCdkkwOHI2YzlFV3pt?=
 =?utf-8?B?Skd2N3BvcC9QZnN6QXEwazR1VzNuZUxvaWdoT2pWVks5YUhLNlFsMGE2elho?=
 =?utf-8?B?QmxDaFRwODFQZG1oMlo2bDU4bmNKQXE4NDUxdXZPV2NFbXZCNlZTNVJpNHlT?=
 =?utf-8?B?cGlod2hUUDlPVHNmbWZDR0dtRXV0ZFJudG9PVkxveEtTazBZcXZ5RVVJVGNC?=
 =?utf-8?B?MUQybURUQW9SOVRib1pPYVNaTHJGQUpoS0lEaVNnbm54YkI5Q0xSNEVER2FP?=
 =?utf-8?B?QXdNdnYvY2ZkSC9EQlZwMmI2aGJsNmtYNks5YzI4WTVubk8raktuRktaSm5J?=
 =?utf-8?B?Z0FxTFFIZjlKdkVjVXlySnRqNytVSHpnSkYydVpYNFhKcHNIVzJNZE02anlI?=
 =?utf-8?B?dVJWcDZBa0RQMjNjMDFmSXI5bHVKc0lhczkrQkFQRi9nTDB5R2xXakJnRWUy?=
 =?utf-8?B?cVdpbHNHUzBZWWRxT1VOWm9PUmFiY0daVHpwb3RLU3dKQytoZ21iVlIycWUz?=
 =?utf-8?B?SU8rMWpkcFlwT01ydCtkZ1dJL2RNVTI0OHhqaHdmNWozaHpRR3N5dTNOaTYw?=
 =?utf-8?B?WGE2dHJJempGK3Jmam1GS1JmVzVMa2g5bFoxNmtWRW8wQWhnY3pPYzBVM0tI?=
 =?utf-8?B?SytvSm5FbFBad0xrbXdENTFsVi9jZEw2NkZUTnFEMUhtSTVVNkRxUFRNa1lT?=
 =?utf-8?B?SENvalVWSmViMklsdCtZTlcwVmRJWVhnNVNSTlFjL3pKUUYxYUU2WkJUM28r?=
 =?utf-8?Q?zr7djLCe+ilOY/uiD0hAPeTwW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430ddaf0-7829-42ba-8677-08dc6da3c7ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 08:08:57.9338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlDe+YME2YxiPdymKY7JU6NC4QGplQQE/1xSk1rqr3skqc+z6byJN+FxzK0S95LT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9109



On 5/2/24 23:00, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/fpga/zynq-fpga.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 0ac93183d201..4db3d80e10b0 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -387,7 +387,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>   	const char *why;
>   	int err;
>   	u32 intr_status;
> -	unsigned long timeout;
> +	unsigned long time_left;
>   	unsigned long flags;
>   	struct scatterlist *sg;
>   	int i;
> @@ -427,8 +427,8 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>   	zynq_step_dma(priv);
>   	spin_unlock_irqrestore(&priv->dma_lock, flags);
>   
> -	timeout = wait_for_completion_timeout(&priv->dma_done,
> -					      msecs_to_jiffies(DMA_TIMEOUT_MS));
> +	time_left = wait_for_completion_timeout(&priv->dma_done,
> +						msecs_to_jiffies(DMA_TIMEOUT_MS));
>   
>   	spin_lock_irqsave(&priv->dma_lock, flags);
>   	zynq_fpga_set_irq(priv, 0);
> @@ -452,7 +452,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>   
>   	if (priv->cur_sg ||
>   	    !((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
> -		if (timeout == 0)
> +		if (time_left == 0)
>   			why = "DMA timed out";
>   		else
>   			why = "DMA did not complete";

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

