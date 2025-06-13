Return-Path: <linux-fpga+bounces-1245-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8491AD8F91
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF321702B9
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00181519B4;
	Fri, 13 Jun 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qVDdLzfj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA522AE68;
	Fri, 13 Jun 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825044; cv=fail; b=uAH0Pfbeu8BYQkUXjsTNDmlhd9DRBF7l3cDgqGkzh2r5Aqm9eUMnwUpz5VsVZHGDYqWn7Fn+lOve/AiO/bW0TxRfErR53B0zKGe8l51GS/Fkqy+jpK0x4jwXwIlTFpEgdC14/Zl+D5gCl82jv/lNWVIevC2iNk3Hu1dJ1SFJlJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825044; c=relaxed/simple;
	bh=UTNE24bnhbuJkQsoUpAgt1nMznGuYqTrpnL9DKz6DIw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfTW5GyOEnjAeGZ7j314cH+mHs+x+6j7r2GNI6pzcuAZRKX18+QCOqbQR6TPCq3YDL8VRTABJT1JCs5UYEDvESYDNeA4zMM8Z3x1IbzRSlSh5UXoxR6SRBtrkk6Au4svLQbZhleNx5Ax0fbApLGsFbtBk3fDl1MXaQmt41jAadg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qVDdLzfj; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/oRNlBV6kDppOxdY9AMo/aEdZu/G5Ze+TB3LHMdBFxvFOhJ887pPOE2OyCmiVWSN8shuzg9YKtVcxhOJyH1ZK4kQ8+1QpdGCr7vQR+ScDGf4HrihXfZPnoAW6KeXeQdFk0iGo4BbXaiBU7DQrLP3qndEv52fHKX1JtXpVv/ohSgxMMUYoXaYVQQQiw7Qw3/hWhokj2zEXOPGvBiN8pH7MgNid+tL4W6o+RggdIvK4+aw0QroxASGnYj/3NOOHawM+Dn9N8gleSpYxl5eog3dvE3B3bIc7pXZGjbE5stLvTAhTaFfzNeHSs/YrB/9JgAufRHzf7WHNZg9Iu4YtKJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUTxzD7QWMSwbHoEA0gkwy5JzTkHs+YeBcIbG/DzwLw=;
 b=RNymicgdVcT2jXwPn08KQI70VOgxGxHW36Afg3wxIYHInAlY6EaxnvAyJKhRmfTb6SKD9jYKZGX31tZk1IGJDrYfSBmGZecw/+2Lnp9syapoHL6BOE2F1MROeY0t3AS8hHa2FMYb0PHsTJXzzs7tJycJ/YcBPtHQSpDUJEPRWRnqU8qQcONnCXQTqvit5PJqEZzkv5HL5RXkTTFQvTO734Rx0J+4SCnBnGS35FQT2PqBXFzxdgfoqvviwrooesPBtIxOUUaIEUPpXH7wjyhJlSYoI8z08tpVk53aUSXrSvOmqPq+q09ODHUxNmq3qKRRuiVbX02U4t4D/UTFhvxazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUTxzD7QWMSwbHoEA0gkwy5JzTkHs+YeBcIbG/DzwLw=;
 b=qVDdLzfjETmNDon2qWH2BSP700GeVmg7M6VKYp+hiyB+qWpMG67vy3MMXKZPn1C6nwYO6ng1mmuWm5LjsHwrpE5dhSWU/Gc5fNwZbksI1MIWkTB+jkiN7/DXJAfxZIihjtNK99Y5mFpR3svPYkxKGGJaZdzke7VAuXZIB5eG57Lr8kgBuMymD6ZpYIuU/Lc1xEQMJ4npmwv1mIoefCwGIrN19RCSYLRq98FL+Wkduos6EF5pm5AoIWaQ4Awx7KZmGpMLTQ6Ra1nAXJyPtKGFRJrVQUB/isG7Z5EzdJABfj5gLL+DtkTYv9qcWy4xVPLVAW4Z92vjN7b1uSUiHmus6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by BN8PR03MB5058.namprd03.prod.outlook.com (2603:10b6:408:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Fri, 13 Jun
 2025 14:30:40 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 14:30:39 +0000
Message-ID: <9c1b4875-a661-42e7-81ba-56e61171ca2b@altera.com>
Date: Fri, 13 Jun 2025 07:30:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: altera-cvp: Add FPGA Configuration Framework
 dependency
To: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>,
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>,
 Khairul Anuar Romli <khairul.anuar.romli@altera.com>
References: <20250613092414.3198092-1-kuhanh.murugasen.krishnan@intel.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250613092414.3198092-1-kuhanh.murugasen.krishnan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:a03:60::41) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|BN8PR03MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 22332a26-da9a-4687-6885-08ddaa86de62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajFLQzFqUjFJd2lYRVBrWGwvSlRkdEJoejBraDM3cGF3dXFiY2R6NEhwNlJP?=
 =?utf-8?B?VkRzSnA5azFLL0RCN1M1NDBQc1M3TEtLZ0ZmcG8xWVlpd3dyeVFKWS9RNTUr?=
 =?utf-8?B?YVJFdzVBS2pJWTNUdjNILzZzUUZPTThtLzl0byt0Y3BZVy8zcmtIR09mVXY0?=
 =?utf-8?B?ZHFTNjdXdnY0KzFNVGtmVlhJV2xreTFyaDRGSjNPWCtUeUFRc1VPd3FLQWZ2?=
 =?utf-8?B?ZDRuWndHZUxyT2pkR0lsMUxKRVlwU3pLMEVzamdiVnlLaW5uWGVzZnJWKzdn?=
 =?utf-8?B?U25PSFBNRG9Ma0RUVWlmMXFJQ2dFYWVnNDRJRHl4b2pQcG4vVFluSm93THhk?=
 =?utf-8?B?RGR6dXNwOTVWNVJRczV3VXE1UFgvRzJ4ZFdhUXVKajJIU0h6T3FJbGNTWUNP?=
 =?utf-8?B?NUxZa2dHNTBDaEViZjBxRDJQSmZsOHhHZ1ZFYVliQ1VBbnI0ZXJSK2xaMmMr?=
 =?utf-8?B?OURvcUl2eUlKSDNXTzJvZUh2MVdFS2dhQlVyZnk5a09Mb2tIM25BSy95ZkNZ?=
 =?utf-8?B?a0xIcmd0N3UrQWI5R3dlaW9wK1ZGM1VHUCt6U1BicFFoOWI1QUs0SU9yM3JV?=
 =?utf-8?B?eEcydXVFamFVRERjMXFPRkpiUWpqaVlGNlYwcEp5QkdZY2JaUHJBY01sNEJS?=
 =?utf-8?B?TEcwUnRBSGlOcHh4Zk9SVlIxdCtLdHIwSU10Q3pDSUFWL0daT2FhYlltQ2NX?=
 =?utf-8?B?Z0pMU1hwMjM3WWRLUTlCckNVRHY1K3p6dzFoMEFSMHJDc0dyR2RTbEpzVFVV?=
 =?utf-8?B?dUZNMlhHRzN2M1RUVjh5UmVsQyttTTZDa0NzL0kwNEZKaEFTelEzZlFjZHF5?=
 =?utf-8?B?SUV4Z0U0bzBwODEzSEhsZGNwU2pEeW5yV1BZbkl3VDlzRmNrTEJmYzdDUVhO?=
 =?utf-8?B?ZFVNajZhbkZIalZvS0w5ZEhFU2dUWVRhYlpvZ2xBdnhKc0E2UE5LMEdveUNF?=
 =?utf-8?B?MzZVaDNER1pvM2Z6QXFXQUE1Ly9NdEl6YkozbE9SeCthZ0Q0VXdMMmt3UUtI?=
 =?utf-8?B?UmJXTDVBWWZZNndtYWRoQUUyWkk2a1JVTmUwMHJ4S2VvYjgwNGQzakxFZmhs?=
 =?utf-8?B?WlVpamE3ZDR4UStDM3NaS01aRVRwRG8xaFpSR3ZMbHZyQjhhdUhhcmpqeFQx?=
 =?utf-8?B?TmszdUxQR1hEaUdlNzE4NXpxalh3dnloWlR2OFY4Z3dkZjBMR2QzYnVmQnRa?=
 =?utf-8?B?MEdWUCtKeVZQdUU4NkU1UDcrb1lPS210VmpETTFlNVBBWTNRZng1ZW1FYld3?=
 =?utf-8?B?OXlvSjJHY21qMGhIQWhzSi80T09Ub0x6bWlOZVU3aVRCQmNqaXloVUFKR1Zo?=
 =?utf-8?B?OGdQYjhkRG9VVkh3ZGJNRzdiekhlYXE1bHVWdTRVQVZnNDZoV01Na1gzc1pW?=
 =?utf-8?B?RU4xUFJuUGg1V0VCaVR5NGJJeGdWQVphQ0dRZ1FmY3N1ZStEZjlFbFdSNzI1?=
 =?utf-8?B?dUFpRG02ZGRnZFM1Q2hoZnlyakJlZ2lJakZBalFYZjNqVjRTZ0xWWE5LN3NZ?=
 =?utf-8?B?dU5DQ01ZOXZvZkx5b1ZFcWxGMllidy9Kb1hNQlFuOWJGRlRyV2NuaWZlYVJ6?=
 =?utf-8?B?R1pBZk15MjlmNGJTY3BRMzUvbU1Rc05KcEFNZVJZSGNLRGg3SThVMDU1aWFL?=
 =?utf-8?B?WlZvYUozYzI5MFYrY1Jad0FYYXpaMm4wbnNjYU5OTnBIbzFzSXRRUXZvSThW?=
 =?utf-8?B?ZS9OVGl0ajRjVG8zZkJrN0ZCYlRoaHZyVndBLzlXazloYWE0K2RzMjJMZXk1?=
 =?utf-8?B?VzB3clJKUGhrK0dqcDhHNTlhOUhETWpVdDVZTHdNY0xWcHUvWjQ4cG53c1dI?=
 =?utf-8?B?RjZXNWFHa2JEY2xHQnp2TGdoRU9Qc05lM20xKzZ2ZEo3UmIrZ25rNTVzOEE2?=
 =?utf-8?B?MHd5VGpQbFVFTXZjMjdGZjRaWEVJT21obVNxY05Nb3dBYlVCTnFidklKalUw?=
 =?utf-8?Q?lIQCJFnWADA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akp3S0hOQWtrOHhHbHBFY09idGhlazFTN0VMdkxyamtIaWlScmU3cnFWVGlp?=
 =?utf-8?B?QVU2emt3Y0orMjZuV3MrODc3RjVNMWZqcTJYenRDSWZQdFpRMDRWdHJPTDg3?=
 =?utf-8?B?WHFrUEp3azBabHVDNzBsOEd0bjRYRHAyeElCNVU5ckU5NzNzdVpQSWJOQ3VC?=
 =?utf-8?B?OElSMkFGcXdmV0NzN1ZaSG50UGZBRmE2dUtneVdzeURmZnlFTXhIbWlzYm9Y?=
 =?utf-8?B?cFR1cmtWbzJWaVNIYjRjQ1hGZEQxUk83OEhUcDd3TjF3NXIxTW9xeGh6N0RU?=
 =?utf-8?B?a1FDUS93dTVJSHEvOHRpSTZXSEZqZlhpY0lEVkJiSnMyRDZTZEtCdDVNdWpo?=
 =?utf-8?B?MkpZbENwWkl6OU92K0ZNMFZjSFNEY2RQUHZsN01MaU1PWVZTUjlRN05BNEll?=
 =?utf-8?B?enZENUVuY2NSL3V0eDBQc1Jsdk1pZHhEcE9kVHl5MWRBVkVrT3JMR1VzSDZq?=
 =?utf-8?B?L2l0RzdCNUZnUWxoTXgxU2J2OFN5WlVnQXVYK1JIUE1ncTNSQU14OUNvT2Jx?=
 =?utf-8?B?TytlL2RHZUR1SlI0dFlQc2ZsaEpIdE4yR2Y1ZlZEa09jRVFLZUNnL0dIdnBB?=
 =?utf-8?B?N1luSGliV0pLSGxpMDJQZ2VPblZEejJYeUVoTWlHMDUzQTJkeE93RG5Pc0Zh?=
 =?utf-8?B?SXBza0tzcTdZQkwwTkN6bm1ETmpHOHRRVVZ3Z1l2NElBTnc3QXhmaGw4ZWpS?=
 =?utf-8?B?ODViWm5rY3Z3ZjRhSXJaQ3JwNUd2T3FoMzVieUJQVUlNVDRoTkNXdWlIMHQr?=
 =?utf-8?B?c1R1Y2hNL0RRQU94SEVheG4rR21wcmNsRzVoOXlTTUZsYUNSNnFURFEwUTB4?=
 =?utf-8?B?MFBLanE1OGVkU1QwOUZrbnBmOHF6aFlQUkFxMnBRTHV6alZycmR4dytmQnZP?=
 =?utf-8?B?bnFabGR4aldELzhGc0pCdjFiK1ovZmlVNjhLWExmSjROTHFydDZVVkJ1dnJv?=
 =?utf-8?B?R3dOMzZUeGZwc3VkVTFTSVBmRmt1SnJHREJWRHJHRGZkSVpZYU0yRnQ4bHA0?=
 =?utf-8?B?a2tXamhoWldBOTgwYzVWZTR2eFQraVk5K3lGUmxtV0R3OU1YK05UdXFVTVJU?=
 =?utf-8?B?UTJLVlpPRy83UGpmenovOTM2REV3UDFuV2VRcmd0TDFJSkNGazNTNHNHVERE?=
 =?utf-8?B?dS9PM1ZwMG1KRVRCSDVTdURpNGNDWDJhbGU5Wlg5NDVmNi9KMlVabEFtTk1m?=
 =?utf-8?B?WmNpcm1sSzVncVNVMUJhS0RTcFEzQXcvVkRtZUtHMnpUTTFMbWJWckZObmNW?=
 =?utf-8?B?eGNmTkpZcWRDUmY5RjYzSHZmUHA1VGc5cEsvL3I2eHJVV3d4VlYwdGNkUHN0?=
 =?utf-8?B?MU1EM2ZUM1k3Sk43OGhxdFlqMGZzZTYrazRJR2pOSmxXdCt2aC96RkhrVm9s?=
 =?utf-8?B?UmpoQUhqc2NySGpaVHArQ0tMT0lUTXIzQmhkaThNaUViQVJjUVFKNkNvK2xF?=
 =?utf-8?B?eThHNC9QU2ZUazk3QjBxWGg2QjMwNTdxcFpsR0d4WWR3QmlUS1NJQkI1cWR5?=
 =?utf-8?B?OHRJSnl1VWdDcGsreWtSTkMycGVGczgvZUNKVWZRZ1lrWU9aazlPMkdsdnlH?=
 =?utf-8?B?T0thZnVlQzVPOGZKU3lxd2k4cHU1b3hoWHJJVnhmeTVtZEJTNkoyeDJuWmlM?=
 =?utf-8?B?M0J6K3F3Y1VZQ2lnQW52ZWk5cENLZ3JySVJmSjVKWXliMEdzTkpteE5CZEx0?=
 =?utf-8?B?WWc3RDM0NG9DL3A2Qy9KeEU3NXQ4SHB3QVdJL1RIbEl0NFBRN1NEbURiZEMy?=
 =?utf-8?B?T0RaV0pmSWNlZTE0TGZiMGE1OU5QenlPWWtyTEhJcy9qeHpNRDA3eVJZY2Vt?=
 =?utf-8?B?UmxpSUlqRW9XV2hLQkZiQktDcHp0Qkd0UXhVckk1ZXlXOXhFL0VkTUpGYi9E?=
 =?utf-8?B?WmFwMWh1aGRSVkxDdXdlL0M3UXVwbFJBcHh0T0xTQUlVTDNPYkNSRjJ6NlRV?=
 =?utf-8?B?dHlnOWVnMUtRUFlVZEZKTUk2Um9Cd2xkQlFzOU82UDVTMStpb3JLRFA5Rldq?=
 =?utf-8?B?RDZXYkI3MFhJNjNOWEhra21ZU3Jiang2WXY4QlNITHZ2NFFWUmtMUFpUZnpv?=
 =?utf-8?B?SWtiUlpFQXBhclpuREZ0VCszMnMvR2pjSk5QVStJVkQ3cC91NU9oRlVJdXdT?=
 =?utf-8?B?alpvZ3JDbjhxRndoNEFlOStuRjY5UzZ0UjlvWTUxMlpIakNiejk0YzBCSVR2?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22332a26-da9a-4687-6885-08ddaa86de62
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:30:39.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6qW5xlM5AW/F09/SBvYDoN5CWW8cesoBWRSLhLTsT1ivLK9VBruXzZckelIjRhLoPgaMyyj9NZteBlcN9hhfK/tJ4otEBmUFZ9wYjP3CCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5058



On 6/13/25 2:24 AM, Kuhanh Murugasen Krishnan wrote:
> From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>
Hi Murugasen Krishnan,

You should check your .gitconfig because your patch was from 
kuhanh.murugasen.krishnan@intel.com, but your Signed-off-by: says 
altera.com.

Matthew Gerlach
>
> Altera CvP FPGA Manager driver depends on FPGA
> Configuration Framework drivers to be loaded in
> the kernel. Updating FPGA_MGR_ALTERA_CVP in Kconfig
> depends on to include FPGA.
>
> Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
> ---
>   drivers/fpga/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..6f741348bfbc 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -47,7 +47,7 @@ config FPGA_MGR_ALTERA_PS_SPI
>   
>   config FPGA_MGR_ALTERA_CVP
>   	tristate "Altera CvP FPGA Manager"
> -	depends on PCI
> +	depends on PCI && FPGA
>   	help
>   	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
>   	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.


