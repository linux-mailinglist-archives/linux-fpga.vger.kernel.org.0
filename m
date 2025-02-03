Return-Path: <linux-fpga+bounces-1033-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E03A25800
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Feb 2025 12:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2247D1883E09
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Feb 2025 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCD4202C3A;
	Mon,  3 Feb 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Z7xb47m6"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795F200BA9;
	Mon,  3 Feb 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581754; cv=fail; b=dwcsWN+FVMHttySzRJV9VOXBuPLV4UKMCP5Hf9ycsJZv9gqTT65hqzE4ihPP0339KkK+IXBtvWzp597Q5nDxt03yL3WsHRmK86As6vVhMRxVh7auFYMlmZkXntNX5AOieTeA6L6tjM0flWLDAicLAOkpDv4ctX/8Ec/rekd6sBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581754; c=relaxed/simple;
	bh=S+l3s4CcK0WVStS3bvcuvlW9U+BhA7lEoAagsJ1HiOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mdgyv5mJ2N09ZCdu20s5ktc2vylHXiDzV/1zdnPivbjwDNjoQiLVyrC2c2ohbictv0IoW3hs9zjl2sEq9Xkht12GiwVwqlKd+VZhzWz/MIokPVdW/vUyRjOwjAEIXib0kUrzaVxEooZ8ziJjwGTu9rYELB29dt84IxfxQaIOVYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Z7xb47m6; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx7dBKxEaR4vV/48na3tCpMKQl6NJR2ItyLgmOzuySuC4S5LLKdOoPraIuR7okNheOESucOSrB931RQxGjGGEqG+5L1N8irTP1eYPnvsAW697EIrm01NCHu7moUsDA+e5YVEIfIn8mlHgNO22Y0E6GQflhUkwOw0xO0Novcq/0FzKKwWlzsBasMdIbugSD2ifOZEHSWWu/wMwWoUGQHM3RfeRXbT4p2pv9dHyq3Nvubkjp4EjdSPCRD6OrLOXJs4BQfPnPe5YbKROXGekW8RR85gK1MawOWRrfv+o9T0j1ScJY7jj1MF9bw75y2AQX5xmUa3eQgp1mzR27fILssy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfULn2dPIQvjG7cYHqwEAT80bHvFwOoJt4Cj/SRG87s=;
 b=TguuyUYAKIQXX+TmWf5F5tpUF6VkMhmK1vzkzGqJxW9hchaOsL+gvrsDfNNJsvYpBHMu6GdeswwZ1626nLTbVgT6kTLkZLpCoFgt2vHaIu+0lmjbS2ZFqdeLwPtwi9lOtN0e6lfjEBTZcFh1uAIuilk8XfHzTG2hDWnx29enQDXCCH/cVU20GyikXeChqkAPfOZewc4OYFwmANu9WQ5nkic4Opd9DRtNM8/gghpIGppDuaftEw2rCyteYekTgkpp/qO45Szqte10RvRAoGg6wuNSAjGOf/Q3fslWwrWMN7NNBdGUKVBa0YtmatCYiAu7+I3FnRnHZyNZVOcamxBvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfULn2dPIQvjG7cYHqwEAT80bHvFwOoJt4Cj/SRG87s=;
 b=Z7xb47m6mqs14TNqPDoNpRGN3FjqSfynbaYPxyd9FdkYNR6UDnrTjLC0gwqM0GXuiIHvIEr8av4Y3jQrsIfbRRiGJVuZ3AXhi0ZG0EmETf71hBOTSHXFG5YKetJMOhwa427NlVz5/x41zCm1u7me4/UC6gRGVu7ek+w8pOccikUXFrsyVNVGXqP+8fItZJBe2wADvG8uKJhuUgmiE2NlPwyK8g0sKXPLWfiQtNp7xAJ2ByXYT+WsqhkA5q6kgYA593inbgy1d1BcH2iiCIDzWsIvre2nWwKD8U2LqrMmQi8YH7HToO+2uQXAGLuWjPX3VqL0CLWUD5iWon8FD8Cy8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by PH0PR03MB7020.namprd03.prod.outlook.com (2603:10b6:510:160::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 11:22:29 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%6]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 11:22:29 +0000
Message-ID: <faeb49a6-4fad-41c4-a4da-7a0c47c89e06@altera.com>
Date: Mon, 3 Feb 2025 16:52:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mahesh Rao <mahesh.rao@intel.com>, Rob Herring <robh@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Wu Hao <hao.wu@intel.com>, Ho Yin <adrian.ho.yin.ng@altera.com>,
 Niravkumar L Rabara <nirav.rabara@altera.com>, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
 <20250131-socfpga_sip_svc_misc-v2-2-eeed4ebc35f9@intel.com>
 <20250131152636.GA3454395-robh@kernel.org>
 <48c715c2-64ac-4e24-973c-515c8814ea07@intel.com>
 <cdae10e0-5580-4152-84b3-8552ebf87b63@linaro.org>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <cdae10e0-5580-4152-84b3-8552ebf87b63@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::7) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|PH0PR03MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea1b579-a409-4566-24ef-08dd44450b3e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0NWUkxSMXZicCtFbWxkSWhPZVBaWEdrMXg2YUI2SUZUaHdCdGQvclAybjkx?=
 =?utf-8?B?SEtoSjhybVgyMmVqNW95NlJIQmpRT2I0KzFCYnp6OVdaa3N6NnBHZ1RUSHMz?=
 =?utf-8?B?WGlzZHhOR1lKNkFTTjNRZ3Y3UXNhNE11NWRLOE5rSU5OQ3g0cHZybTAxMkVO?=
 =?utf-8?B?a3hWVVV2d3ZOWm9vSENONDZmTFJ3Ky9IMXpTY29TOFVBNTI2UmJpaHJTd2dq?=
 =?utf-8?B?aVVGaFlpSXpZaFhHSXVIUzFBcG9yYTY2WVBjdzU3OElIWXltdHJlQUkvMTVO?=
 =?utf-8?B?bXRLVkZaL2dUakRMOWlUNXZMN3R3dFlQUVh3aWZZeXJvSlJBdFhPNEtQdHRr?=
 =?utf-8?B?dkhaaXZCdFBuSUtJMFVaMFZQKzBJNlVSamh0NFVxa3JVWXd4UU1XRTBUWGEw?=
 =?utf-8?B?dGx2eWU4Q0poWWYwUWd3a2RKSE00SUl5KzJsaWlSL24vWDdCUDlRZ01tbmxR?=
 =?utf-8?B?WHFIWTNMb1FCandZWHd2SXJwZ1NKT2VlN1V6SHF6bC9tenRVOXhUbGZyczh1?=
 =?utf-8?B?SjBnallzUzQwU1hOS2ZqVUNRMDcwWmJiVzBjOGpzTTNJODhUcUQxbUZJdXVZ?=
 =?utf-8?B?SG9VZy81V0l0cy8wNC9BeGo4UUNVZ1NYVFpSMWxvNWd3aTduWmpWVHNiWmE4?=
 =?utf-8?B?WkFCcjNobFhUMldNeDVZVWd0L3NkdVZ0Mi8vWVJGVTZOVEszanVYVVREN0RS?=
 =?utf-8?B?cTFCaTZVbDBJQ3ZDZlFMRUthSTA3NElWbUkxdUpobFU0YTd0bUpreVcwR3Jt?=
 =?utf-8?B?MEMrUWptako1dHVqcklUK21ZNW5jUy82eWYvZmxpVTNLbGlYbytZbWlSWCtu?=
 =?utf-8?B?WlBRTHNkbVZIY1dsNHJNMG04eDFoamVWaWxZYXdNbGdTWjBJZ0pTb0xIUlFv?=
 =?utf-8?B?K24xVEtmSHZXdFNESlpycFYzTlAzTFU4Vk5xTW9NbmlDaUJqczhkWEw2dS9r?=
 =?utf-8?B?OGcvZUlGS01Vd0FMdHBkR3dkR3lncm1aUUZzM1pFajVIYUU5OVd3TzJETGl2?=
 =?utf-8?B?SHFDbDNrT281N1l5UnB4dHQxdXo5eGRYQWxsYUdaMHRWSEFZUDVQZXBJei8v?=
 =?utf-8?B?TjloSS95UmlIRlI4aE1XLzBIa1pxUUVxWnd2NUNEay9xNDNRemNldm5FblZX?=
 =?utf-8?B?VllSeWZNOW90SjBwWWpaYXlpbmZYbzVEdXBVc1dSb2FBcDd5NzNsK1hGSjNl?=
 =?utf-8?B?dXB1QzBhVHc2OXlsOXJsdSt4c0M5STBBUWU4Q1ZUeFFwbTMwTUVRR3VRTjdG?=
 =?utf-8?B?K0R2eThDVlhIWU11cUhSRHBaMzhLL1ZWelFLY2h4TTdhcmxjekJyUGFKUGpm?=
 =?utf-8?B?Ny85VnZHaVhUYmpNeDJzTkszTWlidGRGeHluSlNCZmZWRFJuWHkvS2hHZTFN?=
 =?utf-8?B?YlZyN1djcU5RZ2kvOUsxOEhaa2wzVjdUWldqbUZZRTRpQjR3NXZoRndkWS9W?=
 =?utf-8?B?Nm1FNjhJS1NGUnF3blVVcnZrcVFOcjVtcVM5alBrVU9vUmVKZjRCL1V3cmNE?=
 =?utf-8?B?NFIyRzljUUQ3TUJkN09zNzdyb1RXdTFRdjNxUzJ1KzhWZUpJMXhwZmt6NzVK?=
 =?utf-8?B?emlzaENpNWE0ZmJ6b3IwaGc0eWZNVmI1aHhHZUxsUWNrRDZEb0VUU1RUN2p2?=
 =?utf-8?B?R3BCMnFTa0Z4bUsxWTFnalRrUlJFM1l4WUVsSDhvM0xCYXJaNmdyZGtzaHZ5?=
 =?utf-8?B?VG9KT2hBbHkrNWg0QXFTUTluMUlUakN2bnFKZzR0YW1pdW1NaFN6RWNaM0ZG?=
 =?utf-8?B?VFdIUVFycWNwbVFJL0pobFJvc2xJOTJ4ZityYmZRa2paYkxtV3htWHB5eXFC?=
 =?utf-8?B?YnB6cUhmcXhlbUIxYmhtWThZSjF4L3dDUDNIajhrQTgwK2tNZnU5cDFpWTNs?=
 =?utf-8?Q?5wBSfZOpgPaQa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V05Hc2Rtam9DMTFyRjZCc3doV0Y2cGM1QzQwbEFZb2dRQWpTOHFHSGdOdmsx?=
 =?utf-8?B?VGx6WWpIM0hnajRwQzI0dEtPUzQ0MlN3MHRscDFCY1pmQnJzVG84NHdnUjN2?=
 =?utf-8?B?YkhYZjN6RW8zUVZyMkNBWWxZeEdTOVpxYWtjTU1sRWJmRG1ndUNIR2Y3eElr?=
 =?utf-8?B?dlFxb1d5RXA4T0VzQUQyazVvY2tUYkt0WkxEV09kMU93QUdxLytYa21QOEVu?=
 =?utf-8?B?VythMS9BKzA0ZjZQd0VwMkV4VlJSR1ZaOENEVTRUK2MzRFNlZHA1U1R6L0Jw?=
 =?utf-8?B?QTJiZ0FYMmVveEdKYndmUndhNXdmTkFjVksxT3NLcW55ZDArOHVValRUVGNy?=
 =?utf-8?B?eWRJbmV1ZSsvNVVnTkxDNUFHVk1BYTZsSUd6aEZTL2VTTExadWhKWnJxa1Vv?=
 =?utf-8?B?NllxN2xacGN2Vm5MVEZ2RTJPVUVBTkFuaE1FdjR4TUs1VFVRME16bEdTV2Nr?=
 =?utf-8?B?N2RpcHg5N3Jldi9LTXpNZ0JEN0hGM1M3clFQNzRmZkRyK3AxWHJrWXJLZmlQ?=
 =?utf-8?B?a3p5N1NHU3c1NUx1YXhtMCtQVVFHQStRUk1zUzdOOFJTaERYR3l4STdWT0lC?=
 =?utf-8?B?RjhjQ25tSkFEVFZ1d2JTTnlhcjE2YkJMWDJtVE5JMDMvUUVyb1ZCVHlTQVFl?=
 =?utf-8?B?bnpsMjJtVEE2VnJkQzhPSG9NR2hxRUFwRVZDNDQ0L1NTNVJrTGRrcVBBeDJI?=
 =?utf-8?B?YVhkNTQyNHpjTThaWTF5Mi9yWDdKSWYyZW5aWTFmRzFpeHNqQnBSSVVCZVRk?=
 =?utf-8?B?elFmeGlTZnU2MnhFRjNQaWVyVi9MdnlCL2pYK3lMeTdQLzhua1NaVVBxVXhp?=
 =?utf-8?B?RURNVXR5anlFT0ZBZjZqMTZadDRxeVZDUEVNN1A1a3BCc2J2RFdvRmh3b0E4?=
 =?utf-8?B?VE9UcFBiMWNkZDA5WVNtenEzWDNBSlQ5eTlLUVVLVWVHeDB3WlUzeUU1b0Z0?=
 =?utf-8?B?dUJkVGNZWWpHdkZ0dm92S3MzSy8zVHRLUTJGL1VsM3Z5bnpLSGJ3akI4ODBr?=
 =?utf-8?B?WUU3SFR3Y2RPd2wzeW1Jb3MydmkxaCs0emRTTW5hclpLK0dRemJhakRWK29u?=
 =?utf-8?B?Zis2TlpOSEs5YThkVEQ5cVRzYnptNisvcFBOZDM2NXV0T3lOSFpyYWhvdGlC?=
 =?utf-8?B?a0ZnbzFzc1U3WDc1UGFTN2cxVWx0NXRqbFV5OXk5bWNpTlltcnB4cnZzcTJL?=
 =?utf-8?B?SFgvUHB3dnhsbktXRFZyNVlNSks0QnVoVnZ3QklwZVJMRXpFYXU2bWR0UlZC?=
 =?utf-8?B?bCtnbnY0Q3dhK01ZbW5HOTJBSUpzbGVWUVBuQ1RCeFBOYmlNd1prVC9DMWI3?=
 =?utf-8?B?ZW1Eb1hYSjNmZmZxVUZqNzZoam5HZGMyNnQzL1ZSbVd6eTZObUNWaUdZeXhZ?=
 =?utf-8?B?ZTgrM2szNlEvRE9jZkFzRzk4WjVGaTJhUHFlWjJxQ3d0aWozMFJZcXU5OWhy?=
 =?utf-8?B?NmU1eGF2NExYL1RGWnh3bXBvMHMyYU53MlVpVWtxbVFFK0JEYW43KzIxdkE2?=
 =?utf-8?B?WC9weklGWUVJZ2podkZydGhLV09NZ0tHc3U3eDRtVG9ucUUrd1B3T1QvWC92?=
 =?utf-8?B?UVRZWEoyU0RtK0ZxSzVkUWxMR2RJZUpiYnFHaVZvSlZRaTNrNDVJZHRDNWI4?=
 =?utf-8?B?KzFqTVJjYUk2REZsMFNOOXFVU2NjV3prbEhXMVE2TVYyTmRzZXRWWDFrSkpy?=
 =?utf-8?B?YlhWQm9oNCtTUEZTd0daQ1NlMFE4ZnBjb2pqQVJkQXB3ekxQNkVQdXVuN3Yx?=
 =?utf-8?B?aTRldkRGdTQyeFNzSG90a1RTbjJQYVNkc3ZkVDAzL29HNnVOK0NIL0J6cnoz?=
 =?utf-8?B?UFYvQ3ltUVJBMjlMNDVyWkVtV0gvQlJpdU5ua25ockxEV1NsS1ZsSXN3L0NH?=
 =?utf-8?B?bzJOc2h0ck5aVm9pc0x6ekdDOENoV3FMRVNPb3RHRTFSSExqZFRTTU4vTzEx?=
 =?utf-8?B?dG5QZGNPUlVoelVJTmdENE1qK3F3NllwOWF2Y1dNRWszWXJEWkhlZjYrRDI5?=
 =?utf-8?B?MGM3R0U0Smc0bkZHUTExUDRHSzNGb0ZNQ0RqV0FyaEkrWkxseFJwZ1hKRjJB?=
 =?utf-8?B?WWxiMmYxSXUvcENXOEFZTzVyWThLcWtDZkpudHU3bE94MlFRTHcrUFp6Q1RG?=
 =?utf-8?Q?0XnFf2bqnKCKEYMevKq0//yV3?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea1b579-a409-4566-24ef-08dd44450b3e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 11:22:29.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TTFt/vRgaIRY6OMYfR1Z6f6p8XkX7YRSq7e7kuxOyLPNpuOq9bmhUk1XviqRgO022znzo+Rmx2XrsDp7paFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7020

Hi Krzysztof,

On 03-02-2025 04:45 pm, Krzysztof Kozlowski wrote:
> On 03/02/2025 11:42, Mahesh Rao wrote:
>> OK, will add the change.
>>>> +  memory-region:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      phandle to a reserved memory region for the service layer driver to
>>>> +      communicate with the secure device manager. For more details see
>>>> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt.
>>> Please read what that file says.
>> reserved-memory is moved to dtschema, shall I change this to the following?
>>
>> memory-region:
>>       maxItems: 1
>>       description:
>>         Phandle to a reserved memory region for the service layer driver to
>>         communicate with the secure device manager.
>>         (See reserved-memory in dtschema project.)
>>
>> Is this what is required?
> Drop:
> "Phandle to a"
> "(See reserved-memory in dtschema project.)"
>
> They are redundant, because this cannot be anything else than phandle
> and there is no need to say where each property is. You don't add such
> statement about clocks, interrupts, reg or compatible, so no need for
> memory-region.
>
> Removal makes the description actually nicely compact and accurate. Just
> how efficient text and code should be.
>
>
> Best regards,
> Krzysztof

OK, thanks for the help. I will make the change.

Best regards

Mahesh Rao


