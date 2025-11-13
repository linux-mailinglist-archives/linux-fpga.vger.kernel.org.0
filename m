Return-Path: <linux-fpga+bounces-1459-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A422C56A4C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 10:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16CAC347B70
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E942C327A;
	Thu, 13 Nov 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GDCVZUJ1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BB26B96A;
	Thu, 13 Nov 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026729; cv=fail; b=Xt8b35JD+e3UPByghMrItJeHfEQxndDkut2GxwqgRN0DIza2kXIJB3ZN/t7/j+hUybvHDy3IG///lE6WGrpDpm1MMAXlnV8pZBAS3oJ2qcFHTnbN2nI7npYceUMUJvkdFxq6ztj6Gp1S+CDeN+EWB564zKulYKp6+pIpLmukLgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026729; c=relaxed/simple;
	bh=23ZhfjW7xBNamZhy5W5JRDGNZuKsbOf4/3pTqVqWA6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GeOkjjdgYgtCfCpgSZnHgXSfDP2oblESE5IP6JsoBqnMLUVPLHT1CLrtxWbT9TU9NxIBBA2JfZnU0cp96TpeSQJ0olun8VBvxo5C+dyzdxN/XxuVMjVOLEyvlSTGRimvBbY3pw2pnJiuLWuTW8d0sSfXSgwwrTa/qherZEJzKmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GDCVZUJ1; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf8snhVXIiftJHpXz2AVNCtZlRs8NemzHtFOzI2WFaubOtTD2TxaEggKXXNdj0aSNeO9Vja/bojD8AHW17J0Cw9s1LdKfYo0TvRWT8sVBm393SHzImpbcUaYaI9Fe3lfmZFIylgVuLD4RmjCw53mw6VY7mgP36yHKqCj4Mz2BQ5af0zl4jvT4XxuBdMAPNlImhhQ0BKfPv2nrx7kgcgX/5f0q9rIEM1xP1PiFn1IHCjzIpCyk1eYu+CWQqGndtCk2Q28h9ZV+D3G2fG4dXBqmMTg31zGGugj9MnV+IBo2dQFRuTxlhFRKbOKOADulOJedMGuviP8jXB68GZ6tooTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23ZhfjW7xBNamZhy5W5JRDGNZuKsbOf4/3pTqVqWA6E=;
 b=eYZdelBEMjD5bxfbig46TMW1YxcailKjkbLTsfz/WMr0+geMfdVqVYLSUwu6FqPHMYNbbvnbUslMYado8lP6XEB2Za/DvTFXAZPq/rndLjJLOdu7txR9+nEpgEvvW+xJVvvHEEr+3YovNcew7GxCrkXEFimmRGSdrTtQIe1OBCnEpte9XaY24mYOPfkiija9O6wd1HnRLZrb5VmtYa+avbp5wS/DZYytMkv8pD9MRuF6q+LUPcpMi9+ZmbgN5HYLJ2vJNTY7e/kqM4/UBT7tzjvwmDjCb4Ax3euNh4IAh1fNYjDBeteJNheZ196ZXkbHlP+2X0eLjRs6Ysrv74UHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23ZhfjW7xBNamZhy5W5JRDGNZuKsbOf4/3pTqVqWA6E=;
 b=GDCVZUJ1pLfin6FZlG8VVO6rWoBcQPodS2jan+aoTRCd1Og7T/zeo3Y+v26LEIIYoN6FnbFIx+2eIiAxrfUqVxY9klulvePLqpkHYgbelHU1BFd+qCCAML2UpK+bNaTfqoAIqb1O7Laegkjv8XpP/JxLIVZAsA54+r3kjrBv7csTaAzKctYQKJVVPA4qBhRaga9XRb+CalgPfPnaxz5+VxKaEnMtocex23ZFlqkGt6tdhPc0J5I0PtZt/JEBQyoe+ElD3kdewU31Sta9iETU4pTcOUgHENz0oNkhDImOEFhcqUCbIs2N4o+Q0VdZX5SLucGojUhnFicQgU4qSrfSrA==
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB5888.namprd03.prod.outlook.com (2603:10b6:a03:2d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 09:38:44 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:38:44 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
CC: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix
	<trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "Rao, Mahesh" <mahesh.rao@altera.com>, "Ng, Adrian Ho
 Yin" <adrian.ho.yin.ng@altera.com>, "Rabara, Niravkumar Laxmidas"
	<nirav.rabara@altera.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
Thread-Topic: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
Thread-Index: AQHcVFgjC6R2hGI81EaKjKdwifePr7TwHVIAgAAT/oCAAB/SAIAAANYAgAAH8YA=
Date: Thu, 13 Nov 2025 09:38:44 +0000
Message-ID: <c3ae06f0-e4d0-48ed-a589-fb6fef3fe68d@altera.com>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <aRV0UCZD6fwnfWUE@yilunxu-OptiPlex-7050>
 <a0214340-d0dd-4689-9692-d934f3a80c40@kernel.org>
 <cdd2d579-65a3-4e1f-b8e8-45b30a6d9848@altera.com>
 <00d09e4a-2bcb-4158-803a-d298aad33a95@kernel.org>
In-Reply-To: <00d09e4a-2bcb-4158-803a-d298aad33a95@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB4927:EE_|SJ0PR03MB5888:EE_
x-ms-office365-filtering-correlation-id: 94ca1e16-7518-4bc6-e1d1-08de22986ffa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2NDeFUxZEN3MGN6cE9OUnpzaHU0MXZubUU1TURrOHZJWVFtUERBU01kUmVm?=
 =?utf-8?B?enVmSGtCNXdpUEJQbyt6bTVSeWtyMXlOOEE3aVV0ei9FMUEzc1U2S0RON0g5?=
 =?utf-8?B?N1g2eHlYOElodnE0R0hBTVFnMmJqVmhqdjlFY2hyQmNHOGJFTktpUnRsMHk2?=
 =?utf-8?B?VysveE9tZkFhcnExSkl6SmxJaXQwcFZNU01VSUxXRFFjTFozRWgwL0NOd3ZY?=
 =?utf-8?B?bm9ycnNSV3dHOGFZS0Q4NzhXNndDaDduOTk0ZHY0QVM4WEZIOVRUV1orTlg2?=
 =?utf-8?B?ZG9iZnBPaDBDU3c4cFNwam12RU5PcnZyUjgwa29kU1NSRzkxZGJqTjl3d3gx?=
 =?utf-8?B?empUYjdrVnVBMk9BZCtYVUtoNXJzNC9nc0xWYXdXbThNWVlSMXRUQmJCZDZD?=
 =?utf-8?B?L0VRUU9OTExxenZWR3c5cjlJSEJIdFJNSXpqRE5aQXdrVUZpbVNkc1VnbkRL?=
 =?utf-8?B?bFFveXlaaU1PU0ZxRHY5UGxwcDc1OU9OY3FxYnExUWF5dUtJaTRJdGFvZ3o0?=
 =?utf-8?B?ZkExSDJQOEgwbG1ocGhLWXd4YkN1Sk1ZcWpSU1ZORFJ4OVM1NjBBQ2tLdzcx?=
 =?utf-8?B?YmhhY3V2TjVCb3ZRVUg4UVd4YS83QVcvZzJBYlpYV0U1SWZOZnJ1R0ZNMThk?=
 =?utf-8?B?VndUbXdOYitqNlhvVUhHMlljZElqMzZKcVBmS1V3cVJVcmVhNmtBWXVoY09O?=
 =?utf-8?B?SUQvUTVWc09oNGw4TXpvdGwrdTlFbzJZaDFnV1E3R0JoUW1WdkpYTEcvRzlj?=
 =?utf-8?B?TGpnalNQUDBjcE1PNjgwWnBkNXZValE0Ukd4YkQxcmhYYVhpRVZPMjRxZ3do?=
 =?utf-8?B?TGVQSmJLbXl5MkpBejdXNnU4eStQbyt5ZkpFSFNMT0JCSzEwejJoSUVob1dS?=
 =?utf-8?B?cy9WRm5Id0xQTWFrWllueW93bFpGQU9WMnlENGxxRytsaXBnVHhpcFh4RkJv?=
 =?utf-8?B?elEza0cvOFlmWXZCaGVSekFoSktobzVZdDcrTnRiWTQyN0VkUzN5RVlQNXQ0?=
 =?utf-8?B?VUpLSWdoNjc5bXNxcXVlRXAvYVErUjZTcWJyVnZoMHVIT2FyTVIreENydzgy?=
 =?utf-8?B?empQS1hiRTkxRkF2U2dYUlcza2lzMW90QWROTE40VmFrZEtBL1JBMlhzd0xx?=
 =?utf-8?B?Tnl5bFhiTFZDZWZ2N1dlUVhRVG5IbEtwamx0RDY4aTR4dzF0SWVENFFwSU1q?=
 =?utf-8?B?QjlPdnZkVnhzaERMRzN0Y2hQUHZnWlpCMTlVa3o4N3JXS2FqSlNSMmRBOEww?=
 =?utf-8?B?MGVNbXYrSm9rZjFpR1BZL2NhSW53RE5yUTg2Q2NodWxOYStJQkhGdFY0Wm5G?=
 =?utf-8?B?c0doZnpqaFJQSHZ6dHV3UHpKZ2xNUCtYL1o1Qms1aXBiSTV5NFgva2dtTjFz?=
 =?utf-8?B?Z3VrMUU3QW5kTWNqRkNVOFQyMzBzemZlMHkvOURGd1kyeUpDRjBiU2NkbjNE?=
 =?utf-8?B?amk3bGh0ODMrOEQ5bjJGQ3dMMWVXYUZIK1RLT0hxcjJIVHphQ2RtcDFsWEkx?=
 =?utf-8?B?c3loMC9YMnZ3WUo1Zjl0dnFwSm1PMy9YOEhTUFJCaFBCaEN2dndzRHY0bnJT?=
 =?utf-8?B?ZXlMWWoyM3lRbjJuWDFrdnlDOFpaeUJqekk4OVhBL0piQ3dhUnk0cHdXMTZ1?=
 =?utf-8?B?cXYxcWh0ckV0TmZnamhFS1VSRm9Zd2dxOEpMUTgxY25CUUp4Tkd4cFkvN010?=
 =?utf-8?B?ZEFFSUMwbkxIUGQ3anJsdWRjNHFpbWtMRk5YRGp0N2tJbnB5L3Q0MldBRXBw?=
 =?utf-8?B?RWMvUVBibnVrcGVsOWtEVG0xSldjT2p6dXNUdm1aLytYS0liTDRRVHZwNDJZ?=
 =?utf-8?B?Zk9ldnpZOWx4RnVFaTNLMEdLMXk1aE5VaGdkb1VIK0huRHlHMEZpSFdnaUR2?=
 =?utf-8?B?OFdyaUZ2WFIvV0JyM2lPOC9JUGJsUEZzbzRTS2crVHNaMFFhUStTWk1RNmNk?=
 =?utf-8?B?dDRENDdUQngzYmFNc1JJSDhQWlR3dXhhcVVuTHRRUGlwNzhidGdJOTloRGNh?=
 =?utf-8?B?QS9nZ1hDRUNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFkrM1hWY2xkeW5ycDhjVXpoZjBZRHRJdGQrdGZ2ZHpzZTBWREhWc3REZmh4?=
 =?utf-8?B?N0xrZmY5elZkRXoza2U3MHZ3UUJGdjQ4RFVmVklaa0hzVWZtNHM3TUp0OEJ4?=
 =?utf-8?B?WW9UWG5xbVdISmE1ZWU1RFpWK1VyaGFOU1BNV3V2TjUvT0RmbmJQODhRVTJi?=
 =?utf-8?B?STdJNVlNbnNQQVE4MGdKZEErNVM1b1UrV21iOEEvQzVhTTBsUUVPTDBsSk16?=
 =?utf-8?B?MVVZZ2lIb04rbmMrVHVTMW5ObEpzOERNSUx1WGg1SUFXVm10OG80UkowVHpJ?=
 =?utf-8?B?TFA4a2p6N0FySndoMEJVdVZsVVNRbUR2dlA2NmM4TnNhS29JNWkva00wdEZK?=
 =?utf-8?B?b00zS2orajRnbWYyOXZtRVdIQjBRUWM5dzBtcXNKM2ZLRUo5STFUdGppUGhL?=
 =?utf-8?B?WDdWdGd5ZWtXeTBUNENNbmRRNmE1enRaY0F5T0Y0R1pZbUN2Rm94dDFBVzVr?=
 =?utf-8?B?TXB6cEEvMnlyL21yWVQ5ZTJ4aGFnQWF3R1dYbm5zTHY3YWpGRHFXZ1lXdG1o?=
 =?utf-8?B?cFpCQUZFUkhMZktvNU9IU2p1L1FoN3dnWFd5cTBXMVF5WGkrYTh0QXdaTEw2?=
 =?utf-8?B?RXgxT3lpaUNJL2lQMGpMMGpHT3dNdVhzUFVGaC9sY2h1RVFpTExsMkQ2U2Vt?=
 =?utf-8?B?bkxPbnBxMjlSb3BBdVhKcFhkZ1I4aUxiRUNsRVlqS2c2eGhjUHJncDkzUkRU?=
 =?utf-8?B?amlYMG5GN2dEajJMMFlXaVJLMHZLczUvbHFlanpjdHl4NzRaaXpRdk9pd3RW?=
 =?utf-8?B?L21ZTVNNUGg5Nmt6TmhoMFlNUkh3TGtna1gvbXdYajZLak02YWJhS1FTQmZk?=
 =?utf-8?B?TXVWT29SYU5ScFAyak5UbURiYnY2UXFEY3JNVXVrdHhPSDhaNXV3cnRncWl5?=
 =?utf-8?B?TGhTdENKQTcycmpkdExCclE0NDFWL3J1L09FRm8xTXcveHN2cSs3VldJb2p2?=
 =?utf-8?B?cEluQVRXWFYvOG0wR09QZmZ2eXVVeGRzUm1yTGdqVW1la1JFQm9tRkVoeElE?=
 =?utf-8?B?bXVndTEyeTVGREI0dUdPV2N0eUhoM2lnZEdYdFg2Ui83Z2o0SFF3ZjBpOVRk?=
 =?utf-8?B?QlZvaitzaGVwQk16VTZlNkdOWFhwWEJ4TXI1Q3dsSVNCRkwyZUhLdmtYT0k5?=
 =?utf-8?B?MkNWWkZ5R3V1WnNWODhPT05ZemhsMDNPRDRQVjJESEFRYkVlNWtjWDRkR3Nq?=
 =?utf-8?B?VHZmMDNjNnBaMU9KVTVaZHlEZ2RHT3VoZjlQVzY2MjJtaVBRNHNXbTZHMFJz?=
 =?utf-8?B?VTZJQU4zek1rbVZxdStsME9jZDQxWXEzaDJOZFZkUHd1NlJWc0l3TkxBalk0?=
 =?utf-8?B?K0I2cjFrRzNadmNUZTZab1RTdVlTMTlHeC9QdjMxS3JwSWtKakw1SnN3Q2t3?=
 =?utf-8?B?VDRFbkYzVmRNeG5rYVJFMnRFbEY1MldKZVNuK2Zoc3ByY1l6SGdDL25pZ0Rn?=
 =?utf-8?B?VXVXUFg5SjdvMEZMbytwU0lTemk3QUFtODFjd1MvdjVaQUFhOVpxV2JTSWNj?=
 =?utf-8?B?bndpZk5hbnFsc0RSd2EzOWdEMTJ4Qm5WZlJXMXlWdi9tSTJvK1VZcHlEQW5Z?=
 =?utf-8?B?Vnp1N0hBbTdmSmV3REltdUtTbkUwTnVnaGxMQWN3a08reTRzeGJrdGF5ejZa?=
 =?utf-8?B?MGhXNS80dS9HSHlnQUVUalFmYi9IeDFMUEdJMWR5Q1BwbGg4bzg1TTJTVkY3?=
 =?utf-8?B?a3d5U1Ziei9nRlUzWmZpN050cjhaV2x6Z3pWb3M5MHA0QzN2Kzd4VU9Ic1hx?=
 =?utf-8?B?MjE1QjlESVZIZUgrQzFyZVgxRlFTVWVEd3p1OTZvWGlLZ3laVHZpUCtNZ2ht?=
 =?utf-8?B?T29KcjJZQjQrWHMzeGtwYjBETTZNWFVQa3UvWUtLQ0J3ZENHWUZwZFEvTTQz?=
 =?utf-8?B?b2tpdWZJei9waWtiTUZDY2diYmk1Q2JpcVFVMWY3WlBSZDJva2ZvT2JXRWR4?=
 =?utf-8?B?c0orSHh6VUZuV2VnQVF0WGhza1pQemVUWlA2amlqNXdFMkU5UENMYXFTdkVQ?=
 =?utf-8?B?QUdGZTQrMGdubmRhZWRhdm0zN0R0YjBOMVpXMnpKL3hBSWFaSkJLQk1TdjZI?=
 =?utf-8?B?RU96Y1U0OW51SCt3cUIwckxpb1VLWVd4QVhQc3lURjJsbW0xSkxxcFFHMjRU?=
 =?utf-8?B?bEZmWXpheXBXWVRhdkdpYXhHRko5a1lQMWd3cFkzdzViTUZ2ZnFCc0I0aDll?=
 =?utf-8?Q?dmoEF+pY84ruFcCQyl+Duvc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F712C1D0E668F45B243FB64C6FC152D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ca1e16-7518-4bc6-e1d1-08de22986ffa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:38:44.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGS+oVibmDd5JvpPR2CUdZobMKMR0fRajZUwJ2y5RJ9snN13wQD6BD99mzkXtIdPH2SO51PQn7o7mc8OxLrTP+YqSbTLoTcJFOqSd1Tf5E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5888

T24gMTMvMTEvMjAyNSA1OjEwIHBtLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAx
My8xMS8yMDI1IDEwOjA3LCBSb21saSwgS2hhaXJ1bCBBbnVhciB3cm90ZToNCj4+IE9uIDEzLzEx
LzIwMjUgMzoxMyBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBPbiAxMy8xMS8y
MDI1IDA3OjAxLCBYdSBZaWx1biB3cm90ZToNCj4+Pj4gT24gVGh1LCBOb3YgMTMsIDIwMjUgYXQg
MTI6NDM6NTRQTSArMDgwMCwgS2hhaXJ1bCBBbnVhciBSb21saSB3cm90ZToNCj4+Pj4+IFRoaXMg
cGF0Y2ggc2VyaWVzIGFkZHMgZGV2aWNlIHRyZWUgYmluZGluZ3MsIGRyaXZlciBzdXBwb3J0LCBh
bmQgRFRTDQo+Pj4+PiB1cGRhdGVzIHRvIGVuYWJsZSBGUEdBIE1hbmFnZXIgZnVuY3Rpb25hbGl0
eSBmb3IgSW50ZWwgQWdpbGV4NSBTb0MuDQo+Pj4+Pg0KPj4+Pj4gVGhlc2UgY2hhbmdlcyBhcmUg
aW50ZW5kZWQgdG8gZW5hYmxlIEZQR0EgcHJvZ3JhbW1pbmcgYW5kIG1hbmFnZW1lbnQNCj4+Pj4+
IGNhcGFiaWxpdGllcyBvbiBBZ2lsZXg1LWJhc2VkIHBsYXRmb3Jtcy4NCj4+Pj4+DQo+Pj4+PiAt
LS0NCj4+Pj4+IE5vdGVzOg0KPj4+Pj4gUGF0Y2ggIzMgZGVwZW5kcyBvbiAgImFybTY0OiBkdHM6
IGludGVsOiBBZGQgQWdpbGV4NSBTVkMgbm9kZSB3aXRoIG1lbW9yeQ0KPj4+Pg0KPj4+PiBUaGVy
ZSBpcyBubyBwYXRjaCAjMyBub3cuIFNob3VsZCBiZSBQYXRjaCAjMiA/DQo+Pj4+DQo+Pj4+PiBy
ZWdpb24iIGZyb20NCj4+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8zMzgxZWY1NmMx
ZmYzNGEwYjU0Y2Y3NjAxMDg4OWI1NTIzZWFkODI1LjE3NjIzODc2NjUuZ2l0LmtoYWlydWwuYW51
YXIucm9tbGlAYWx0ZXJhLmNvbS8NCj4+Pj4+DQo+Pj4+PiBUaGlzIHBhdGNoIHNlcmllcyBpcyBh
cHBsaWVkIG9uIHNvY2ZwZ2EgbWFpbnRhaW5lcidzIHRyZWUNCj4+Pj4+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Rpbmd1eWVuL2xpbnV4LmdpdC9sb2cv
P2g9c29jZnBnYV9kdHNfZm9yX3Y2LjE5DQo+Pj4+DQo+Pj4+IEdpdmVuIHRoYXQsIEBEaW5oIE5n
dXllbiBjb3VsZCB5b3UgdGFrZSB0aGUgc2VyaWVzIGlmIHlvdSBhcmUgZ29vZD8NCj4+Pg0KPj4+
IFRoaXMgd2FzIG5ldmVyIHRlc3RlZCwgc28gc2VyaWVzIGNhbm5vdCBiZSB0YWtlbi4NCj4+Pg0K
Pj4+IE5BSywgQWx0ZXJhIHNob3VsZCB0ZXN0IHRoZSBjb2RlIEJFRk9SRSBzZW5kaW5nIGl0IHRv
IHVwc3RyZWFtLCBub3QNCj4+PiBhZnRlciB3ZSBzYXkgaXQgd2FzIG5vdCB0ZXN0ZWQuDQo+Pj4N
Cj4+PiBCZXN0IHJlZ2FyZHMsDQo+Pj4gS3J6eXN6dG9mDQo+Pg0KPj4gSWYgeW91IGFyZSByZWZl
cnJpbmcgdG8gdGhlIGNvZGUgYmVpbmcgdGVzdGVkIG9uIHRoZSBBZ2lsZXg1LCBpdCB3YXMNCj4+
IHRlc3RlZC4gSSBldmVuIHRha2UgdGhlIG1lYXN1cmUgdG8gYWRkIHRoZSBkZWJ1ZyBwcmludCB0
aGUgaW4gaW5pdCB0bw0KPj4gc2VlIGlmIHRoZSBmYWxsYmFjayBpcyB3b3JraW5nLCB3aGljaCBp
dCBkaWQuDQo+Pg0KPj4gT2YgY291cnNlIEkgdG9vayBjbG9jayBtYW5hZ2VyIHBhdGNoIGZyb20g
RGluaCdzIGNsb2NrIG1hbmFnZXIgZHJpdmVyDQo+PiBmb3IgQWdpbGV4NSBoYXZlIGxvY2FsIGRl
ZmNvbmZpZyBpbnN0ZWFkIG9mIHVzaW5nIGRlZmF1bHQgZGVmY29uZmlnIGZvcg0KPj4gdGVzdGlu
ZyB0aGUgY29kZS4NCj4+DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvOTMyNmVlNjZj
YjhlMzNjMGZlODNhMjRlOWExZWZmYzhkYTI1MmZmMi4xNzYwMzk2NjA3LmdpdC5raGFpcnVsLmFu
dWFyLnJvbWxpQGFsdGVyYS5jb20vDQo+Pg0KPj4gQXJlIHlvdSByZWZlcnJpbmcgdG8gZGlmZmVy
ZW50IGtpbmQgb2YgdGVzdD8NCj4NCj4gWWVzLCB0ZXN0IGJ5IHRvb2xzLCBiZWNhdXNlIHlvdSBj
ZXJ0YWlubHkgZG8gbm90IHdhbnQgdG8gZW5nYWdlDQo+IHJldmlld2VycyBpZiBjb21wdXRlcnMg
ZG8gdGhlIGpvYiBmaW5lLg0KPg0KPiBzZWUgYW55IERUIHRhbGsgKHRoZXJlIHdoZXJlIGxpa2Ug
Zm91ciBsYXN0IHllYXJzISkgb3INCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3dyaXRpbmctc2NoZW1hLnJzdCBvcg0KPiBodHRwczovL3d3dy5saW5hcm8ub3JnL2Jsb2cvdGlw
cy1hbmQtdHJpY2tzLWZvci12YWxpZGF0aW5nLWRldmljZXRyZWUtc291cmNlcy13aXRoLXRoZS1k
ZXZpY2V0cmVlLXNjaGVtYS8NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KVGhh
bmtzLCBJIGNhbiBzZWUgdGhlIGVycm9yIHdpdGggbWFrZSAtajQ4IENIRUNLX0RUQlM9eQ0KRFRf
U0NIRU1BX0ZJTEVTPWludGVsLHN0cmF0aXgxMC1zb2MtZnBnYS1tZ3IueWFtbA0KaW50ZWwvc29j
ZnBnYV9hZ2lsZXg1X3NvY2RrLmR0YjsNCg0KSWYgaSByZXZlcnQgYmFjayB3aXRob3V0IGFkZGlu
ZyAiaW50ZWwsYWdpbGV4LXNvYy1mcGdhLW1nciIiLCB0aGUgdG9vbA0KaXMgYWJsZSB0byBwYXNz
IHdpdGhvdXQgYW55IGlzc3VlLiBCdXQgd2UgbmVlZCB0aGUgZHJpdmVyIGVudHJ5IHRvIG1ha2UN
Cml0IGFibGUgdG8gbG9hZCBhcyBpdCBjb21wYXJlIHRoZSBlbnRyeSBmcm9tIGR0cyBhbmQgdGhl
IGNvbXBhdGlibGUNCmVudHJ5IGluIHRoZSBkcml2ZXIuDQoNClNob3VsZCB3ZSBhZGQgYmFjayB0
aGUgZW50cnkgaW4gdGhlIGRyaXZlciBsaWtlIGluIHRoZSB2MT8gT3IsIHNoYWxsIHdlDQpkZWZl
ciB0aGUgZHJpdmVyIGNoYW5nZXMgZm9yIG5vdz8NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMs
DQpLaGFpcnVsDQo=

