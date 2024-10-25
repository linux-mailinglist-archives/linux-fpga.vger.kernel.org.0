Return-Path: <linux-fpga+bounces-916-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BCE9B12F6
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FBA1C20CC7
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2CD217F5A;
	Fri, 25 Oct 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxWiTIRt"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD799217F27;
	Fri, 25 Oct 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896375; cv=fail; b=d6x1g0NRrVL2o8/nzTINILZL3CxPD4yaMlEv39Duaw+4xi4VscEJZBn7FvXD/hQTGVl4ABOpNIJ/XPGBWldk24OWse5a8G0zTJjc69CCsPkjj1Gy6IfpvA8srIvf/jwT9sbaLhO/0q04oHuoqO+tYJQQXChz65dzkfZtSckW5e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896375; c=relaxed/simple;
	bh=HzhpZUkXATpyGtAVRpxZK6zYfPlqz2usgf1BiMbJPMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XP7RsMzhea1JTv0ncyADsiDSe+p5NgA68JxVx9hJpJMpjHX9gTrz0JDXlSrt+c6a33pAgRVqMLEgNUWX8cOXflIH7FrWdcMtFppnxPfw+96KLb0aJcIXMZC+I9giQAVHp3pHQI0PJENcLMFTaIpxIqg+RrCZ/wKhvbDMYqzVQcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxWiTIRt; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729896373; x=1761432373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HzhpZUkXATpyGtAVRpxZK6zYfPlqz2usgf1BiMbJPMc=;
  b=WxWiTIRtrOgpP6UQE1863kxnmhOx4F5mdobxyYQlNfbNRbQITdHsTVg6
   KOk6gQcDkc5O67TKDa0yIXUg9AtOyiU68Zx2Y0vSaxbRZzuV8FjHuNMm9
   xxqcFLaRT6KEkEcd5dBFTHlaFEJByKWe90QmBn27Mw4coSyXBq4D3EZwY
   gEkgxA98/gYkG9AJ4PTRkXFglMrbSnVm8bb8Mj8cH3OLYiQR5Aka+bEl7
   1dSOeY332pJMMjEuq9/ObqHc/NTtgomQgizTpQ+dRRrfUOe74FWLeR5Sq
   5/tVtSswOKpvc+dAJT3dKiUcLeensoUsvu8bo9OzJSpZyUW0qfkK73TAN
   g==;
X-CSE-ConnectionGUID: gXPZTF/ASxm585PR8RhsVQ==
X-CSE-MsgGUID: jnpFF8PcQEiG6bR09k+tMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="17211526"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="17211526"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:46:12 -0700
X-CSE-ConnectionGUID: 7XTh8Qu8R8K8C3/MOO2Diw==
X-CSE-MsgGUID: +tgaJv79QL+I0g/6RX4dUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="118510116"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 15:46:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 15:46:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 15:46:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 15:46:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs4fNrH27IcakHNjTnP0L2v/O/VWWZN1shcejuuSCBoSv8lyrnPkLL/NpPOtUy7xVmql5uHpC3bnBBAP2ingZYdWbNUesiUOJKKgrTdNbVgYtSeQ/BdDjfVmxY12vq4maipW7iMHIcIvYRUTmTJpKqJ5tLeJVUjCZei7LQT3UKCTHs/kjq2z7CGv7Qv4wj6ijdYK+0o72fPhFgKHxrom0XvXv2mq8d7+I+m8FyDqTI+kfPrY8icWoaQ9uzo4O43o9b+JUbU0fDAJkepSI0Y+R6fm6xaV0SN5WhqMf1rhVReodeXIB13NQNMUchF5f/2fwf4QxVG5myCEqWGk5ENSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzhpZUkXATpyGtAVRpxZK6zYfPlqz2usgf1BiMbJPMc=;
 b=W4uK2wifBJA27ggZPp3LKSsAIWTxSMUGdle/yIL6nkDID0aj/r7ABw+5GQGXARxLjqF3HlG9zEQNBOOfwiUP0Uh4X6HJJMvoLfSLnUhrFZESMZtEkKOeyppnrSY9XftN13x+o1EvditMicEltUyB5NJVp/mekAkqDStoa6ySj32mwLLHnBHfTQ2k5ZGarlMIlNn9gdN5fLVNqlTbka2qeNz/PGJRsyhJVbzaI2Iy4yVeRY/fjeYC/M/zzeFrrL0/hdY87JnR63Sfg3zUSsjTpXSsA+7oZD+L0akZSRiRGOBnBl/StlOrSp+XfDoRCvz4kPoQ4p2KPrKKx3FmQ1v8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SA3PR11MB7463.namprd11.prod.outlook.com (2603:10b6:806:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 22:46:07 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::9468:437a:a5dd:5f6%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 22:46:07 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao"
	<hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 7/9] fpga: dfl: store FIU type in feature platform data
Thread-Topic: [PATCH v3 7/9] fpga: dfl: store FIU type in feature platform
 data
Thread-Index: AQHbJy+tRNr4OYUn/Um2GLQozV0+vg==
Date: Fri, 25 Oct 2024 22:46:06 +0000
Message-ID: <a8e0600dff8c0ab296756051fc40baf05e8c9613.camel@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
	 <20240919203430.1278067-8-peter.colberg@intel.com>
	 <ZvJtg/IFmZAiaJBT@yilunxu-OptiPlex-7050>
In-Reply-To: <ZvJtg/IFmZAiaJBT@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SA3PR11MB7463:EE_
x-ms-office365-filtering-correlation-id: 19ba2fb7-5bc2-4937-75fa-08dcf546d043
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NVJTVHJRVEhOZm1FamdVclJUZ1E3UERsUDJwZ1RiWVR5aldVRHRocDVNL0Zj?=
 =?utf-8?B?R0loYUVacEhMN041dHNSemJnUW9oVTJSM2o4aXFMdGJ5TWpTN2xEalZhVVNC?=
 =?utf-8?B?ZDB1aDl6dExoYjI4eHZySEF6MEY0dzd1L0h4S29FQ3NqdkQ1bGZ0L01jbFZj?=
 =?utf-8?B?Si9TbWZnSDBUMExZUG1vM1lGWlZZcHpiekVSaUdwMEJZUjBRRnhVcVJjNGVZ?=
 =?utf-8?B?VjFmR0czYkV3emRURldZMTJPcm5sME9MQk9QRmloZDdMUVhUeTJNcVpueDJ1?=
 =?utf-8?B?UEVJYXJWNlp2Ump2bHZ2ZUFPYVFrK3g2WTU1WFNzWi9EUjA5KzdUc2VjdHlK?=
 =?utf-8?B?R3RtTVJ3eTVCWWJUbDhjbDRRM1lFcGIzOU1YNWYxSHNvKzUrV2NyWmlLRDBa?=
 =?utf-8?B?Mi92b01RUU1VN0tmQlNxMlRvK3NGRDhFWmxFbjRUcmRHR1h3OE9MWHpEdnpw?=
 =?utf-8?B?WFZzaFVYQXl1TFlIVWd1Vmc4MnUySGI0MDVFWG8xNUkycVY2YlF3Y2dJaU1y?=
 =?utf-8?B?bWZXNC81ZkpSMDNFWHBZaGwwcG90T01VNDVWT2syb1BDUjNFcCttMWNOd3lB?=
 =?utf-8?B?OU52N3BycHNSMUJlRkFHRVZtdTM1SWpOUnplR3kydDhFc0xVa092THB2WFQy?=
 =?utf-8?B?Y2k3US95bGpORlNEWk9TM3hwVTdkdFZubWhlVXNSc2xLSWw1a1I0akNRZEZN?=
 =?utf-8?B?TUtWSmh4c0NXRWg5YkZJT2RDZ29IdHgvUlFEbmVqZXhXRUZaTVZRcHc4THhJ?=
 =?utf-8?B?dktJMXNRcFNNZUw4OFhvQm8xejdpRXIwWWVIS2Joc3lSUVJxL2xrUkswYXdT?=
 =?utf-8?B?bVBDYjNjbEg3eTNaZW42NElhNk10cTZSM0VNSUlISUpIenhySElHSFRzQ0x2?=
 =?utf-8?B?dTJvQ0FqUlU0YU0xd1ZTQ1pKcytyWDhSb0FhbFVMSVllZnpDaW0xckR1RVdR?=
 =?utf-8?B?SGRzWTNhVjcyWE5Ta1I1VnFCcDlnVWgwOHIwMG9aL1VZUmxvd0k2ZE9ZSHNR?=
 =?utf-8?B?MmYvTWFISkErT2N5ZnNEQktUMWt6d3laZkZoQ2RLbE1JSkdmU1duVE9Xd0pF?=
 =?utf-8?B?S0pIVHZQdlZtWkpFdk01Z3FVN216NklVWlgwQnRNSm9VREZsOGtrLzUvTVJ6?=
 =?utf-8?B?VktZZS9Ob2tGeUc4SytGYm5vR2p1bmJGL1IvdUVtOWllcUhCWEI5TG5STkww?=
 =?utf-8?B?NVE3anBOOWNZakpudmRBVG5pQ21XUlg4STRRaERvQnlNcFhXbXJISGszZmlU?=
 =?utf-8?B?UjVSTjRlS1hQTThicmlsekxQSTdIdENDMWp0OXVNZDlEeVVqTm8xUGtpYmMv?=
 =?utf-8?B?ZkxRMUpMS2RCa3pEQVVtZUJIdXNSVjZqZncrK2pKeWhSOVBRZG9ZY0xSNGJH?=
 =?utf-8?B?YThKNWtNd2o4YXk2NVJaVFQvbXNuekVSR1RLK0EyYnE4aEo5RFg0R2VMaGVt?=
 =?utf-8?B?bGdQWjRic001ZmlvRmpCYlg3TzhxeFZ3bVVLN24rbUlEc1VSOE5hZTFPdXRH?=
 =?utf-8?B?R3d1Q3FjYUpZSzRlSmhlS3pOTDgxMHZhc2tSN3lSMTZ0K2hVTThzTTNCOHRa?=
 =?utf-8?B?NytudnI4NCtQYnlyL2ZZNCtkNHNiTVdWb1NHUUxEL0VvT3drYmk0b3I4R0Mx?=
 =?utf-8?B?aTZkK01aeUpTUGI4akpmTU5sK2g1WXBRa0RtOURhYjJOU2RhYTh6bHd4VTVO?=
 =?utf-8?B?ZnYzVFRPT2ZKU2xNTVI0SkcyanVva0VFeExUS2xlTHQ3MEhYTFh5NnROdzNL?=
 =?utf-8?B?clU0UDZTaDJoOXVHSDRJNDlPdmhnVVg0bVI5MGV6N2V0ZGt1UlEyOHZRNWF2?=
 =?utf-8?Q?jOCKNSAtZ13HIuN+g6x45OcBH8cjtm9QEQs5I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnNwcWN5SFR3RXFiSkQ2eXVSaGNRV2tENEpuK2p2eDNIeG5iSUFUZWdibHo0?=
 =?utf-8?B?NHdJUEtVRUZhT0kzR21UTGNFZHU1TlcraHBnMXVua1d2UXdxL0V6TCtwRWlM?=
 =?utf-8?B?MStzYXRnMmxKY0Q1cEtmTyt3YUVnamRGRzZ4dVp5TjlJY0laMnVRV3lJaUw1?=
 =?utf-8?B?VjlFck5VMVgyQ2NnajhaWWM0T0Mxc0JUWktOQURSSG8zRTQvUTU0dnRZWlB4?=
 =?utf-8?B?dDdXUkNyc2d1cThHQUovL2VSbkdZZHp1YytJMGdqdVM2Y1pOanA3Z05vczVH?=
 =?utf-8?B?dDVsYzcrVVhCd3d2SlJZOFB5ZWlRWVlTT25TRUZwMkJvM1R6QTV6bk1HMzJh?=
 =?utf-8?B?c2ZLNGtoak5hV0dIbTU3VDU5VEJXWFVaUGV6Z3lPU3lTRjJRbWtMVkFSVFFm?=
 =?utf-8?B?eEwyakcvdmt3MDVzRHEyeTJ2NUpkY2dvZ0FOV1FuSVZ0UjNRTlMxckliVU1M?=
 =?utf-8?B?cVQwQm1MSlBHZGhHVzJBM2VhV0o4L0RGWGRnc2FtOVNFVmlsYlR0OGxPcTFm?=
 =?utf-8?B?WElWZWc5UCtBdWtDNTlERmlTRkVHUWNodU9RblVXekVsbkZqRWNDTTBaSG5q?=
 =?utf-8?B?UXVLMVlTR2Q3QWNqMFJiRy9XYWFycVVJZUw2SklZNnF3R3c0ZHhrbStqY0Rq?=
 =?utf-8?B?MUEreHExYlNKakU0b3VVeEl0WTV2WHZCNG5EcmRvR1QxbjllQ2xKR3UwZk01?=
 =?utf-8?B?c2o1dzkwODlGZ09GUkk3S09Jejk2SmpnQ0hiNXRVRWROdUd3SFV4alpkaDFG?=
 =?utf-8?B?M1c1UkVtcEJsTzFsNXhpVjZtUHdCVDNqS0V0NzBQU1NZS2h6STJmUHovRGgz?=
 =?utf-8?B?MTdhRFJKNTRyWndNaFA1RDNoZUo4WHJYRHBLRHcvaFN2ZWh3TnEzMCtEc0V5?=
 =?utf-8?B?MCtYWnFsUWUyQzBRUitDVGNKd1A3eHgxRy82WnFIQ05JU2liTU9JZHc3NWNO?=
 =?utf-8?B?bnhmc3d2UEs5Vnl6ejFDeGpiYnBZbU90aEVsYU4yR0JBM0dkaFY1TWpWWGJ2?=
 =?utf-8?B?UjhxK200bnZWOExHOVgzdmNOU2ZYbWRQZytTWGhvWmxINHdTL2E4ejBtbUNr?=
 =?utf-8?B?MkQwZ3VIbGlmUHBBUGtGWmVMaDZacUp3dnFkM1MrencvWDkvSzNzYmhqM2Ur?=
 =?utf-8?B?dVE0OGxoaFNJZGd6RitZcTYraDE1aFJmdUpTNWZ3b1dHaWNla0R5SStod0oz?=
 =?utf-8?B?YnZybTkvK1BTTHdRNXVZa25UT2QyWkdUd054SHYwT1BwL1VjdnppVmdZYW45?=
 =?utf-8?B?Ty9DVm1iMjVwVnYvcHE5VGl2bUxuUlRISmJQTG1hcTBycFJ1NzI4ZFpUVE0z?=
 =?utf-8?B?ZHNXekxqWUg1V3FLVHpRcTBEaUdPUXZUR2ZGYUFxL05hSnBBL2ZSVGI5WS9H?=
 =?utf-8?B?UGhYaFZ2SzNQeFdmTTZJNG1Gd2dvcWU5WVFseHg3MGdMUU1kZmhSeHFmY3po?=
 =?utf-8?B?ZVh4WUI0cllIaUpTSUF6WlJwcnBSN1VHVm1zWUtKTWNwb1QxamtGMUlRaDR0?=
 =?utf-8?B?YjdKOC9WUmxvSEw3ejl5V1Y1N08wZksxRk5PSWcxazFjNkJkQ3hwbDJ1MHU0?=
 =?utf-8?B?bGI4RWIrNVZ4bTZDYkpIdVhIdmF0eko0ZjlHd1U4N0g3aFhvaUNiNngvN1R5?=
 =?utf-8?B?OURkN3NRaGRNcmEvbGtkbG5Hckw3QkFvWDN2eGErdld2Y2ZiMjJlSTFKdkgy?=
 =?utf-8?B?R1hQVEYvejlDenI0b0JrWTBLSUhJM2J4MDYwSSs1TEZhQW5KMTJJdEVSSjE0?=
 =?utf-8?B?NmRDdmQzYk4vM2d1ZWZLSzRGbFZ0YXN4eGZNaTFoMUNKaSsxcmp6TEhrc0Q2?=
 =?utf-8?B?NmgvNnVDTzRvZEc0RGpFUjgyUTRLZTJsbjY0dWU3T1luQVozNkxFMmlaa0Yw?=
 =?utf-8?B?VCs1Q050SStoMUE1NVV4dW5Pelo2dkJZMDZLZUZEeUVvUytkQ3JXa3JKcXN3?=
 =?utf-8?B?d2RvaFF0QmdNQlZEVGlVTDdqdUFnOFVjeXhvV1BzZjg0UkxPTVRLRk03cW1L?=
 =?utf-8?B?OGxVL3VCTWl0NlJ6QUtIM3hEbkVoZHorV3BpYUl0OElEUUkvS3kvazl3ZGtI?=
 =?utf-8?B?ekJnQmhaSUc0cGlHZmxmeWR3VEJJbnBLcXBMSTlDeGw3bTFaODZCbUJUdGhq?=
 =?utf-8?B?cWI2b1cvdzMzVnQ3b0FhZVFncWJTNkZLVmkwZHZjUDE3M3prS2JRMlpxYTJs?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4DA147C16114E42B81FED5C0183B7E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ba2fb7-5bc2-4937-75fa-08dcf546d043
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 22:46:07.0007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiGp7q8KUayb3bQYczrRu4etkAYYD/8ulrHssjJzjtK2A/seKACKkFUo8rTmGUeTYx9haaUakQ6xTPkclD36MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7463
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDE1OjQyICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMTksIDIwMjQgYXQgMDQ6MzQ6MjhQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBSZW1vdmUgdGhlIGxvY2FsIGZ1bmN0aW9uIGZlYXR1cmVfZGV2X2lkX3R5cGUoKSBp
biBmYXZvdXIgb2YgcGVyc2lzdGluZw0KPiA+IHRoZSBGSVUgdHlwZSBpbiBzdHJ1Y3QgZGZsX2Zl
YXR1cmVfcGxhdGZvcm1fZGF0YS4gQWRkIHR5cGUgdG8gc3RydWN0DQo+ID4gYnVpbGRfZmVhdHVy
ZV9kZXZzX2luZm8gYW5kIGRyb3AgYXJndW1lbnQgdG8gYnVpbGRfaW5mb19jcmVhdGVfZGV2KCku
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgQ29sYmVyZyA8cGV0ZXIuY29sYmVyZ0Bp
bnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJs
YWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9mcGdhL2RmbC5jIHwg
NTcgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBk
cml2ZXJzL2ZwZ2EvZGZsLmggfCAgMyArKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNl
cnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9mcGdhL2RmbC5jIGIvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gaW5kZXggZTY0NGViOWZkZTM5
Li45NjEwZWYxZWMyZmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4g
KysrIGIvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gQEAgLTExOSwxNyArMTE5LDYgQEAgc3RhdGlj
IHZvaWQgZGZsX2lkX2ZyZWUoZW51bSBkZmxfaWRfdHlwZSB0eXBlLCBpbnQgaWQpDQo+ID4gIAlt
dXRleF91bmxvY2soJmRmbF9pZF9tdXRleCk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLXN0YXRpYyBl
bnVtIGRmbF9pZF90eXBlIGZlYXR1cmVfZGV2X2lkX3R5cGUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gPiAtew0KPiA+IC0JaW50IGk7DQo+ID4gLQ0KPiA+IC0JZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoZGZsX2RldnMpOyBpKyspDQo+ID4gLQkJaWYgKCFzdHJjbXAoZGZsX2Rl
dnNbaV0ubmFtZSwgcGRldi0+bmFtZSkpDQo+ID4gLQkJCXJldHVybiBpOw0KPiA+IC0NCj4gPiAt
CXJldHVybiBERkxfSURfTUFYOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgZW51bSBkZmxf
aWRfdHlwZSBkZmhfaWRfdG9fdHlwZSh1MTYgaWQpDQo+ID4gIHsNCj4gPiAgCWludCBpOw0KPiA+
IEBAIC0zNzksNyArMzY4LDcgQEAgZGZsX2Rldl9hZGQoc3RydWN0IGRmbF9mZWF0dXJlX3BsYXRm
b3JtX2RhdGEgKnBkYXRhLA0KPiA+ICAJaWYgKHJldCkNCj4gPiAgCQlnb3RvIHB1dF9kZXY7DQo+
ID4gIA0KPiA+IC0JZGRldi0+dHlwZSA9IGZlYXR1cmVfZGV2X2lkX3R5cGUocGRldik7DQo+ID4g
KwlkZGV2LT50eXBlID0gcGRhdGEtPnR5cGU7DQo+ID4gIAlkZGV2LT5mZWF0dXJlX2lkID0gZmVh
dHVyZS0+aWQ7DQo+ID4gIAlkZGV2LT5yZXZpc2lvbiA9IGZlYXR1cmUtPnJldmlzaW9uOw0KPiA+
ICAJZGRldi0+ZGZoX3ZlcnNpb24gPSBmZWF0dXJlLT5kZmhfdmVyc2lvbjsNCj4gPiBAQCAtNjkz
LDYgKzY4Miw3IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGRmbF9mcGdhX2Rldl9vcHNfdW5yZWdpc3Rl
cik7DQo+ID4gICAqIEBpcnFfdGFibGU6IExpbnV4IElSUSBudW1iZXJzIGZvciBhbGwgaXJxcywg
aW5kZXhlZCBieSBsb2NhbCBpcnEgaW5kZXggb2YNCj4gPiAgICoJICAgICAgIHRoaXMgZGV2aWNl
Lg0KPiA+ICAgKiBAZmVhdHVyZV9kZXY6IGN1cnJlbnQgZmVhdHVyZSBkZXZpY2UuDQo+ID4gKyAq
IEB0eXBlOiB0aGUgY3VycmVudCBGSVUgdHlwZS4NCj4gPiAgICogQGlvYWRkcjogaGVhZGVyIHJl
Z2lzdGVyIHJlZ2lvbiBhZGRyZXNzIG9mIGN1cnJlbnQgRklVIGluIGVudW1lcmF0aW9uLg0KPiA+
ICAgKiBAc3RhcnQ6IHJlZ2lzdGVyIHJlc291cmNlIHN0YXJ0IG9mIGN1cnJlbnQgRklVLg0KPiA+
ICAgKiBAbGVuOiBtYXggcmVnaXN0ZXIgcmVzb3VyY2UgbGVuZ3RoIG9mIGN1cnJlbnQgRklVLg0K
PiA+IEBAIC03MDYsNiArNjk2LDcgQEAgc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvIHsN
Cj4gPiAgCWludCAqaXJxX3RhYmxlOw0KPiA+ICANCj4gPiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKmZlYXR1cmVfZGV2Ow0KPiA+ICsJZW51bSBkZmxfaWRfdHlwZSB0eXBlOw0KPiA+ICAJdm9p
ZCBfX2lvbWVtICppb2FkZHI7DQo+ID4gIAlyZXNvdXJjZV9zaXplX3Qgc3RhcnQ7DQo+ID4gIAly
ZXNvdXJjZV9zaXplX3QgbGVuOw0KPiA+IEBAIC03NTIsMTMgKzc0MywxMiBAQCBzdGF0aWMgdm9p
ZCBkZmxfZnBnYV9jZGV2X2FkZF9wb3J0X2RhdGEoc3RydWN0IGRmbF9mcGdhX2NkZXYgKmNkZXYs
DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgZGZsX2ZlYXR1cmVfcGxhdGZvcm1fZGF0YSAqDQo+ID4gIGJp
bmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5m
byAqYmluZm8pDQo+ID4gIHsNCj4gPiArCWVudW0gZGZsX2lkX3R5cGUgdHlwZSA9IGJpbmZvLT50
eXBlOw0KPiA+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZmRldiA9IGJpbmZvLT5mZWF0dXJl
X2RldjsNCj4gPiAgCXN0cnVjdCBkZmxfZmVhdHVyZV9wbGF0Zm9ybV9kYXRhICpwZGF0YTsNCj4g
PiAgCXN0cnVjdCBkZmxfZmVhdHVyZV9pbmZvICpmaW5mbywgKnA7DQo+ID4gLQllbnVtIGRmbF9p
ZF90eXBlIHR5cGU7DQo+IA0KPiBNb3ZlIHRoaXMgbGluZSB1cCBicmVha3MgdGhlIHJldmVyc2Ug
WG1hcyB0cmVlLCBzZWVtcyBubyBuZWVkLg0KDQpUaGlzIGhhcyBiZWVuIGRvbmUgaW4gdGhlIHJl
dmlzZWQgcGF0Y2ggImZwZ2E6IGRmbDogc3RvcmUgRklVIHR5cGUgaW4NCmZlYXR1cmUgcGxhdGZv
cm0gZGF0YSIuDQoNCj4gDQo+ID4gIAlpbnQgcmV0LCBpbmRleCA9IDAsIHJlc19pZHggPSAwOw0K
PiA+ICANCj4gPiAtCXR5cGUgPSBmZWF0dXJlX2Rldl9pZF90eXBlKGZkZXYpOw0KPiA+ICAJaWYg
KFdBUk5fT05fT05DRSh0eXBlID49IERGTF9JRF9NQVgpKQ0KPiA+ICAJCXJldHVybiBFUlJfUFRS
KC1FSU5WQUwpOw0KPiA+ICANCj4gPiBAQCAtNzczLDYgKzc2Myw3IEBAIGJpbmZvX2NyZWF0ZV9m
ZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+
ID4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ID4gIA0KPiA+ICAJcGRhdGEtPmRldiA9
IGZkZXY7DQo+ID4gKwlwZGF0YS0+dHlwZSA9IHR5cGU7DQo+ID4gIAlwZGF0YS0+bnVtID0gYmlu
Zm8tPmZlYXR1cmVfbnVtOw0KPiA+ICAJcGRhdGEtPmRmbF9jZGV2ID0gYmluZm8tPmNkZXY7DQo+
ID4gIAlwZGF0YS0+aWQgPSBGRUFUVVJFX0RFVl9JRF9VTlVTRUQ7DQo+ID4gQEAgLTg2MSwxNCAr
ODUyLDExIEBAIGJpbmZvX2NyZWF0ZV9mZWF0dXJlX2Rldl9kYXRhKHN0cnVjdCBidWlsZF9mZWF0
dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQNCj4g
PiAtYnVpbGRfaW5mb19jcmVhdGVfZGV2KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAq
YmluZm8sDQo+ID4gLQkJICAgICAgZW51bSBkZmxfaWRfdHlwZSB0eXBlKQ0KPiA+ICtidWlsZF9p
bmZvX2NyZWF0ZV9kZXYoc3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4g
PiAgew0KPiA+ICsJZW51bSBkZmxfaWRfdHlwZSB0eXBlID0gYmluZm8tPnR5cGU7DQo+ID4gIAlz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpmZGV2Ow0KPiA+ICANCj4gPiAtCWlmICh0eXBlID49IERG
TF9JRF9NQVgpDQo+ID4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gLQ0KPiA+ICAJLyoNCj4gPiAg
CSAqIHdlIHVzZSAtRU5PREVWIGFzIHRoZSBpbml0aWFsaXphdGlvbiBpbmRpY2F0b3Igd2hpY2gg
aW5kaWNhdGVzDQo+ID4gIAkgKiB3aGV0aGVyIHRoZSBpZCBuZWVkIHRvIGJlIHJlY2xhaW1lZA0K
PiA+IEBAIC05MDUsNyArODkzLDcgQEAgc3RhdGljIGludCBidWlsZF9pbmZvX2NvbW1pdF9kZXYo
c3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbykNCj4gPiAgCWlmIChyZXQpDQo+
ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gLQlpZiAoZmVhdHVyZV9kZXZfaWRfdHlwZShi
aW5mby0+ZmVhdHVyZV9kZXYpID09IFBPUlRfSUQpDQo+ID4gKwlpZiAoYmluZm8tPnR5cGUgPT0g
UE9SVF9JRCkNCj4gPiAgCQlkZmxfZnBnYV9jZGV2X2FkZF9wb3J0X2RhdGEoYmluZm8tPmNkZXYs
IHBkYXRhKTsNCj4gPiAgCWVsc2UNCj4gPiAgCQliaW5mby0+Y2Rldi0+Zm1lX2RldiA9IGdldF9k
ZXZpY2UoJmJpbmZvLT5mZWF0dXJlX2Rldi0+ZGV2KTsNCj4gPiBAQCAtOTE5LDYgKzkwNyw5IEBA
IHN0YXRpYyBpbnQgYnVpbGRfaW5mb19jb21taXRfZGV2KHN0cnVjdCBidWlsZF9mZWF0dXJlX2Rl
dnNfaW5mbyAqYmluZm8pDQo+ID4gIAkgKi8NCj4gPiAgCWJpbmZvLT5mZWF0dXJlX2RldiA9IE5V
TEw7DQo+ID4gIA0KPiA+ICsJLyogcmVzZXQgdGhlIGJpbmZvIGZvciBuZXh0IEZJVSAqLw0KPiA+
ICsJYmluZm8tPnR5cGUgPSBERkxfSURfTUFYOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+
ICB9DQo+ID4gIA0KPiA+IEBAIC05MzEsOCArOTIyLDcgQEAgc3RhdGljIHZvaWQgYnVpbGRfaW5m
b19mcmVlKHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8pDQo+ID4gIAkgKiBi
dWlsZF9pbmZvX2NyZWF0ZV9kZXYoKQ0KPiA+ICAJICovDQo+ID4gIAlpZiAoYmluZm8tPmZlYXR1
cmVfZGV2ICYmIGJpbmZvLT5mZWF0dXJlX2Rldi0+aWQgPj0gMCkgew0KPiA+IC0JCWRmbF9pZF9m
cmVlKGZlYXR1cmVfZGV2X2lkX3R5cGUoYmluZm8tPmZlYXR1cmVfZGV2KSwNCj4gPiAtCQkJICAg
IGJpbmZvLT5mZWF0dXJlX2Rldi0+aWQpOw0KPiA+ICsJCWRmbF9pZF9mcmVlKGJpbmZvLT50eXBl
LCBiaW5mby0+ZmVhdHVyZV9kZXYtPmlkKTsNCj4gPiAgDQo+ID4gIAkJbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKGZpbmZvLCBwLCAmYmluZm8tPnN1Yl9mZWF0dXJlcywgbm9kZSkgew0KPiA+ICAJ
CQlsaXN0X2RlbCgmZmluZm8tPm5vZGUpOw0KPiA+IEBAIC0xMDMwLDcgKzEwMjAsNyBAQCBzdGF0
aWMgaW50IHBhcnNlX2ZlYXR1cmVfaXJxcyhzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8g
KmJpbmZvLA0KPiA+ICAJCSAqIEluc3RlYWQsIGZlYXR1cmVzIHdpdGggaW50ZXJydXB0IGZ1bmN0
aW9uYWxpdHkgcHJvdmlkZQ0KPiA+ICAJCSAqIHRoZSBpbmZvcm1hdGlvbiBpbiBmZWF0dXJlIHNw
ZWNpZmljIHJlZ2lzdGVycy4NCj4gPiAgCQkgKi8NCj4gPiAtCQl0eXBlID0gZmVhdHVyZV9kZXZf
aWRfdHlwZShiaW5mby0+ZmVhdHVyZV9kZXYpOw0KPiA+ICsJCXR5cGUgPSBiaW5mby0+dHlwZTsN
Cj4gPiAgCQlpZiAodHlwZSA9PSBQT1JUX0lEKSB7DQo+ID4gIAkJCXN3aXRjaCAoZmlkKSB7DQo+
ID4gIAkJCWNhc2UgUE9SVF9GRUFUVVJFX0lEX1VJTlQ6DQo+ID4gQEAgLTEyMjIsNyArMTIxMiw3
IEBAIHN0YXRpYyBpbnQgcGFyc2VfZmVhdHVyZV9wb3J0X2FmdShzdHJ1Y3QgYnVpbGRfZmVhdHVy
ZV9kZXZzX2luZm8gKmJpbmZvLA0KPiA+ICAJcmV0dXJuIGNyZWF0ZV9mZWF0dXJlX2luc3RhbmNl
KGJpbmZvLCBvZnN0LCBzaXplLCBGRUFUVVJFX0lEX0FGVSk7DQo+ID4gIH0NCj4gPiAgDQo+ID4g
LSNkZWZpbmUgaXNfZmVhdHVyZV9kZXZfZGV0ZWN0ZWQoYmluZm8pICghIShiaW5mbyktPmZlYXR1
cmVfZGV2KQ0KPiA+ICsjZGVmaW5lIGlzX2ZlYXR1cmVfZGV2X2RldGVjdGVkKGJpbmZvKSAoKGJp
bmZvKS0+dHlwZSAhPSBERkxfSURfTUFYKQ0KPiANCj4gU2VlbXMgdG9vIGVhcmx5IHRvIG1ha2Ug
dGhpcyBjaGFuZ2UuIFRoZSAyIGZpZWxkcyBkb24ndCBhbHdheXMgYWxpZ24gaW4NCj4gdGhpcyBw
aGFzZSAuLg0KPiANCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQgcGFyc2VfZmVhdHVyZV9hZnUoc3Ry
dWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPiAgCQkJICAgICByZXNvdXJj
ZV9zaXplX3Qgb2ZzdCkNCj4gPiBAQCAtMTIzMiw3ICsxMjIyLDcgQEAgc3RhdGljIGludCBwYXJz
ZV9mZWF0dXJlX2FmdShzdHJ1Y3QgYnVpbGRfZmVhdHVyZV9kZXZzX2luZm8gKmJpbmZvLA0KPiA+
ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCXN3aXRjaCAoZmVhdHVy
ZV9kZXZfaWRfdHlwZShiaW5mby0+ZmVhdHVyZV9kZXYpKSB7DQo+ID4gKwlzd2l0Y2ggKGJpbmZv
LT50eXBlKSB7DQo+ID4gIAljYXNlIFBPUlRfSUQ6DQo+ID4gIAkJcmV0dXJuIHBhcnNlX2ZlYXR1
cmVfcG9ydF9hZnUoYmluZm8sIG9mc3QpOw0KPiA+ICAJZGVmYXVsdDoNCj4gPiBAQCAtMTI3OCw2
ICsxMjY4LDcgQEAgc3RhdGljIHZvaWQgYnVpbGRfaW5mb19jb21wbGV0ZShzdHJ1Y3QgYnVpbGRf
ZmVhdHVyZV9kZXZzX2luZm8gKmJpbmZvKQ0KPiA+ICBzdGF0aWMgaW50IHBhcnNlX2ZlYXR1cmVf
Zml1KHN0cnVjdCBidWlsZF9mZWF0dXJlX2RldnNfaW5mbyAqYmluZm8sDQo+ID4gIAkJCSAgICAg
cmVzb3VyY2Vfc2l6ZV90IG9mc3QpDQo+ID4gIHsNCj4gPiArCWVudW0gZGZsX2lkX3R5cGUgdHlw
ZTsNCj4gPiAgCWludCByZXQgPSAwOw0KPiA+ICAJdTMyIG9mZnNldDsNCj4gPiAgCXUxNiBpZDsN
Cj4gPiBAQCAtMTI5OSw4ICsxMjkwLDE0IEBAIHN0YXRpYyBpbnQgcGFyc2VfZmVhdHVyZV9maXUo
c3RydWN0IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPiAgCXYgPSByZWFkcShi
aW5mby0+aW9hZGRyICsgREZIKTsNCj4gPiAgCWlkID0gRklFTERfR0VUKERGSF9JRCwgdik7DQo+
ID4gIA0KPiA+ICsJdHlwZSA9IGRmaF9pZF90b190eXBlKGlkKTsNCj4gPiArCWlmICh0eXBlID49
IERGTF9JRF9NQVgpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJYmluZm8t
PnR5cGUgPSB0eXBlOw0KPiA+ICsNCj4gPiAgCS8qIGNyZWF0ZSBwbGF0Zm9ybSBkZXZpY2UgZm9y
IGRmbCBmZWF0dXJlIGRldiAqLw0KPiA+IC0JcmV0ID0gYnVpbGRfaW5mb19jcmVhdGVfZGV2KGJp
bmZvLCBkZmhfaWRfdG9fdHlwZShpZCkpOw0KPiA+ICsJcmV0ID0gYnVpbGRfaW5mb19jcmVhdGVf
ZGV2KGJpbmZvKTsNCj4gDQo+IC4uIGxpa2UgaGVyZSwgYmluZm8tPnR5cGUgaXMgdmFsaWQgYnV0
IGJpbmZvLT5mZWF0dXJlX2RldiBtYXkgbm90Lg0KPiANCj4gVGhhbmtzLA0KPiBZaWx1bg0KDQpU
aGUgY29udmVyc2lvbiBvZiBpc19mZWF0dXJlX2Rldl9kZXRlY3RlZCgpIHRvIHVzZSB0aGUgRklV
IHR5cGUgaGFzDQpiZWVuIG1vdmVkIHRvIGEgbmV3IHBhdGNoICJmcGdhOiBkZmw6IGNvbnZlcnQg
aXNfZmVhdHVyZV9kZXZfZGV0ZWN0ZWQoKQ0KdG8gdXNlIEZJVSB0eXBlIiBsYXRlciBpbiB0aGUg
c2VyaWVzLg0KDQpUaGFua3MsDQpQZXRlcg0K

