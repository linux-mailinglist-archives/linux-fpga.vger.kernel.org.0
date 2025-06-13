Return-Path: <linux-fpga+bounces-1244-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52530AD89D7
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D993B8BFC
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F22D23B9;
	Fri, 13 Jun 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IGGOHP/d"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEA2D5C6F;
	Fri, 13 Jun 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811985; cv=fail; b=A1cRxXys+f6RZU+4T8YXyEsC1HV/hje1yAotwbYUrveh5VZe4/65TydSglHBmp24lt+00jo9tlCdc8fiu9syIjUDReYufMEp5uhyGZyhw0l0p9eLAkUwzEPJwKc1WiBoNF3PBGfjB2ccr/7KayQ+HQsNW+TUpluXWR+sXutDJws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811985; c=relaxed/simple;
	bh=VYv3hWlKTFhX+xgu+O4EkvykcwcVJHRClxa80x8gMf4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPW2pv0mtMGZ0z2PljMVjW6k4+9YhK3ZimJA+Thd0if2G+Jfci3T/ZWvChSdMeT4q58BIrcu2Rmzt025+ihqbmytDIBWKSnGEGWyqtk09KzrUU3kLn0YvXXY7TRJUrQaJ11D7wMWSQPXulC6AE1vN6RTzHyAkjixd9G7zXMkG1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IGGOHP/d; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z003DqVz+36koF9Od82RaRqp+IFWKKt2pUfvcPPSF02elKi0x5qMRU3a2S3L4OXcIns8dMG14oOKW1p6kfHyL38JvQ4SgpSrhDti+WyZQ9uGf+QSXfrYocZ6vVSocmvOLxVyt/AlTGO4624God6bKd2D3cd78uj3jWZxFcXk1nYZL0//lyxqmQ1pKyo+LBWIXJ8YnaDyG55cQmK+rG1OqA29yRNkW+BDpqgJvMM9Bl4OWmGuly4Lv6YxoIfwmZs2185nFU8Bzl+Ci5RMo/LQoVp1+RXY/zqqngU8wzCM9eCYfXuisWcrY+5iFo6f/6Tv8dGyGOgOMePiyjLJ3nk0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6txDdq9yS1gMwThrZni48+FFdQ8LviglGIPtyNz5Gc=;
 b=CrhLCAGvoyDygdo/+9jKcvfphf9f5BDLfbR4vumHs2Hzv+yBxCHqriqDBGpd21MoClhVJiXEQhOlp+opY9rk24GN4gfeDsxT67zXQALKjA/vHRZjqc6Qrwz0xsJ8M50vE6Z0FC35y6sQoORxD7eUpIBY0LFthBb8NuomSFtwNdAbIHl5OgTWFWfnEZ6vhhukwiLj2LYl+URUfO1pmobZqh/2Zz6kwRVApk2lCGKUNjswxSVj8JTfMBnnXNB73E78TzxaDu71tZDs6BBuhY0nh+lPOCUyIeKVBWQ3TDeIxxEij6Z3upO1LDeYG8sKZS894PNCL7tW6JyvzitRDQ7k1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6txDdq9yS1gMwThrZni48+FFdQ8LviglGIPtyNz5Gc=;
 b=IGGOHP/d9/cVkfJ2icuT/auURnvxf41yOMBqEOxhgN3EAwJYfx+fHNImWt/19b7GeHwCtk70/RANgKG4z6Nj4TGtkEHwBdwQtrjqcoj0ORMJom0kDD0pLtphNeQFfAY3QcedH9wGfUClHrDZQ3US3T0IQ5VqA1vt7GOKoGzn7ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 10:53:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 10:53:00 +0000
Message-ID: <712b690d-2fcf-486e-87a1-17e2354d371f@amd.com>
Date: Fri, 13 Jun 2025 12:52:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: Also describe clock for gpio
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 Rob Herring <robh@kernel.org>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
References: <8407ef56b11632c1a7abfce8a4534ed8a8ed56cc.1749809570.git.michal.simek@amd.com>
 <aEwA/pFuvbP+acSY@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <aEwA/pFuvbP+acSY@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7a7e1f-2a79-4c76-bdde-08ddaa6876b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0JPRndxTzZ2M1lUemEwVkRKMlA4NzJnazZTTnRVY25LRWZhYUN1ZDZtclk0?=
 =?utf-8?B?bHd5TmI5cmlaNmVQWFp3MzRnNVFBbnNHYzBDcG9ua2VnWDl3Ynk3OHBjcHY1?=
 =?utf-8?B?dVE4L1hnTVEzRXJQVXpmdGxtdDdndjNJMTd1Mjc5TGhrN2hpRWxtWWxXbkpq?=
 =?utf-8?B?UG9mUXVFMVpRSld3b25ITGtvZWFvZ3k1V2VDU1hhR09UK0k1L0QyeC9BWGd6?=
 =?utf-8?B?ME43ZVJDcFRGbkhEZ2IraEdNalFkRlBnTE5aYzZSTnp2c292VGgvZUFRcmVF?=
 =?utf-8?B?blpWSzFiK1ZzTEhsQ2FaMWtjdFdNMWltVDVmd3FSdUdNaXVzMWtYNE1ZVFA1?=
 =?utf-8?B?S1VwK2E3bDVkaTIrbVZrS1U4cEFPSHUrRDBDZnE3SG9WVjlOWTlhejdENDQ4?=
 =?utf-8?B?UTB4SXQwOUR2Szg0Q00wTXgzaFAyTm5DYVRmUUdYaXowNnhDMjdHWTE5QW9i?=
 =?utf-8?B?TFRpcmxkRnFwUThOckFLa1M2V2dQY3RRRnVMRktod0JxRkFORHdwUEJFYTZN?=
 =?utf-8?B?NTN0WEJ4VzQvK2MwUXVYVE1YT2g3elFOWjBRRWk2UDBhekVWMUMxOVhzOWQ1?=
 =?utf-8?B?RjZOejU3dWRPTjMvOXIwWGpVeC8vbHJoTS9Bek1wU2VYaUFrSHJ2eW1JNkZE?=
 =?utf-8?B?VTQ4MVBPVzJmNDNXcEJCR3llQ0tHYWdZc3N5eENkUEl6OUpvS3JacmtYYldQ?=
 =?utf-8?B?RjJXa21JTlB3a2Y2VVpCQzk0MHVuNlZONU5xNGhFVnk2VE83ZUl6TWNYb3Z6?=
 =?utf-8?B?NVJkT09SaURKbmFaOC93S1hMcjhlUkxvOW5GWjJYcllrMWJaRlJJQjRBeEpY?=
 =?utf-8?B?d2RGNXZLZU5wWXpaM2hNU0pFckpxQ2VocVYwYThMdzdKZjVUeVJvbHNUUGxB?=
 =?utf-8?B?eG9GWXNBZnUyeHVXWVdNZTcySDN4WTVZRFBIWWlJY3lrbldxVWJQcWJmbTZn?=
 =?utf-8?B?K1kwVXQwN1ZDeGQ4Y0dGcEtzTDVXdHhqY2VDTWFHMzlSY09ZMnpWbUZNdEtE?=
 =?utf-8?B?NnlzNWN0V0Q2V29OYkdhTzZkTFVxU2pnTXlXcWhOVG9oMEVBdUhYV05ZendS?=
 =?utf-8?B?T2xpUFhRcTVPTWhPSldsK0dmZFgrbGVvbFlBQVBuU2lQeFdXbmpsNDFGOVBh?=
 =?utf-8?B?K3BCUFhKckl2TjZSdG9HTGpuYVJ5ZTlZTmd2Slp4d1Nvbm1FODMvMU9jWnZ0?=
 =?utf-8?B?c3JMb3JqU3BHY3ZQRXh6Q2c5OG1jZXpMTzFWdUM5ZVE0YitVUzNzOWVPUlVT?=
 =?utf-8?B?eDU5dkJMTTZPSUdKM2toVXpHVVQxTG45bnE3S2VEYU4zU3JUWkszRTFCYlE3?=
 =?utf-8?B?Q0c0ZEcrVmVOQXM0M0VPQlAySHdxRVVGTExRa0Z4V2VvbU8xQnkxN2U0OVFU?=
 =?utf-8?B?a2dqQVQrM2Rwa2ZFZk9TVHI3ZEl3UWJqZVpUeXZYMmpsZmc0cldWTGl2d0hB?=
 =?utf-8?B?aFZ1WG5TWm03YWd1VFdpVHlhRS9yVktwb2Rhb2JUSlJNUVdDY05ZZTlKWS8r?=
 =?utf-8?B?blBMaTdHZmtBM0RJTW9haWdPdEZyS3VCbzhkZ0FCZjB5L1YrTG1MQ3kvRlFa?=
 =?utf-8?B?OEhpREIwOG5hNVluNFN0TnFRYlVVdmI1V2JBM1doUkhadXlRNWpRbW9QRWVG?=
 =?utf-8?B?ZlVWY1NJR2NvOE92RmV2OUdSYTlPa1VXL0Zka1g2WnJ2Q3V4VVI5OTNRT0Ur?=
 =?utf-8?B?UFJwSlFoakFreS9kOHNNZVdYczdwYzRaUmtQMzdBdGNZRTVkWlBSMzdjWktl?=
 =?utf-8?B?WDlxeXRIcW0yT3dyNnBTM3J1Ti9ZZVdFV3NIcVVtZkJHSSs0cUp3VmxxRW92?=
 =?utf-8?B?MjNNKzNlVUlUd25XNlhTc01IRGNub1ozbVljeHBsU2xGbHZvUW1pUnRJRFB3?=
 =?utf-8?B?RTZPL0ZnV2pHVUxLTHFGM2JCN2xicGV5N1lmV2JHdmZGbzlxd24wa08rN1Fx?=
 =?utf-8?Q?yRvVR80JHXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzNlbkgzaEV5Y3RRQW8xaU1HSWpoYlF2MzFXNlZhczZKWDBGMk5kZWtHRFpN?=
 =?utf-8?B?Qm04WEloanVWdm1UbXhoRnNkT1NwK0Y5TTZoVjBQeHliZmZIWnE0VnpNVmZY?=
 =?utf-8?B?ZEZyTW5aZ3pmZDFLcXJ0bTMzQXcvdDQ5TlByMkRNRm55eHRHbDZQY3kxK21M?=
 =?utf-8?B?YytycDliajZ4SkxGSGxKc1Bwd2dDaWdCMEQxZzNRdmR1SlZ4NUpvN1ZEd2ZH?=
 =?utf-8?B?MTRFZEVIMG5LcHpJdHlaRTZkR3c5U1h4bGVCVmJwQWxHbW1tWk5pa3JaOUtU?=
 =?utf-8?B?aFVGU0dWNm9KZ0dLN3g4Ynorc1NYdkdORFpmWEU5WHJYWEtwbHRwdHcxUzVj?=
 =?utf-8?B?U1Axbld0ejhnc0p6LzNKWDg3NjNlalJ6UXphYys3cUJRNXZ0Vi9KcExDaytU?=
 =?utf-8?B?bFhxRmRRSzVyZ1pMdTk0RTZoTk80bVhPeXhZNFN4cllkYU5tc3JLVk1ydHkx?=
 =?utf-8?B?RUJnd3prbEs5TkY5TmI3c3l1TzZ2Q0tUWUhGRHVLdE9HNStObFYyWnNCS2R4?=
 =?utf-8?B?RW1ZMHluNVIxeHRFT1M1aVNTREF4eExxTm43YXVoRm4vcUVBME5nUGFuS3Jv?=
 =?utf-8?B?Y0xUTGpHc2Ewc2Z1VFM2a05UclJTLzQvSVNrd293V3YreWdROUZ3R3V5RnBQ?=
 =?utf-8?B?R2hWemZQanAvNDk5OXVBTlFqSnBNUk1zZlhTWjdVQng0cHY0TFlUSXdCdnRa?=
 =?utf-8?B?SzlEUnRaK0s4di9jYndRcDJJSEo2dnliM3hLR1g3czRpRDYzZFBnenNhaFhl?=
 =?utf-8?B?cVRxVU15N0VHdXpONm9RTmxMTHpTUlVsRUhRaUNsVmlBMXJnNDRkenZRKzlp?=
 =?utf-8?B?Q3RBRlNiSWoxMUMyWGVjVDJ5VzFQU1hzQitnQk50eGVTVDhUZzA4b2k3Vkxk?=
 =?utf-8?B?VW9hdUQwc3owVWFoczg0Q1ZvNEJlQWVmNFpscXpmSFNBZW5YQk9MckhtTVF6?=
 =?utf-8?B?ZUJTcUxsTnFwbnArQXBXSDdYaVhtQkM4STBycVZyTzlFVFE5R2pZS285c2RK?=
 =?utf-8?B?ODhKVnVDU1hjcjRWUUlkcHBOSVpTb0JOcms5ckNHc3ZWdENuT1RmM3E3emVu?=
 =?utf-8?B?UmZTRUlVTXJtaEVKdzBsc29NRzZlb1B2T1czcXE2elNydG9PS1orV2p1Mk5s?=
 =?utf-8?B?d0lwT2hmWjhiRkZ5MlZKRCtQV2JDeEFpb2ppbnlrYVBHYWJReEtZTmFuMlBG?=
 =?utf-8?B?elVHMCtjQTJEMm5uV3lTS2NpZTZ5N25HeWpOcmpXNDlxNk96SWZiZzRsR01G?=
 =?utf-8?B?Z05mSHhjZFpaaHcyNlZ4R2h0akxPRS9TS1loSTZWU045cU8yTjFnRTI2SW5m?=
 =?utf-8?B?NDBmQStvTVE1aU56Vk1KNVlNNjNRMEZvd2FzbEhKUzk1eWgzc25idnpIaVZt?=
 =?utf-8?B?NXdNOXQrN0U4akJZTFNGR0lhcWwydFhKVkZUMk5JWkFCSDBZRW1SMWRHMkZi?=
 =?utf-8?B?dGFlWVUyY2JLMmhrSGlqRlhjbU9YNG10dGxucUI1REh3MTJzbzdSbnVhVi96?=
 =?utf-8?B?UUZ4WWlHN3RNT3htUTVycER4aHVoTGZ6amcyaDFrcElRVjNwdllwM0ZIa2Jh?=
 =?utf-8?B?blFhMmJxMHlDdXY0WTlXNmhsK0JtZTRZb3NybVBmM2xySkp1TmV1Z0tCV3Rl?=
 =?utf-8?B?K2xCQTZBZkltaDlDSXd2Rmtxam8vRWVLQW8wUk5xYTBrYjZhMTkxbHdod09o?=
 =?utf-8?B?Wk5uSzY3VFpmWm94MWxqdXMrbHN0Qko0UWJtVUtpN3VlVTk4MWNlalRKSUVL?=
 =?utf-8?B?WlJkWFZXOVB1ZjNoVnl3U21SbXRUcmpCdVFra29oZ2plS2g1dFNnV0RoNDVG?=
 =?utf-8?B?L1lQZU1zMkdsVGZwMTdkWExQRHdHbXhqMUtnSVRlUGNoVjkwMU9VNEh0MU05?=
 =?utf-8?B?SEFReWJrZUdMa0hhd3dUcTdzcmNHT2hJVjd3TlZxL1kwSmxMV3EwU1lQbjdl?=
 =?utf-8?B?dDBiTDJiL0hPSENMMHB6ZDZRSjBNNC9aUENBVXh5WHQwV1g5T1NsWVFwdUhi?=
 =?utf-8?B?SkIvdUVjK2Nia0lrSVZzS1o5VElEMFhoTDhZcU4zbHBkMzNWOFZiNlgvcW81?=
 =?utf-8?B?QitvbEU5NlhWMkFuQTVLYlZ3Z2F6Z2Y5K0lpMzZSMWxMUW95eUdMT1RHdFov?=
 =?utf-8?Q?bPi471sGGaP9Uj8w6GlL0weCY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7a7e1f-2a79-4c76-bdde-08ddaa6876b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 10:53:00.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57t+zanuPPrS3hdMFRIBRSrMIP8F2KJZlOIVs2bZR6II4muq4INqbhISJtcLrbKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657



On 6/13/25 12:44, Xu Yilun wrote:
> On Fri, Jun 13, 2025 at 12:12:52PM +0200, Michal Simek wrote:
>> Axi gpio is going to have clocks as required property that's why it should
>> be also described in bindings which are using axi gpio node.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Changes in v2:
>> - New patch to fix reported as issue by the second patch
>> - https://lore.kernel.org/r/174954437576.4177094.15371626866789542129.robh@kernel.org
>>
>>   Documentation/devicetree/bindings/fpga/fpga-region.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
>> index 77554885a6c4..7d2d3b7aa4b7 100644
>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.yaml
>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
>> @@ -316,6 +316,7 @@ examples:
>>           reg = <0x40000000 0x10000>;
>>           gpio-controller;
>>           #gpio-cells = <2>;
>> +        clocks = <&clk>;
> 
> This file is mainly for fpga-region bindings. So I don't think we have
> to strictly align with the example IP block binding every time it has
> an update.

But Rob's script are reporting issue if they are not. Please take a look at link 
above.

M

