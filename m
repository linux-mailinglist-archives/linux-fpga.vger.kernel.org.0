Return-Path: <linux-fpga+bounces-725-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EFB97CEC5
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 23:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E8F1C21698
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51931419A9;
	Thu, 19 Sep 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuhouxMW"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3B17555;
	Thu, 19 Sep 2024 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726781755; cv=fail; b=nM+B3kRhUbNfMyWjsa+6sUHWQNHSVbU+4c98iZLZ/+Uuk/FCKdk1uQwwYEeuLB/GVuKjbMusi2Zf9ejv825Hvs8xILY4ZVbf63RGY87+6/XozDDI18bVqkYybmBInk/XtST4iM38/wCFitb5NE12EV283SQdEbEa+V6MQd0mJZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726781755; c=relaxed/simple;
	bh=plXuwxNLsBrRMVO1YsbhuSL2NPs57w5SnqPAYyK+FK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QZ1smTFTgnVK8q3PlKj6Kvz8R2ekOvjaiXvhQ4unsufzjFb8y88P+c4TWt0NbzmjQTU4KuI9VeDUH9F8Lwf4Cm99bEZgGhhx2F0bXr7LnpK/JXU3xwRE0AjGdNJ2M3KhUpygwTvsCDNn01Wgh6ZCxUXW0hFrzMJ6Az+kN1QnWVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuhouxMW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726781754; x=1758317754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=plXuwxNLsBrRMVO1YsbhuSL2NPs57w5SnqPAYyK+FK4=;
  b=MuhouxMWiU18lCGFc7OvpArlK6nEtJEATgmbqHYDr6geSsxc5uPSnWMI
   Uq0No7ZO3empTsUkEvt2c9aAkxdlQ1GVoWT7J5tDsJmwCQafAsv+czhvY
   YL5GYk3uf9gR54YZrq9XR8lEewZUAR9RPZa0nG7cTeZKUc56YuOsLaLVo
   Qrb5SRy4Y6eSzF7s7gGS6RHq8F0EJWVa32cjgbjvXjHj6FbkcuvN22387
   vlEOLqMmL66cDo9g0yTv9ig5XYAiY7hZPbtH/ph5L8tXM6mpdUmd8RHPN
   lRkANnI5sHVrSHthZDfjy2kIUbtZRWWbYDWUP2GymIkzSAKxzexemi6kW
   w==;
X-CSE-ConnectionGUID: qKtiSKcmTQKDYJsEMyxXCQ==
X-CSE-MsgGUID: 4RLgsVEHSWemzjxGsuuHrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36359297"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="36359297"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 14:35:53 -0700
X-CSE-ConnectionGUID: WHEr9TwMROqtc5v4OTaQdg==
X-CSE-MsgGUID: a0ALqkqKR4iVmQTCi24PhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="69940612"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2024 14:35:52 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 19 Sep 2024 14:35:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 19 Sep 2024 14:35:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 14:35:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLUf1xSjfEpjxQq9ptF2370db+98unmeVHLeriTX3uYcYIQC55Tt38sE3t2Y71tBoP+0tsChnkPRW262SZ+ryd8DF87w7dsYoVJpSCg7Bsr5TEdkAXjopKu1Nysm1OjuArCSlZaVa1lq13MPo5JseTKs7U/OANds6XcM65pjuelvgDoWTJzI1xMPQqSUjvfO2Z8DroCG1Xh+ZtjnLQb6rMK8KM3gpvpal41ojf5w8YmuAbU7suSbUJaz3DKqfQukkvTHxsN8faUxTuBta4kLhK2wz4vBoKzEmmpt8M5hQ6Z43xBVXVtJTS3r7uzy26eBp4l2Yc5BRFtxkytI1ZUwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plXuwxNLsBrRMVO1YsbhuSL2NPs57w5SnqPAYyK+FK4=;
 b=vFprDYaAFQieu39ZeAAkmc2dxVRJs6Q38otwRGccd6GAauqMhSNyM667SmlH9Bul3MZOZSTDy9Ip0niZuO5A1F2bSUOIl+ei7ew/W9vYH3Hn8XHQWlR2TiXMKeiNtdX47zh1RZaTh1tepUQ4Uo6a/F79AR+hVvmpmOQF2IbCDBuHH4T5lyfmGAcjsMAYejiOzMa/J7rF+wzC57Xd7WIy8AfIyy/Ei1JR5kQnhNcqzLgLjyMW4AJ+LZOPGypdpT9iDLfQ24oJUrBEin4xeQu6XHtuQFcyStdEfxNLhCTgFOuK1vYPe31EP1DWIT6uUnynSJpYmRchx51XFEeKQ+0aTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 21:35:48 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%5]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 21:35:48 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 4/9] fpga: dfl: migrate FPGA Management Engine
 driver to dfl_feature_dev_data
Thread-Topic: [RFC PATCH v2 4/9] fpga: dfl: migrate FPGA Management Engine
 driver to dfl_feature_dev_data
Thread-Index: AQHbCtvkpCvlHmN9MUyyopI4Lz0y4g==
Date: Thu, 19 Sep 2024 21:35:48 +0000
Message-ID: <bd5bf25938ec45815dcbd312522bcafe84e6f05e.camel@intel.com>
References: <20240409233942.828440-1-peter.colberg@intel.com>
	 <20240409233942.828440-5-peter.colberg@intel.com>
	 <ZieBnQBDGgowf+y7@yilunxu-OptiPlex-7050>
In-Reply-To: <ZieBnQBDGgowf+y7@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|CH3PR11MB7764:EE_
x-ms-office365-filtering-correlation-id: 1374df5d-98fa-4d9c-d667-08dcd8f306fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmlNN3g3dHRGdm9sY1RXWFQremlwdEllTEFDMTM2cmZGNHpTb3FjRklVWFlX?=
 =?utf-8?B?Wko4VHoyTFNPU1NrR3JTcGFiaEFycXdMRVlKWkhLaG9QWDFYeTFhang0Vjls?=
 =?utf-8?B?Q3J3bUh6SERqODNMVlN2d1djZTFYOXo3d0pXaWtUSERFNlpXY1IvSHF4cDVL?=
 =?utf-8?B?aE5UMnJEamZaTlRtNUNId1hidUhGSXBxZE1HT0o3TTZWZVR1ak1SNkhtLzls?=
 =?utf-8?B?YkxMU0FCRWZqVG51OUM5KzRMRVVoY1NZVE1WVU1vRXBSaytvbHFhODgrbXk1?=
 =?utf-8?B?L1h1WGRrdUdnRVdZbjZrd0p4cDRpU0tWaGo1NWY2RG0vbS9sTlJURnpVNTZU?=
 =?utf-8?B?MVRBT2pOSzhDMEp5d3VQd1I2T1FveUhSNngyNmwwUXdnd1hXN3JIcEoxc0Er?=
 =?utf-8?B?TTM2a3BPdUhyc2o5NjJTOEZwL1NGVjYrZmR6OEFucTVWOFhIcnJHSUpWZEov?=
 =?utf-8?B?R1lIcDQ3cTVlc0NjVnk3VzVLTGgyTTZsYllLMDR4Y1YyaTFFa09KOHFPY3RR?=
 =?utf-8?B?cFFIdVNDcDdHNkFSZ090L2w0c1RJZFdWRFdsZ3gyZ1NuK2hoYmhkYlEvbERz?=
 =?utf-8?B?a3FBb1JEWHZ4NWJoeGlwNkQ3M0xoMCtuUzg5eFRZT1JVWlhzdU9QbjRtRVhK?=
 =?utf-8?B?VDhremxCbTFiYU85WmE1Y0Yzb1p2UGUzQXBEK3ZVb3B3eUZCSEl4SnA2d1BR?=
 =?utf-8?B?S1B2TVBsUC9RQ3NuTU1QMHRTZ1o4Rm9CSlNISlNRby9lSSt5WUN0Qld0ZGJv?=
 =?utf-8?B?ci9LTDhNZFlUS1RKVHVqU2VkT1JIR3E5Zi9tOUp5WWNQeXA4OE1lOFZsYnZM?=
 =?utf-8?B?eGdwVkNwd1ZRcTV5L094VHppVXh2dzNYZ1BLS1U1RkZVMnNuaC9kZUZIM1hL?=
 =?utf-8?B?dE1oWnc0djZ4VGtYdzNJck5qSEprSmxjTkt5K0cyRjlYS2xBTGo3aFU1cDlz?=
 =?utf-8?B?YjZIM21Kai9YaFRJdnVpNWhEbHU0RUdXMzJ3cDJ1K1d6RHhnRUZKMkZVODgx?=
 =?utf-8?B?OUpPdkozSkUrQTF6U3VKUnJzN0ttS2M4OGtVaENVc0NkSDlMWEgraGNBajh4?=
 =?utf-8?B?ZFN0K3F2QVJBRjlmNThLNjJ4VlpORkFKN0k3clRrVVE4VVU1dXl4ZHFoN0tr?=
 =?utf-8?B?MG54M1lsVFVNYjd1QS9RMUVUQVR6cGNxcFZNSHBIaSt2eERiNWErRFcxTEdr?=
 =?utf-8?B?bHZWVXYwYVFOS0tUMFMxazBSNEhWUlF4TFdoWVA1eDBtNlhFK0hpSEVaUFRK?=
 =?utf-8?B?WTFyRkhraHp2SGxYT0h6dFNEd2NxalRwTmZGTmIrcGRCK2xyT1hiNFBJY3Nx?=
 =?utf-8?B?K2xmSjJqMmNQTkFCZWd4eUk5VTltMmNRbkRoalVrTDJ6OXFCbnZlY2tQV3h3?=
 =?utf-8?B?UE8zSTZqbHZRYXdPR1dQTVM4QnRRdHI4Um1uSEd6R09MRmVwT0FtaDNZUng1?=
 =?utf-8?B?QUYxdmJrZFdEVS9iSmFldnM3cHNQbk5EWWREMjhXWS8rVHYxQmUxcXBkcGJL?=
 =?utf-8?B?QjlEZkxBTVR6cy9FdlFZc1NBNC9iejhrQ2NGS2JiUmJUS0FvRDlXcWU0MEdU?=
 =?utf-8?B?U1BJTkJiZGROdXAydmkraThYTThRMG8vK09nWTJQMVVmbWc0dnlzVlpZYkVQ?=
 =?utf-8?B?KzlaTU5nM1lJMFBGbVZCc2g2TzRycnFsZnNtVjR4NUNMcGFVTXMzMnJxRWhk?=
 =?utf-8?B?dDBXbEJyUmxUaktKandXb0tvSWhJRW4zdlRMclA3M2Zaa3pZZE02UnlVTi9i?=
 =?utf-8?B?VDNxc0IvOUNxQnhQR2diNmthN1k5bmdJa1JkZzRxMmhXQS9BODdJQ2czdnVr?=
 =?utf-8?B?QnR3VFlKU3VONVJLRlVtbVFYVVQ2ODVRcWtsM1VkTjBQaVArR2U0SVBMcDZ2?=
 =?utf-8?B?MjJGaWVXdHNZWmNOTzNId0VkdjRZVm5Mb2xreExYVHltcVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHhJUEtWdmJKVjg3M0hTOFdLQ2VrYmt6N3YyZlIxVkpoMnZXV2lmV240RWZq?=
 =?utf-8?B?bENKTzN5RkZQV1JoenJ6cDNYTUx0TW1XMUNUZFMxbGp5c3JMbFRTVTFhMHcx?=
 =?utf-8?B?dDF2cnlyQ1YvaUtYVXZHY3FoVEcrbm9Wd1VSMmJSZ281ODBqNGVZV3Y0WUto?=
 =?utf-8?B?SGZmTzFRYWtvK3pLekYwb0UvNlFkak5JTjN5OFR6ZnE4c21zelhUcDJIZ3Bt?=
 =?utf-8?B?cU5xVDhzUHFYeERIMVhIRFFnQnFnQ3RZQVlPdkt6bFNxZ2FGY3dUbmJGdzVP?=
 =?utf-8?B?bGU2dVVkMkRSS2s4TGVXRmxaTGd5K1F2aU8zbzJaOFprRnlsTHRQYVlvbFFF?=
 =?utf-8?B?d25hczJCVUc5NUlPbkNBNjZPWGgwN20yQ2JsWWNsV3NoWDFLdUlVU1ZyeFlF?=
 =?utf-8?B?TmtZRklQSDJHMjVSNGxtQVV6cEdXaG1DQnRxMnd0bFBtODdrYUpySWxibWNL?=
 =?utf-8?B?UTdJUitYTndFekxvbkZ1RG5BSmo4Q090U0FiRzJuMWcyei9WY0dQc1diZDU1?=
 =?utf-8?B?M250Qml2KzZTQm83WWltekZacTJVSU53ekNJUG5UcTQ3T2hHNFF4WkNxbWZB?=
 =?utf-8?B?K3J2aHFBdzgwcExjZWwvRGkyeG9wVEoyampzWit1T3NxQVRxV04vdEYxTC9S?=
 =?utf-8?B?cFV6VElaNlRkaTFSTHo2eDJQMUpjd2ppNUFiSEpuNnZkLzB2ek1CellFeEF2?=
 =?utf-8?B?aXBDNldDOEVCTUJOVDg1Tytra3c5S0l0eElpNUJGZkJFL0tzekI0L05aV1pk?=
 =?utf-8?B?RUlVZkQ4NE8rRDlNcEpMK1B3aUNCRVRRcXZ0UEdRMFVtdFp2QmhDQnY0RHN6?=
 =?utf-8?B?Y2JQSXpLcC8rM0x6YXhRMmtKT3IrRzl3VTU3cUREWFlQQVdGM3JnL2t1UkNZ?=
 =?utf-8?B?RmtEZmZlQkJIbnZpMmEvVHQ1TytYOTlrbThqL25RWS9iaVpSOTd5TGZmZSsw?=
 =?utf-8?B?UHBkTkgvYlREMnN4K2Y2bHFLaEhKdndjRElrQ3RtaEhWL05yMDcxcjNxMEVI?=
 =?utf-8?B?L2VvRGY5RGJCb3dSbno0ZmlZOFN1dXhDdURhMGxqZ1lXM3JJYThGREFrNGg0?=
 =?utf-8?B?bFB0dHd4dE9lTGNmNmo0VzdIVXBzTC8wbzc2bElCTkZTRG1wYTNOMTRvVzlI?=
 =?utf-8?B?V2FVcDJwUFhlUnVLRExZM3YzclBZbERRK2pWT1RKVC92N2dubXUyVlpTQStN?=
 =?utf-8?B?ekNKK2k0cXJFS3pZV08vTVpPakJzREZXbFJQVDRBdE9oWGpZSW9SUmxiYWNH?=
 =?utf-8?B?Vi9YZkEzdjZGcUNlRkpKN2MzY1YveDZUWU80VkVvT285RFdNaWFIMXdrUnZ3?=
 =?utf-8?B?emRuMkdjK25meHVWYTMwUk5JdTFZMGdONk51LzhNTXcxd05rdmtqVzlsTXFP?=
 =?utf-8?B?RlgvN1ZscEswY3QrTldqMW0wMG1maXpzRFJNN2JXNVhYRENKSzk4VzhSdVJp?=
 =?utf-8?B?YVlXNWRvY0MyNi83eG1DL2xXeklhNkFCSlBjVUMyNnRaSHpQNTJCWk1pQ0FB?=
 =?utf-8?B?MDVoeUNqRVdqa2dPaXY0dnNESm56VHlPb2ZqZEJaZjdWOUU3ODd6enprRCtj?=
 =?utf-8?B?a2lsb0hRbDhIVnJNNlRFbzhkWlpzQlI4Y044WkVHL0Vxd2ZMTjZUaHN0MHpu?=
 =?utf-8?B?ODEzZ0owUzRBYjcvQUM3YlllanZyQldZdG5DaGM2TThNZ1B3WnhjZWZZdlcv?=
 =?utf-8?B?OEJISEk0NUNNWXRFOUtTTTdBVlpBZUhWMTRCZVpqM3RSLzl4bXUvM3QzVTdY?=
 =?utf-8?B?KzJWRVJLMzFZSFpaT01XZGF4NEtEaWpMYXlkVDdlYTJvMSs0NXl4QVVCU09t?=
 =?utf-8?B?WS84NnBqRHN2M0Z2YzB1OG0rQ3ZGSXJYS2o0Y3liSmZXaW5QZlhpQTVEcjlr?=
 =?utf-8?B?cFk0MENMc2FuenNUeUNCVmU1aGpSbTVhMVR2WXZtUURuVDFUWEprZlYrSGRB?=
 =?utf-8?B?S0htQ2dRMVlBMHJ6WE5CaWRFcUtvRGpMbnJ4Y0tVaGhYK0FOSWk5MFdKYWZh?=
 =?utf-8?B?TVcycnR4a01VM1BuVHdxVkZ4eWFvcFZSeVROQTlxOUwwQlhMdnFlbkt5TDU2?=
 =?utf-8?B?ODdKVllWSlllTmZvb1dWZGFVc0M0d2FXZUM3V3o4cHJSS243NkhMYmdMa3R3?=
 =?utf-8?B?MWQ1Qm94S2ZOUnVvSWxYZSt6dE1xNGVad3pXWktYZ2FQc1JrNFJ3NjhyTW9G?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2911BE4791BE914487378D755F3ED572@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1374df5d-98fa-4d9c-d667-08dcd8f306fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 21:35:48.5101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sASP/aa5vyINKlW4ydv1WSKtYga4WFDZxFdhbNuYpGF/niFeS51AEJLXOrtkMpjN6Rr1LVbgMwYOUlxn4svvww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTIzIGF0IDE3OjM4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VHVlLCBBcHIgMDksIDIwMjQgYXQgMDc6Mzk6MzdQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBUaGlzIGNoYW5nZSBzZXBhcmF0ZXMgb3V0IG1vc3Qgb2YgdGhlIHN5bWJvbCBuYW1l
IGNoYW5nZXMgcmVxdWlyZWQgYnkgdGhpcw0KPiA+IHBhdGNoIHNlcmllcyBmb3IgdGhlIGZpbGU6
IGRyaXZlcnMvZnBnYS9kZmwtZm1lLW1haW4uYy4gVGhpcyBpcyBkb25lIHRvDQo+ID4gc3BsaXQg
YSBzaW5nbGUgbW9ub2xpdGhpYyBjaGFuZ2UgaW50byBtdWx0aXBsZSwgc21hbGxlciBwYXRjaGVz
IGF0IHRoZQ0KPiA+IHJlcXVlc3Qgb2YgdGhlIG1haW50YWluZXIuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0BpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gdjI6DQo+ID4gLSBTcGxpdCBtb25vbGl0aGljIHBhdGNoIGludG8gc2VyaWVzIGF0IHJl
cXVlc3Qgb2YgbWFpbnRhaW5lcg0KPiA+IC0gQ2hhbmdlIGZtZV9oZHJfaW9jdGxfKigpIHRvIHJl
Y2VpdmUgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgaW5zdGVhZCBvZg0KPiA+ICAgZGZsX2ZlYXR1cmVf
cGxhdGZvcm1fZGF0YS4NCj4gPiAtIFJlbW92ZSB1bnVzZWQgbG9jYWwgdmFyaWFibGUgcGRhdGEg
aW4gZm1lX2Rldl97aW5pdCxkZXN0cm95fSgpLg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2ZwZ2Ev
ZGZsLWZtZS1tYWluLmMgfCA2OCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1mbWUtbWFpbi5jIGIvZHJp
dmVycy9mcGdhL2RmbC1mbWUtbWFpbi5jDQo+ID4gaW5kZXggODY0OTI0ZjY4ZjVlLi43ZjExOWIw
OWI1NGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1mbWUtbWFpbi5jDQo+ID4g
KysrIGIvZHJpdmVycy9mcGdhL2RmbC1mbWUtbWFpbi5jDQo+ID4gQEAgLTEzNSwxMCArMTM1LDEw
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGZtZV9oZHJfZ3JvdXAgPSB7
DQo+ID4gIAkuYXR0cnMgPSBmbWVfaGRyX2F0dHJzLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAtc3Rh
dGljIGxvbmcgZm1lX2hkcl9pb2N0bF9yZWxlYXNlX3BvcnQoc3RydWN0IGRmbF9mZWF0dXJlX3Bs
YXRmb3JtX2RhdGEgKnBkYXRhLA0KPiA+ICtzdGF0aWMgbG9uZyBmbWVfaGRyX2lvY3RsX3JlbGVh
c2VfcG9ydChzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhLA0KPiA+ICAJCQkJICAg
ICAgIHVuc2lnbmVkIGxvbmcgYXJnKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgZGZsX2ZwZ2FfY2Rl
diAqY2RldiA9IHBkYXRhLT5kZmxfY2RldjsNCj4gPiArCXN0cnVjdCBkZmxfZnBnYV9jZGV2ICpj
ZGV2ID0gZmRhdGEtPmRmbF9jZGV2Ow0KPiA+ICAJaW50IHBvcnRfaWQ7DQo+ID4gIA0KPiA+ICAJ
aWYgKGdldF91c2VyKHBvcnRfaWQsIChpbnQgX191c2VyICopYXJnKSkNCj4gPiBAQCAtMTQ3LDEw
ICsxNDcsMTAgQEAgc3RhdGljIGxvbmcgZm1lX2hkcl9pb2N0bF9yZWxlYXNlX3BvcnQoc3RydWN0
IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRhLA0KPiA+ICAJcmV0dXJuIGRmbF9mcGdh
X2NkZXZfcmVsZWFzZV9wb3J0KGNkZXYsIHBvcnRfaWQpOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC1z
dGF0aWMgbG9uZyBmbWVfaGRyX2lvY3RsX2Fzc2lnbl9wb3J0KHN0cnVjdCBkZmxfZmVhdHVyZV9w
bGF0Zm9ybV9kYXRhICpwZGF0YSwNCj4gPiArc3RhdGljIGxvbmcgZm1lX2hkcl9pb2N0bF9hc3Np
Z25fcG9ydChzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhLA0KPiA+ICAJCQkJICAg
ICAgdW5zaWduZWQgbG9uZyBhcmcpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBkZmxfZnBnYV9jZGV2
ICpjZGV2ID0gcGRhdGEtPmRmbF9jZGV2Ow0KPiA+ICsJc3RydWN0IGRmbF9mcGdhX2NkZXYgKmNk
ZXYgPSBmZGF0YS0+ZGZsX2NkZXY7DQo+ID4gIAlpbnQgcG9ydF9pZDsNCj4gPiAgDQo+ID4gIAlp
ZiAoZ2V0X3VzZXIocG9ydF9pZCwgKGludCBfX3VzZXIgKilhcmcpKQ0KPiA+IEBAIC0xNjMsMTMg
KzE2MywxMyBAQCBzdGF0aWMgbG9uZyBmbWVfaGRyX2lvY3RsKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsDQo+ID4gIAkJCSAgc3RydWN0IGRmbF9mZWF0dXJlICpmZWF0dXJlLA0KPiA+ICAJ
CQkgIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKQ0KPiA+ICB7DQo+ID4gLQlz
dHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRh
KCZwZGV2LT5kZXYpOw0KPiANCj4gTWF5YmUgZmlyc3RseSBtYWtlIGEgcGF0Y2ggdG86DQo+IA0K
PiAgICNkZWZpbmUgdG9fZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YQlkZXZfZ2V0X3BsYXRkYXRh
DQo+IA0KPiBBbmQgcy90b19kZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhL2Rldl9nZXRfcGxhdGRh
dGENCj4gDQo+IFRoZW4gd2UgY291bGQgZG8gcmVwbGFjZW1lbnRzIGluIHRoaXMgcGF0Y2ggbW9y
ZSBmcmllbmRseS4NCg0KSSBoYXZlIGNvbWJpbmVkIHRoZSBwZGF0YSAtPiBmZGF0YSByZXBsYWNl
bWVudHMgaW50byBhIHNpbmdsZSBwYXRjaA0KImZwZ2E6IGRmbDogcmVmYWN0b3IgZnVuY3Rpb25z
IHRvIHRha2UvcmV0dXJuIGZlYXR1cmUgZGV2aWNlIGRhdGEiLA0Kd2hpY2ggYWRkcyB0d28gYWxp
YXNlcyBhbmQgcmVmYWN0b3JzIHRoZSBjb2RlIGFjY29yZGluZ2x5Og0KDQojZGVmaW5lIGRmbF9m
ZWF0dXJlX2Rldl9kYXRhIGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGENCiNkZWZpbmUgdG9fZGZs
X2ZlYXR1cmVfZGV2X2RhdGEgZGV2X2dldF9wbGF0ZGF0YQ0KDQo+IA0KPiA+ICsJc3RydWN0IGRm
bF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9IHRvX2RmbF9mZWF0dXJlX2Rldl9kYXRhKCZwZGV2
LT5kZXYpOw0KPiA+ICANCj4gPiAgCXN3aXRjaCAoY21kKSB7DQo+ID4gIAljYXNlIERGTF9GUEdB
X0ZNRV9QT1JUX1JFTEVBU0U6DQo+ID4gLQkJcmV0dXJuIGZtZV9oZHJfaW9jdGxfcmVsZWFzZV9w
b3J0KHBkYXRhLCBhcmcpOw0KPiA+ICsJCXJldHVybiBmbWVfaGRyX2lvY3RsX3JlbGVhc2VfcG9y
dChmZGF0YSwgYXJnKTsNCj4gPiAgCWNhc2UgREZMX0ZQR0FfRk1FX1BPUlRfQVNTSUdOOg0KPiA+
IC0JCXJldHVybiBmbWVfaGRyX2lvY3RsX2Fzc2lnbl9wb3J0KHBkYXRhLCBhcmcpOw0KPiA+ICsJ
CXJldHVybiBmbWVfaGRyX2lvY3RsX2Fzc2lnbl9wb3J0KGZkYXRhLCBhcmcpOw0KPiA+ICAJfQ0K
PiA+ICANCj4gPiAgCXJldHVybiAtRU5PREVWOw0KPiA+IEBAIC00MTEsMTQgKzQxMSwxNCBAQCBz
dGF0aWMgaW50IHBvd2VyX2h3bW9uX3JlYWQoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIGh3bW9u
X3NlbnNvcl90eXBlcyB0eXBlLA0KPiA+ICBzdGF0aWMgaW50IHBvd2VyX2h3bW9uX3dyaXRlKHN0
cnVjdCBkZXZpY2UgKmRldiwgZW51bSBod21vbl9zZW5zb3JfdHlwZXMgdHlwZSwNCj4gPiAgCQkJ
ICAgICB1MzIgYXR0ciwgaW50IGNoYW5uZWwsIGxvbmcgdmFsKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1
Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKGRl
di0+cGFyZW50KTsNCj4gPiArCXN0cnVjdCBkZmxfZmVhdHVyZV9kZXZfZGF0YSAqZmRhdGEgPSB0
b19kZmxfZmVhdHVyZV9kZXZfZGF0YShkZXYpOw0KPiA+ICAJc3RydWN0IGRmbF9mZWF0dXJlICpm
ZWF0dXJlID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4gPiAg
CXU2NCB2Ow0KPiA+ICANCj4gPiAgCXZhbCA9IGNsYW1wX3ZhbCh2YWwgLyBNSUNSTywgMCwgUFdS
X1RIUkVTSE9MRF9NQVgpOw0KPiA+ICANCj4gPiAtCW11dGV4X2xvY2soJnBkYXRhLT5sb2NrKTsN
Cj4gPiArCW11dGV4X2xvY2soJmZkYXRhLT5sb2NrKTsNCj4gPiAgDQo+ID4gIAlzd2l0Y2ggKGF0
dHIpIHsNCj4gPiAgCWNhc2UgaHdtb25fcG93ZXJfbWF4Og0KPiA+IEBAIC00MzgsNyArNDM4LDcg
QEAgc3RhdGljIGludCBwb3dlcl9od21vbl93cml0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0g
aHdtb25fc2Vuc29yX3R5cGVzIHR5cGUsDQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9DQo+ID4gIA0K
PiA+IC0JbXV0ZXhfdW5sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4gKwltdXRleF91bmxvY2soJmZk
YXRhLT5sb2NrKTsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gQEAgLTU4
OSw3ICs1ODksNyBAQCBzdGF0aWMgc3RydWN0IGRmbF9mZWF0dXJlX2RyaXZlciBmbWVfZmVhdHVy
ZV9kcnZzW10gPSB7DQo+ID4gIAl9LA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAtc3RhdGljIGxvbmcg
Zm1lX2lvY3RsX2NoZWNrX2V4dGVuc2lvbihzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0
YSAqcGRhdGEsDQo+ID4gK3N0YXRpYyBsb25nIGZtZV9pb2N0bF9jaGVja19leHRlbnNpb24oc3Ry
dWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSwNCj4gPiAgCQkJCSAgICAgIHVuc2lnbmVk
IGxvbmcgYXJnKQ0KPiA+ICB7DQo+ID4gIAkvKiBObyBleHRlbnNpb24gc3VwcG9ydCBmb3Igbm93
ICovDQo+ID4gQEAgLTYwMCwxOSArNjAwLDIxIEBAIHN0YXRpYyBpbnQgZm1lX29wZW4oc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKmZkZXYgPSBkZmxfZnBnYV9pbm9kZV90b19mZWF0dXJlX2Rldihpbm9k
ZSk7DQo+ID4gIAlzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZf
Z2V0X3BsYXRkYXRhKCZmZGV2LT5kZXYpOw0KPiANCj4gV2h5IG5vdCBkbyB0aGUgc2FtZSByZXBs
YWNlbWVudCBoZXJlPw0KDQpUaGlzIGhhcyBiZWVuIHByZXBhcmVkIGluIHRoZSBwYXRjaCAiZnBn
YTogZGZsOiBvbWl0IHVubmVlZGVkIG51bGwNCnBvaW50ZXIgY2hlY2sgZnJvbSB7YWZ1LGZtZX1f
b3BlbigpIiBmb2xsb3dlZCBieSB0aGUgcGRhdGEgLT4gZmRhdGENCnJlcGxhY2VtZW50IGluICJm
cGdhOiBkZmw6IHJlZmFjdG9yIGZ1bmN0aW9ucyB0byB0YWtlL3JldHVybiBmZWF0dXJlDQpkZXZp
Y2UgZGF0YSIuDQoNCj4gDQo+ID4gKwlzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRh
Ow0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gIAlpZiAoV0FSTl9PTighcGRhdGEpKQ0KPiA+
ICAJCXJldHVybiAtRU5PREVWOw0KPiA+ICANCj4gPiAtCW11dGV4X2xvY2soJnBkYXRhLT5sb2Nr
KTsNCj4gPiAtCXJldCA9IGRmbF9mZWF0dXJlX2Rldl91c2VfYmVnaW4ocGRhdGEsIGZpbHAtPmZf
ZmxhZ3MgJiBPX0VYQ0wpOw0KPiA+ICsJZmRhdGEgPSBwZGF0YTsNCj4gPiArCW11dGV4X2xvY2so
JmZkYXRhLT5sb2NrKTsNCj4gPiArCXJldCA9IGRmbF9mZWF0dXJlX2Rldl91c2VfYmVnaW4oZmRh
dGEsIGZpbHAtPmZfZmxhZ3MgJiBPX0VYQ0wpOw0KPiA+ICAJaWYgKCFyZXQpIHsNCj4gPiAgCQlk
ZXZfZGJnKCZmZGV2LT5kZXYsICJEZXZpY2UgRmlsZSBPcGVuZWQgJWQgVGltZXNcbiIsDQo+ID4g
LQkJCWRmbF9mZWF0dXJlX2Rldl91c2VfY291bnQocGRhdGEpKTsNCj4gPiArCQkJZGZsX2ZlYXR1
cmVfZGV2X3VzZV9jb3VudChmZGF0YSkpOw0KPiA+ICAJCWZpbHAtPnByaXZhdGVfZGF0YSA9IHBk
YXRhOw0KPiA+ICAJfQ0KPiA+IC0JbXV0ZXhfdW5sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4gKwlt
dXRleF91bmxvY2soJmZkYXRhLT5sb2NrKTsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+
ICB9DQo+ID4gQEAgLTYyMCwxOSArNjIyLDIwIEBAIHN0YXRpYyBpbnQgZm1lX29wZW4oc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApDQo+ID4gIHN0YXRpYyBpbnQgZm1lX3Jl
bGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbHApDQo+ID4gIHsNCj4g
PiAgCXN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YSA9IGZpbHAtPnByaXZh
dGVfZGF0YTsNCj4gPiAtCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBwZGF0YS0+ZGV2
Ow0KPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9IHBkYXRhOw0KPiAN
Cj4gZGl0dG8uDQoNClRoaXMgaGFzIGJlZW4gZG9uZSBpbiAiZnBnYTogZGZsOiByZWZhY3RvciBm
dW5jdGlvbnMgdG8gdGFrZS9yZXR1cm4NCmZlYXR1cmUgZGV2aWNlIGRhdGEiLg0KPiANCj4gPiAr
CXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBmZGF0YS0+ZGV2Ow0KPiA+ICAJc3RydWN0
IGRmbF9mZWF0dXJlICpmZWF0dXJlOw0KPiA+ICANCj4gPiAgCWRldl9kYmcoJnBkZXYtPmRldiwg
IkRldmljZSBGaWxlIFJlbGVhc2VcbiIpOw0KPiA+ICANCj4gPiAtCW11dGV4X2xvY2soJnBkYXRh
LT5sb2NrKTsNCj4gPiAtCWRmbF9mZWF0dXJlX2Rldl91c2VfZW5kKHBkYXRhKTsNCj4gPiArCW11
dGV4X2xvY2soJmZkYXRhLT5sb2NrKTsNCj4gPiArCWRmbF9mZWF0dXJlX2Rldl91c2VfZW5kKGZk
YXRhKTsNCj4gPiAgDQo+ID4gLQlpZiAoIWRmbF9mZWF0dXJlX2Rldl91c2VfY291bnQocGRhdGEp
KQ0KPiA+IC0JCWRmbF9mcGdhX2Rldl9mb3JfZWFjaF9mZWF0dXJlKHBkYXRhLCBmZWF0dXJlKQ0K
PiA+ICsJaWYgKCFkZmxfZmVhdHVyZV9kZXZfdXNlX2NvdW50KGZkYXRhKSkNCj4gPiArCQlkZmxf
ZnBnYV9kZXZfZm9yX2VhY2hfZmVhdHVyZShmZGF0YSwgZmVhdHVyZSkNCj4gPiAgCQkJZGZsX2Zw
Z2Ffc2V0X2lycV90cmlnZ2VycyhmZWF0dXJlLCAwLA0KPiA+ICAJCQkJCQkgIGZlYXR1cmUtPm5y
X2lycXMsIE5VTEwpOw0KPiA+IC0JbXV0ZXhfdW5sb2NrKCZwZGF0YS0+bG9jayk7DQo+ID4gKwlt
dXRleF91bmxvY2soJmZkYXRhLT5sb2NrKTsNCj4gPiAgDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAg
fQ0KPiA+IEBAIC02NDAsNyArNjQzLDggQEAgc3RhdGljIGludCBmbWVfcmVsZWFzZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkNCj4gPiAgc3RhdGljIGxvbmcgZm1lX2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFy
ZykNCj4gPiAgew0KPiA+ICAJc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRmb3JtX2RhdGEgKnBkYXRh
ID0gZmlscC0+cHJpdmF0ZV9kYXRhOw0KPiA+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diA9IHBkYXRhLT5kZXY7DQo+ID4gKwlzdHJ1Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRh
ID0gcGRhdGE7DQo+IA0KPiBkaXR0bw0KDQpUaGlzIGhhcyBiZWVuIGRvbmUgaW4gImZwZ2E6IGRm
bDogcmVmYWN0b3IgZnVuY3Rpb25zIHRvIHRha2UvcmV0dXJuDQpmZWF0dXJlIGRldmljZSBkYXRh
Ii4NCg0KVGhhbmtzLA0KUGV0ZXINCg0KPiANCj4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYgPSBmZGF0YS0+ZGV2Ow0KPiA+ICAJc3RydWN0IGRmbF9mZWF0dXJlICpmOw0KPiA+ICAJ
bG9uZyByZXQ7DQo+ID4gIA0KPiA+IEBAIC02NTAsNyArNjU0LDcgQEAgc3RhdGljIGxvbmcgZm1l
X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25n
IGFyZykNCj4gPiAgCWNhc2UgREZMX0ZQR0FfR0VUX0FQSV9WRVJTSU9OOg0KPiA+ICAJCXJldHVy
biBERkxfRlBHQV9BUElfVkVSU0lPTjsNCj4gPiAgCWNhc2UgREZMX0ZQR0FfQ0hFQ0tfRVhURU5T
SU9OOg0KPiA+IC0JCXJldHVybiBmbWVfaW9jdGxfY2hlY2tfZXh0ZW5zaW9uKHBkYXRhLCBhcmcp
Ow0KPiA+ICsJCXJldHVybiBmbWVfaW9jdGxfY2hlY2tfZXh0ZW5zaW9uKGZkYXRhLCBhcmcpOw0K
PiA+ICAJZGVmYXVsdDoNCj4gPiAgCQkvKg0KPiA+ICAJCSAqIExldCBzdWItZmVhdHVyZSdzIGlv
Y3RsIGZ1bmN0aW9uIHRvIGhhbmRsZSB0aGUgY21kLg0KPiA+IEBAIC02NTgsNyArNjYyLDcgQEAg
c3RhdGljIGxvbmcgZm1lX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21k
LCB1bnNpZ25lZCBsb25nIGFyZykNCj4gPiAgCQkgKiBoYW5kbGVkIGluIHRoaXMgc3ViIGZlYXR1
cmUsIGFuZCByZXR1cm5zIDAgb3Igb3RoZXINCj4gPiAgCQkgKiBlcnJvciBjb2RlIGlmIGNtZCBp
cyBoYW5kbGVkLg0KPiA+ICAJCSAqLw0KPiA+IC0JCWRmbF9mcGdhX2Rldl9mb3JfZWFjaF9mZWF0
dXJlKHBkYXRhLCBmKSB7DQo+ID4gKwkJZGZsX2ZwZ2FfZGV2X2Zvcl9lYWNoX2ZlYXR1cmUoZmRh
dGEsIGYpIHsNCj4gPiAgCQkJaWYgKGYtPm9wcyAmJiBmLT5vcHMtPmlvY3RsKSB7DQo+ID4gIAkJ
CQlyZXQgPSBmLT5vcHMtPmlvY3RsKHBkZXYsIGYsIGNtZCwgYXJnKTsNCj4gPiAgCQkJCWlmIChy
ZXQgIT0gLUVOT0RFVikNCj4gPiBAQCAtNjcyLDI3ICs2NzYsMjcgQEAgc3RhdGljIGxvbmcgZm1l
X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25n
IGFyZykNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQgZm1lX2Rldl9pbml0KHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9y
bV9kYXRhICpwZGF0YSA9IGRldl9nZXRfcGxhdGRhdGEoJnBkZXYtPmRldik7DQo+ID4gKwlzdHJ1
Y3QgZGZsX2ZlYXR1cmVfZGV2X2RhdGEgKmZkYXRhID0gdG9fZGZsX2ZlYXR1cmVfZGV2X2RhdGEo
JnBkZXYtPmRldik7DQo+ID4gIAlzdHJ1Y3QgZGZsX2ZtZSAqZm1lOw0KPiA+ICANCj4gPiAgCWZt
ZSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmZtZSksIEdGUF9LRVJORUwpOw0K
PiA+ICAJaWYgKCFmbWUpDQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gIA0KPiA+IC0JbXV0
ZXhfbG9jaygmcGRhdGEtPmxvY2spOw0KPiA+IC0JZGZsX2ZwZ2FfcGRhdGFfc2V0X3ByaXZhdGUo
cGRhdGEsIGZtZSk7DQo+ID4gLQltdXRleF91bmxvY2soJnBkYXRhLT5sb2NrKTsNCj4gPiArCW11
dGV4X2xvY2soJmZkYXRhLT5sb2NrKTsNCj4gPiArCWRmbF9mcGdhX2ZkYXRhX3NldF9wcml2YXRl
KGZkYXRhLCBmbWUpOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZmZGF0YS0+bG9jayk7DQo+ID4gIA0K
PiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyB2b2lkIGZtZV9kZXZf
ZGVzdHJveShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICB7DQo+ID4gLQlzdHJ1
Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBkZXZfZ2V0X3BsYXRkYXRhKCZw
ZGV2LT5kZXYpOw0KPiA+ICsJc3RydWN0IGRmbF9mZWF0dXJlX2Rldl9kYXRhICpmZGF0YSA9IHRv
X2RmbF9mZWF0dXJlX2Rldl9kYXRhKCZwZGV2LT5kZXYpOw0KPiA+ICANCj4gPiAtCW11dGV4X2xv
Y2soJnBkYXRhLT5sb2NrKTsNCj4gPiAtCWRmbF9mcGdhX3BkYXRhX3NldF9wcml2YXRlKHBkYXRh
LCBOVUxMKTsNCj4gPiAtCW11dGV4X3VubG9jaygmcGRhdGEtPmxvY2spOw0KPiA+ICsJbXV0ZXhf
bG9jaygmZmRhdGEtPmxvY2spOw0KPiA+ICsJZGZsX2ZwZ2FfZmRhdGFfc2V0X3ByaXZhdGUoZmRh
dGEsIE5VTEwpOw0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZmZGF0YS0+bG9jayk7DQo+ID4gIH0NCj4g
PiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGZtZV9mb3BzID0g
ew0KPiA+IC0tIA0KPiA+IDIuNDQuMA0KPiA+IA0KPiA+IA0KDQo=

