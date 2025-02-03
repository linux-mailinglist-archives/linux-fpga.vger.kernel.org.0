Return-Path: <linux-fpga+bounces-1031-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99156A25730
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Feb 2025 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1073A500D
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Feb 2025 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015B201027;
	Mon,  3 Feb 2025 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiKjVDL9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62820101A;
	Mon,  3 Feb 2025 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579417; cv=fail; b=RnUJF9wZrshyYCXhOr/UQavHrFJcHr3r8xyXKvKaIOxexbxO6LEvp05JL/kv3wNMyqGWsxu/72RVV19LGvfmLoUQ76mYsmzj6HwmcXbyT0Dw9eB3h4JdhoSNzleqY4adKKmcL4nGVFoXVE5zVOK3mCkbuEyYz7/zq03UWSUoUj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579417; c=relaxed/simple;
	bh=a+8TYH5Iyp9CzxnUF5WY0/cN9nyUkPgvCQsuK6J2D0o=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pMrlQswEC7lAEjWVlP0bID4Zq1G7SYc8+YPCEV0NHXao+i8D4oz5csWJUxCfz0SxbkCIs/TXmyBL55U1E6Zoqox+QbS9K7bA4JOcsLLG7s+o6jhRQjSAwSVEq82GZyXxCwnpwEOv1+fVwKtUEc364vs9/uEz6Y9ZiFts+cC4dDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiKjVDL9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738579417; x=1770115417;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a+8TYH5Iyp9CzxnUF5WY0/cN9nyUkPgvCQsuK6J2D0o=;
  b=fiKjVDL9nYfddcpBCnT2z8se1c2G+OrcjFGNMV/ndB94NcGGIKeSPhjw
   XdwtG6UBc0PkR+5xHoLzlOZeFHGO6gfhTO/VZDDgkLDNYa2awsir8+A9J
   7fUaJGjihGQIzNdRmtsz0Fd8z7is2DbwCvviisyG21pR5Rvk8F3cm38LF
   FtXI7HfZMJaeRNjLtMYVXNHzOk6YB11VdtzJPLPDcKmpzsLZRCKFSfVa/
   8gB8CoUaVTUEvnWwIfDl7wQe8w+PL5Lrsg6bCGbGvsCpWDwcK/xUQzx7o
   CJbO78sWAw4ENe3w1MKdKT4ucTkaST33tbRKeeSvgNdLf5+UgDX1Ft9Ug
   g==;
X-CSE-ConnectionGUID: nHMIBq1AS0aa/JvjN2jcoQ==
X-CSE-MsgGUID: f8OsIbkdTLO3Mx0Q6AMRpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="50057635"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="50057635"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 02:43:36 -0800
X-CSE-ConnectionGUID: RCSqstKeSr2TKXz2GCkysg==
X-CSE-MsgGUID: Ws/IcmtER7q1DL1hNwnAhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114874220"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Feb 2025 02:43:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 02:43:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 02:43:34 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 02:43:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/Ea7ugcwNF8KAxT/prjpqgG+h8WZjQVstmeDgr+JVGeLizw6HzC4/UoSXPosIFLiDufqLpbj3VP7+UBra6N0ZiSGN8FeWGtVUSWEGsci4fjhjbCxeCMcDzp0JT+1M66u8AonMz4Ns5i7j4B/aeci1EYOr6taUCWZCTj83Fb9A8xy3GNUMrzRb6bTgU8XbeWDRrW73CvFCUi0EwLMf3QsFHfoMiHIqfCdV/CcISBhluLf8ZLNbbwVO0f2LHVvqCaf7my/ggvFc9MFAA9h5rPecollMS2zjwvPQVB5IdU1/hAgDv0NsiWfuQKIP8yRBl/TOrrde/Pk+qU0VS5bIMrbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AvLldaILnpQMEbawAZpgwsl/htKjYpjYluSZ7h7DGM=;
 b=KPHpTfTjtR2nQtmHtmCj/7YyjPvDFurA38MISJGJSd2vO2Eu3THv1i5FO0PDXpZ9cTaOuMnakX+KAIa6PYvysrP6YDUuQGFm/ks8X1TZFySc9C6SM72Ar9SuDBsVfEZGPjqNQpKwZ9O2hyaSu3EYVuIMBq+jo1tiy7nTVDnZwtgNF1yKd0iuaebwiELhDrj+mHIAgpoprQ8S+FSvci0ZLtdURqb3ckQ5HsjJzCKHgkgLDQbMyY4NJNspAIBjrHe8He+k1Qpj3pHK8iOcoacuawUA6PmTa+WrpIEWr46EeoLLrbpQQDtPqu7qs3iKbNMjs3jkcY5f5pel6fsObbBHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7972.namprd11.prod.outlook.com (2603:10b6:8:124::22)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Mon, 3 Feb
 2025 10:43:04 +0000
Received: from DS0PR11MB7972.namprd11.prod.outlook.com
 ([fe80::6cd6:7196:3abd:2c3]) by DS0PR11MB7972.namprd11.prod.outlook.com
 ([fe80::6cd6:7196:3abd:2c3%3]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:43:04 +0000
Message-ID: <48c715c2-64ac-4e24-973c-515c8814ea07@intel.com>
Date: Mon, 3 Feb 2025 16:12:54 +0530
User-Agent: Mozilla Thunderbird
From: Mahesh Rao <mahesh.rao@intel.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
To: Rob Herring <robh@kernel.org>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Wu Hao <hao.wu@intel.com>, Ho Yin
	<adrian.ho.yin.ng@altera.com>, Niravkumar L Rabara <nirav.rabara@altera.com>,
	<linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mahesh Rao <mahesh.rao@altera.com>
References: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
 <20250131-socfpga_sip_svc_misc-v2-2-eeed4ebc35f9@intel.com>
 <20250131152636.GA3454395-robh@kernel.org>
Content-Language: en-US
In-Reply-To: <20250131152636.GA3454395-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::10) To DS0PR11MB7972.namprd11.prod.outlook.com
 (2603:10b6:8:124::22)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7972:EE_|SJ0PR11MB4831:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de2361c-1f1b-4248-cfac-08dd443f89e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2FYWnp5ZGVvMG9uNUQxbXY3Q1RWdWV4RVR5MXVvdndhQU1JVEpOc0taOW8w?=
 =?utf-8?B?L01ScnlqTkJVbWdMaXA1NWprMmFqYTY5QUJhejE5djVTMlVZaFZ6dFBuWm1X?=
 =?utf-8?B?VzQzQjFxdUxhK2orZEJhU3NUNWhzNm9kSWVYRnpSaEhkbGFldkcxK3QwY3Yr?=
 =?utf-8?B?c2REZEtpcXlZMGJibEU3MEVQRnF1NGpidVd2VHk0MDMxRjNQKzZhd2lCV2Rp?=
 =?utf-8?B?eW0wRE9jMktLYW9NSWlXZzRBRFhQWDRFbDA2UUpmcjdLSUpLbTFLNjRUd3RW?=
 =?utf-8?B?NlhpODFYYzJqVHVGbDJMbHVnNWZvdURKUWpLaURDSmJ0QTduY3JZc3REVFd2?=
 =?utf-8?B?NTZyNmxaS2xZSzdqNzhBQUlhVEcvVEp5bCtlR1FuMGVhMEhwdVhLbWlMVEps?=
 =?utf-8?B?NWlQZlVoeUExZEZYMlBodCsvcTQ3TzZiaGZCR2FUQlZkc1FuNDJ5eFpYamg4?=
 =?utf-8?B?a0tqc1NuU3NyTWdXOG1TdUs4U015VWRuVnJOUXc2WVpya2lnNTV2ek1GcU9B?=
 =?utf-8?B?RU1wVG0xQk95Njd2ZEJXVWp6b016UGdkcGhEL3dsWWdVbnluMnk0WlVuSlcw?=
 =?utf-8?B?a1RkWlA5UmFaZmc5eGs0MERDbGN6a0RYRlp2aVFWOWpXbkVQK1BDbCtFUWdV?=
 =?utf-8?B?U0NvREZ3Nm9MamtLN1JXNWx6NDUwWGJ0R0VDV01EVkd2V2Q0QkRvRTI2UGZq?=
 =?utf-8?B?a1hWanRVQmJyRytQVThzRmVlRzlrMzJZM2ZoeWIvcnQzV2N1VWsrS2tDT0tH?=
 =?utf-8?B?NVFHb2VIZndWcmdWUDdhUjJkL3BvSkdZSXdnMTdHSmpwd3FTRlBHa042Nmxk?=
 =?utf-8?B?YUZKSnZ2YmNQQm1tekloY2kzb2FmUk1xNGlBL1ZIL0NXN1pyMVo0VWtQUHV2?=
 =?utf-8?B?b3VabWg5R3lrUlVzK3M3Z1JENlhuYS96RVpRK25wODhzckltWGJ1ejlVeXp0?=
 =?utf-8?B?dVB0bzNMNGo4NkdJeXFQaDY2aWsvUVJnWmpENW4xUDVFOWt2QjRxOXZVZTdE?=
 =?utf-8?B?M2lERFpnYmtSZUZvZE5naVRlU21RVVcxVXJqRXVQUTNKZHNHek1XSW8ydFM4?=
 =?utf-8?B?eit6OGxWdHZ1UnZvRWFaajJQaVViRVVSeDFkSHhRSVhFQXUxQzZZS3l3bXVK?=
 =?utf-8?B?Yzk2eFpCU0Z6Nk5reUVNVUtjRjNhWm5xVjZSY0xEcVNNZWUvMkMrKzEyMFRY?=
 =?utf-8?B?cURhaXl2UjZoNEQ4OFVzWllseGN3TzJudEV2SW5DMzNRQU9tVExkSTVBbUJj?=
 =?utf-8?B?dUJ5aXJqNnlIWXBKY2FDd2ZxR3NLdngrTUZGR1YzNk9EOUdXTVprc05reG1H?=
 =?utf-8?B?dFh6OEp2YjBObHJnSUtuTTBXTmRIbEZYOVdtUnFTQjg0VWQrVlgvbGpVb2pZ?=
 =?utf-8?B?dTI0T3NiZno0SDBmWVgrOWpoQ0M1MTRlNlh0dE9WNXhVdlZwdzkwNWdTZGJH?=
 =?utf-8?B?WFJBcGxJVGdNci84MUxMdEhqUnNsZU5NazVGZEhnbzBpcnNXaWxOQnVsN0VO?=
 =?utf-8?B?eGFJSk5zRXBqc0U2NlBtYVZSMHdwVUZzK1MwQ2tQZjJSMVMydk9hUGJFeTdS?=
 =?utf-8?B?TDMvbDkydWhGZXcvSHhoRjlNTktkTjdDYitTSitxVEc0SkFIbUtnTWp6LzF4?=
 =?utf-8?B?OVJ2dlB6cTZFOXorTEpGU0JONExObzVpa1JYNW8xc2ZrNlVMS1d6RU1nbS9P?=
 =?utf-8?B?V3V3QTV4dkh1NENINStFYUxJbUtaOTY4elFtTk4vUlNvSU1XekN2N3pGc2t3?=
 =?utf-8?B?NGlXM3BEdGdya3RhRXp4VklrNW11Ky90OHJFN213Mk9Ia0JCTFBKNnYzNzVX?=
 =?utf-8?B?RE1sRGZqUC9pM0hOUnM2QzVqUnhMdkxqRmhTd2daL2tMV2FoeW02ckxjandr?=
 =?utf-8?Q?DsTABCT/B7aQB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7972.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERjWUlIR2ZlUllaem5qemU0NVpQdWxZTU0zTjI1MklSbnU1L1lwRDJHMTBT?=
 =?utf-8?B?V0M2Z0tPS3lKaDZVMTBudHplcTduVXl6cEEyd2FhMG5LYlIxRVJDeS8zdHpB?=
 =?utf-8?B?bEk0T3VxWVcvY2thZlZLa0hRNjNyQ3QzMEJDV2s2OGJkajFRcFBsMXRoYTNr?=
 =?utf-8?B?eTRWblEyKy9iYmF1cHZvNENtNDNtblJJUXI4QXc1ZVN2UHlmbDZJb2wzc2hl?=
 =?utf-8?B?R3UxbnJqWHZOMGFvMXhvSWcrcGt2Q0lpUHJla1plV2ZSNVhqaEFhOHdBR1BZ?=
 =?utf-8?B?NmVJakVtVjhVdnVVWW5pc0tZMlRQbmhPZ0lzNDZZalYzTnVBSjhPQnEzZzND?=
 =?utf-8?B?a1g2bmFBeEhWRXZxTGk5cnlPV3Rrazd4eFoxMkVwa2pnakNvbjZhZ290WjdJ?=
 =?utf-8?B?aDR4aDlpN1g3bnJ6dGp5dmFRNEN5Y1NoR2pNL0hPYUhHWS9HY21pOHAwWEVs?=
 =?utf-8?B?SXlyaEl6a0pjTzZSK1lsc2dXcFpDaTQxSTNiZ3J4SFFHUTB6NExmT2ZPd3NW?=
 =?utf-8?B?T0JUaG1hdXM4c1lmYTBJWnJOMitCRXJFMkg4TDRxQzBCazJROC9iVEFIQUNV?=
 =?utf-8?B?ME93WUg1eWpDalp2MUtjaWo3em4vQk9MR3pHamVpRjVNNlpYb0xQMHl5SWhk?=
 =?utf-8?B?RnY5Yy93WU02Wm4wV0NyRzFxREFUbEU2S3hqSHNYd1diaGJRcThPbUxpczRp?=
 =?utf-8?B?YnNhQktneDUyOWd0VjJvL2gyaHNwQTVaZjJJUzg0NmlNWDB6U2dmamNVeXZo?=
 =?utf-8?B?N1MvMHVGK2VPZUlna1BUVVljUTRjdHpKc0E3cWVHWFo1Q3l6Sk5qWVVVYXVr?=
 =?utf-8?B?NGRyR1BpYWdxL242M1lyRmdmR1M5cHRNUk1kcU40VG5JTlJtN0RPVHVFQU5P?=
 =?utf-8?B?YklWdVZwUzV1bnRnQm9SeGhScjRycit4ZHFXaVhqTlJqdlh2MUZSZC82L2VV?=
 =?utf-8?B?bVRoR2ZMTGkzR3BuZVpyZlRtQXBsVGo2azdIbTBzdXBxQWFjc0ROc0htRjNy?=
 =?utf-8?B?Q2JnazJKWUgxRjZ4dVFvaitxdjJ4elRNZ2Q1c1lYNW1idEp5Tk9NLzJyVGJX?=
 =?utf-8?B?M1NyT3FPdEI1cWIwaUZHa2pDTEdKQlhFdFRsNXFGelM4UHArTFVQZmk2TkZJ?=
 =?utf-8?B?ekI4UTYwbkYrMWM1L0NCYythTThZNGR1QUZQOXdwUlZlYXlkYjUwU250VlVH?=
 =?utf-8?B?QlMwMGlJcTJicTdEMlpETmNrWks2K1gxTGdEcGNjYmcrRlVjOGo4OXFSQzI0?=
 =?utf-8?B?Y09oSHIrWndUelBKd0xUQ2V5QkRoYWkvSWJKT0cwYkVWb3N2QXJrVkM4QXkz?=
 =?utf-8?B?YmNIamhhVDFiUjZ0dnBHbzIvQS8xMXVnVnNZaENxblowc1M3N2hpaUJ6TVJV?=
 =?utf-8?B?QjB5RDNid2VFMzEvL2drREVvMVNtd2VNZ29MaTNCWUZURDdwalFIOGFhZ2xp?=
 =?utf-8?B?Qmd2by9lUXV1WWhXcGhCV283cFB0cHV5N0FmeTdoRjdzNGFrVkdLTGM2ZGpa?=
 =?utf-8?B?b3FzSmpveVZoK09GZTVSLy8wdWNPb1phNzhMc1JTTU1tY2VDRjNuZDcvK2ho?=
 =?utf-8?B?YXh2Y21lbHpUUEovRTdFWXY0SFA4cDJPWWJtMVlDUHJkOUpGY0xoaFlPV1Qz?=
 =?utf-8?B?dkIwemk4azJHeHhNYTltcHA5MjBSM3JZR2ZGbTRUQUJHZGl5WFpzOU9IQXVL?=
 =?utf-8?B?djZnWEp4S1hQKzFqbS8rOUk3SXMxeTVNSHEvdEwvdEpMNVpaOC84QnZpS1RH?=
 =?utf-8?B?ZmxjWUtvd2tIU1FmL0dVaStwTHlUaWQ3SUd1eVorWnM0MjhwUDY4QUNRVlBa?=
 =?utf-8?B?M0dnQnJJN0dnS1BHRjdIclllcFFLdHZ5Q01YakRkU0xEaW42YW8vektxbCs5?=
 =?utf-8?B?TjlReFM3ckxjdzRVdE12RVo4WWNRb3dMNy9UWE0xRTJpNFhzajc3WFl0cmps?=
 =?utf-8?B?K1ZGMXdPV3NEUG5aL3dlVGJQWER3WUZMVXhWSndwbEIyb0xFQy9jREJibU15?=
 =?utf-8?B?am93ZjZwMnJJUkxKcEtFMUtxS1pHUkMrTzRMUHlRaGtmRFFhSlIzZDNLeHBk?=
 =?utf-8?B?RFlBREZUQXluQkl0OTB0ZEpmWE1reVA2MVd4ZGpwaGVyczRNSlBJdmlzSDZ0?=
 =?utf-8?Q?yn06yVY7Wua7w9HY3JamoNtC3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de2361c-1f1b-4248-cfac-08dd443f89e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7972.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 10:43:04.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5cCHQRZUUh+j8kgyHTp1JtFsqIjVq6mLiwe96qRMwEdUFSAM6Gyo+SsxyNPykbKwlXIpU/kUKblWJpaM8qkDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com

Hi Rob,

On 31-01-2025 08:56 pm, Rob Herring wrote:
> On Fri, Jan 31, 2025 at 06:17:25PM +0800, Mahesh Rao wrote:
>> Convert intel,stratix10-svc service layer devicetree
>> binding file from freeform format to json-schema.
>>
>> Also added DT binding for optional stratix10-soc
>> FPGA manager child node.
>>
>> Signed-off-by: Mahesh Rao<mahesh.rao@intel.com>
>> ---
>> +maintainers:
>> +  - Dinh Nguyen<dinguyen@kernel.org>
>> +  - Mahesh Rao<mahesh.rao@altera.com>
>> +
>> +description:
> You need '>' on the end to preserve paragraphs.
  Will make the change.
> +      - intel,stratix10-svc
> +      - intel,agilex-svc
> +
> +  method:
> +    description: |
> +                 Supervisory call method to be used to communicate with the
> +                 secure service layer.
> +                 Permitted values are:
> +                 - "smc" : SMC #0, following the SMCCC
> +                 - "hvc" : HVC #0, following the SMCCC
> Indent by 2 more than 'description'.
OK, will add the change.
>> +  memory-region:
>> +    maxItems: 1
>> +    description:
>> +      phandle to a reserved memory region for the service layer driver to
>> +      communicate with the secure device manager. For more details see
>> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt.
> Please read what that file says.

reserved-memory is moved to dtschema, shall I change this to the following?

memory-region:
     maxItems: 1
     description:
       Phandle to a reserved memory region for the service layer driver to
       communicate with the secure device manager.
       (See reserved-memory in dtschema project.)

Is this what is required?

Best regards

Mahesh Rao


