Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C248538F57
	for <lists+linux-fpga@lfdr.de>; Tue, 31 May 2022 12:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiEaKxS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 May 2022 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiEaKxQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 May 2022 06:53:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E142EF4;
        Tue, 31 May 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653994394; x=1685530394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aL5n+PJDsvFjtt6CimdLAGH5JosHAESVituoZpa/mHk=;
  b=kXpnUnLTA5UvgPlcSbTsjncjwMyB+S0fep2FgD5Tv45ngL+5iU61UYeX
   03vXRkJCCkAeHzDaYoLUyUNwwgm+krsIahKj510cfY49P5iOWoCqK6Seb
   nHC2fWSE+4h/b/SjXd5Bi84+2IFFJ3+3sg4pfdSUkXXLfHmktbr4atCX6
   q7OQEEDuc93xUP4TZwtOVlsCtDKOCccpCEbSwa/5uD9rMTatApTpT/49E
   fBqqu042/Da+RjKsEnjdEI0WpegZ/4wkPtPdi+kuqy25rB8puCIj1mRaa
   N5J4fOLN1EcbBBRwwesfg8OSRihuN1SBQzo+be7JI0oagB4it6BVkumWv
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="175826228"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2022 03:53:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 31 May 2022 03:53:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 31 May 2022 03:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTT5LE/OP4tA1CNuFGdpCRw6F09/JGs/+8OucdaZr2uJyVFYCgldQcAOJBYali23fQdo0ctLRKDxLPHpQZGfdhJCwCsD0MRFb8Puc0dEtlwFe3STR+E4XEvrfbSk2JGrIx3FqZOATw8L7K2yWVkqsGflNgh8XZqkBPS9R+to5RXxTtcyiWv74cg7ctUSzfuldLT/RidIZRwVqDeltTrQ/MvkZhpQFHTq5+W7pLu1OcGqA9z6/FGXL1BvCYCQTT3QUGT0ozdW+eowBjB3p3NlyoArOlmKEtkBYjwQUp8T5J3TY+skHkM2HwZYl5enLo8GKFvF4zy/jiSEwMWbyNCZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL5n+PJDsvFjtt6CimdLAGH5JosHAESVituoZpa/mHk=;
 b=niCb9FB1h8fit0uvK1ZtrwvIXA36MY5/GDMkHxKXWtPxXqvqfB1HWvUfaNHdTE5Z+XDutIf3Iv41ztiS4aqkKCDN4kjvvN1fxApH8t1jZY8fZ0KDoXCazZ3Nm/UKFQXPg+uMS66ge5KSMsQOIKAMIeZpcVK4Xn5ul9p4AV8D5KfHRchNdNkPwmGPPg9GYH/GlowPta46MW8SXlYR/7nHrnl3+yUWcO8010BoxuOLOEUwhWM/i13eWRdiTCrJnl4Lq0xdolJSEK/d2KRqRfM65B+mJPrFo2AoXWwn1+VI3zZfzipe9uH3jlp9jP7yyHJ+cLCkhBoY3tt1iqLInFg2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL5n+PJDsvFjtt6CimdLAGH5JosHAESVituoZpa/mHk=;
 b=kAUpVL2za3P67ZtYp8ZZrE5cGmzTCar8PBr2Q3ob67SEWASlWuR184gOQDoYv48bHQKwEgDFFy0Vcjqxg8hCYG8kGPhkEnVmswkJY1pAj2AgeicyEVhIEgXNiCXTPmD9trK8IkQN4hpb866Nv1MVjdrE3AzVCNn0D2AEmsyfqp8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2604.namprd11.prod.outlook.com (2603:10b6:5:c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 10:53:07 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 10:53:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYcS+MqDCo1uYFDUerOTfzxMPcoq03TEoAgAAM4ICAACZ+gIABVsQA
Date:   Tue, 31 May 2022 10:53:07 +0000
Message-ID: <3b6867a8-d4ce-c5f3-71d4-bd9c3c88c389@microchip.com>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <f655cf2f-555c-6480-a461-bcddb9e510f3@microchip.com>
 <20220530120701.sedwn3qeohlnj52e@x260>
 <95c44458-aeff-e356-1e32-c8f735570c3a@microchip.com>
In-Reply-To: <95c44458-aeff-e356-1e32-c8f735570c3a@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 003823d2-5582-483d-f9ea-08da42f3beea
x-ms-traffictypediagnostic: DM6PR11MB2604:EE_
x-microsoft-antispam-prvs: <DM6PR11MB26040EA3F79651DF8D07226198DC9@DM6PR11MB2604.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dQ1XijpP+V6sd/m2FoC9xzkwVnzPFWbgrWLQU4aYd48cKokjZX88KbsWygwMthyNuVMQ/QCDxVLHOEw21KS6RdI9cxm7XNmyXsn39VL6rLJPEh609v1qJWNNB/XdMsZRi71HwRM6ZVSrCNt+cAEHIAqDNNi49P6A5lASIiCMuJZtBdY8KS6S2ZINDmdzrHVso3r1fPwXtuLIgWG5ibBJhW95c7HQmJOv7AGHZPoZ2s5UPGoM7LYiFguWZhdruOxp2LkbaKlt24Z7QJWGykfC66eHOiAP4S+J+kGj7UJrIpv4uVWahNehDoWgtQQmR0HGf3Xa6d5QSZhbuKU89lyGWhflPTRH8SiFE3MibHn6NDFCkhkgHy5WsU5lhaz8xMMuBSv9u1EmTpFIKJ/xtkeoZ8Jw8F2hYqzrvRbK6fJvdUctmzmr88rBoTb3Qy+ECLuYwcu51aQ4qR7icRriw9ISTG3edliQYyIzsKNnafsOY8RMI4DCiRs+1cH2F7bRV3dHwP4jCUUU7vl7oSTBlKnmzYrIPoU7yZoLmScvkoWEDVxaK8OlH+iqLUjjcWChoCURa2hdtftS9nk6swi8pWKx6mgJ4U0lsHhtcKHyMXH4yz/Kkt8XjwTFnuDVBo9cVvmhdHBgobjWt4B8/WiqtMStYLED1/AKeU4neeEeaAHZtJgHf3685rwZ5k6btPpQXwuk3imkfpGSqo+qtOEZvmyBEswayfFIdCqgUbR3Q/lIR5y2VjJ+N2RisRQuBMOB8wskDQGmT8qjjfEwNxiWZmpPxZG6taSkjNvTQnB3LSXh0wpbT64SIEhC0Uww+9APGn82moPznl18cmW4rb6zajiZ1Vx8B3k72/LIGIdlVtIT1MtnwP1B1dLcb6lmoZqYlwN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(53546011)(6512007)(2906002)(31686004)(316002)(26005)(6506007)(6916009)(122000001)(36756003)(8936002)(38070700005)(31696002)(83380400001)(4326008)(7416002)(2616005)(86362001)(66946007)(38100700002)(5660300002)(76116006)(66476007)(66446008)(8676002)(91956017)(64756008)(66556008)(508600001)(966005)(6486002)(71200400001)(186003)(43740500002)(45980500001)(15519875007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVJzYXUxdzN5MlY3UFJjWDltS0NwN2xVbUVvY09xdlJoQ08rQ04rdExIa1hC?=
 =?utf-8?B?S3c0Zi9ZT2VxWTJqUzhuOFBja2s1a2NCN25MazQzRm9xak5TSmtSVE9SNng0?=
 =?utf-8?B?TFpCT3pxRWphbmFxL2hLNXdjOEdIcVNqYjVsZXNUdGhSNHNBaDlObGRreTNW?=
 =?utf-8?B?R041aTZ6bHNsdGxnNFllY3pwMWdTM2lBV2FOdGFibmxlTkN3cGphb2l4OVh6?=
 =?utf-8?B?ZllndVJYb2ZuajkvZy8waEpvV3pML0ZLWm5iR2J5ekpSa1RFcnFrMTRiQ0ty?=
 =?utf-8?B?UEhGS29LYmRXSitMTEZrWCt5RmJ3Y1dFYytwTTcxZU5ENXZuOU5XMHRyQmds?=
 =?utf-8?B?Ky9aOUhWaTZwWVdma1JFZHRVekNYUE9MZy94b2NjOTV5bkpNVDNUbHArRmw2?=
 =?utf-8?B?YjI0MHBEbDlXMmszeGVVeURBTTlLMGVnTk9yT2lOeXNTTVVKSC9reXFiWlF3?=
 =?utf-8?B?WTRjMit2MTNtQXpPR3l6VjV4QVFMbkxNaWZ6NWtLcEtObVl2VHQwTkE2NWt0?=
 =?utf-8?B?Z1NKaGhlM2ZOcy9QZUE3bnBRbmhjUUNhZi9oR01jTFFzMXd6ZCtWV2tFeEp5?=
 =?utf-8?B?bjl1QjNxT2p5Ym1JRkt2V1hjRGdSKzVIalEzOTVaYURQT3FPRS9rTXV0Y1FR?=
 =?utf-8?B?bWg1NUVGVUI4NWdWVE5INWdTMzN3U1dhQ05MbG9nQzRRVFRCYkVheFJ3MG50?=
 =?utf-8?B?NWs3YVNFTm9oT08vd0hQUHgxUUR4YXdjaTRCbUptbmRadElzSFFwMHc1S2Q1?=
 =?utf-8?B?cWVkU2pUM3U1MW1hSkxJN0NKYnFLNTFDYmU1anE5VHljM09UcUUzN2ZMTWZ1?=
 =?utf-8?B?dEdoRXhCaitxQ0lGM2xqWnVvTG81a2l0ZEZXUHNaUFMxRTRyMVBWd1hwOEV3?=
 =?utf-8?B?Y2FBeEFrczVtNU5uSkc2RHFUNlMyMVE2RDdzVk51VDN4YUpIaFY5VVhpWm1V?=
 =?utf-8?B?cUtlMmR1YmMvZlpKSnJ4S3A3MmN5RVBONE1rdERNb0xMTGZ2WGVkdDFQVmZF?=
 =?utf-8?B?MDFZcXNyTHdRcUhUV0grV3haalNEWjZTL1V0bmJEaitIUXk2QlBKcUdsNHhJ?=
 =?utf-8?B?SFJjcUxrY3YrYnI3QUhvZjl2dEc2MUxmdjVjdHpyWUZaMVB5aGczY1VEUjJI?=
 =?utf-8?B?bm0xOWVDVHVCQzZ5Zk8yYlc1UU41SVppUGFGVVNxSEpEbDl1dXBKamh5VVV1?=
 =?utf-8?B?ejNhYklubEs2ZkgvdURsVlM3Vm9yWllJV1hmQ0h3TjErSFgxTWR2L0xpSzhV?=
 =?utf-8?B?S284cXhOZUk2S3pxbG9QaUVzY0xKdkNJWDJsYjVoQ0FyYWxNLytOWWZlRXdk?=
 =?utf-8?B?MzdZc1g5L2RIdmtZQUtrSUtZNStiWDBseGk0WlFKTTFuS3hBaWxuUDlRdDFz?=
 =?utf-8?B?SE1UZzE5K0sxZ05EeFpVYjNBc2VXcEF5b1JRdmJMRnQ2UnowVVJCVjk1WkU5?=
 =?utf-8?B?QkxzUW51T0poYmVvNW45TDVuVnZZVEhXeU5lNTE1RTV1YzhCQTNBREM1bXhZ?=
 =?utf-8?B?RnNvcWZDR29IbExpS2lsaTFYVE1mOEo1ZlZEREtQUnFyeUNhRUdhcjU1endl?=
 =?utf-8?B?Y1hwOFpEM1FJa1NQK2d2bnF5bHhvNStQT2E0b1Y1THFmSEt5MWozUHNWM2Rz?=
 =?utf-8?B?Uk1BS3ZWeFBBa0VPYUl0ZzdxUXdZajFwVFlvZk9OckJEUTI2TWNlakZ5Tmx1?=
 =?utf-8?B?YnBmZlBFSzZtMUNiNHJkL0JyRW1DZU9LbmJNSXdXdjFKOWk5aHJkRkNqZ2RQ?=
 =?utf-8?B?d3Mxc3RFWFowT3VpOUF2NDVuTFN5YldFVUVzc1lNeTZ6M0dDWmZJbTVZR0lN?=
 =?utf-8?B?QVN2c1BUdHkzNkdDSjJNUkJZYzNhR2xaR3c3Q0VkZGRGR1k2bjliQUJGOXZ0?=
 =?utf-8?B?RjFKZDVlMmxHL0MvbzVBNmZ5WG1oRFdFTmkrMnF3ckM2WG1jMlVHQmV3clRp?=
 =?utf-8?B?QXVnKzBndExEMXA1Y3ZGdHFoL1NkN1FPMktzVFpPdURZanpmTVViR2FpWHRv?=
 =?utf-8?B?dGJaYWUwbnNvWUNGMnVVVmhxM0lYMURpVFNTT2FZSkVFeEJXREJYbzR5aGN1?=
 =?utf-8?B?U3F4Y1JSUGIxTW1naE5vRWx2dngyU1B0ZkRiOXp1cE9mNThrRzJrYWRzZ21n?=
 =?utf-8?B?YmRsOUdFNVpaWDFFZjNwRUREQ2VTdm1zL2tjb21iTnNGaWsxcWxCcG5nRlBn?=
 =?utf-8?B?Vnh2dDlJZ1FaNGovWW5Zc0FQNElsSjNBd3BPSThNaXhxM0tVN05sVWNuVGhS?=
 =?utf-8?B?M2E5Y2xSTjlCck1IeGM5KzFoUlR3ZkVIUmVrWFpQTTVMOEhXdG1lQXhzbDB0?=
 =?utf-8?B?a1RnczhDOXdXN084Q1NLWE5uV3dJZlJpd2RsOUk1bFgwb1gxTktvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F91017557816B74F95F3ECCEBADB3B3D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003823d2-5582-483d-f9ea-08da42f3beea
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 10:53:07.3590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFq7iwmjIvfFHrwTpg5CT7QF9SLV+MAfGJrbD1zibP6zyNO/HQhUnv7h+0BxZmDllNYWKKkoxC7uJyD1DCGqd10LC/XPnijnLDMBuX4Wbg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2604
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T25lIGxhc3QgaXRlbSwgc29ycnkhDQoNCk9uIDMwLzA1LzIwMjIgMTU6MjQsIENvbm9yIERvb2xl
eSB3cm90ZToNCj4gT24gMzAvMDUvMjAyMiAxMzowNywgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+DQo+PiBPbiBNb24sIE1heSAz
MCwgMjAyMiBhdCAxMToyMjoyNkFNICswMDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+PiBPbiAyNi8wNS8yMDIyIDE5OjEzLCBJdmFuIEJvcm55YWtvdiB3cm90ZToNCj4+
Pj4gK3N0YXRpYyBpbnQgbXBmX3JlYWRfc3RhdHVzKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+
Pj4+ICt7DQo+Pj4+ICvCoMKgwqDCoMKgwqAgdTggc3RhdHVzID0gMCwgc3RhdHVzX2NvbW1hbmQg
PSBNUEZfU1BJX1JFQURfU1RBVFVTOw0KPj4+PiArwqDCoMKgwqDCoMKgIC8qDQo+Pj4+ICvCoMKg
wqDCoMKgwqDCoCAqIFR3byBpZGVudGljYWwgU1BJIHRyYW5zZmVycyBhcmUgdXNlZCBmb3Igc3Rh
dHVzIHJlYWRpbmcuDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSByZWFzb24gaXMgdGhhdCB0
aGUgZmlyc3Qgb25lIGNhbiBiZSBpbmFkZXF1YXRlLg0KPj4+PiArwqDCoMKgwqDCoMKgwqAgKiBX
ZSBpZ25vcmUgaXQgY29tcGxldGVseSBhbmQgdXNlIHRoZSBzZWNvbmQgb25lLg0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgKi8NCj4+Pj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHhm
ZXJzW10gPSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFswIC4uLiAxXSA9
IHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC50
eF9idWYgPSAmc3RhdHVzX2NvbW1hbmQsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAucnhfYnVmID0gJnN0YXR1cywNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5sZW4gPSAxLA0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLmNzX2NoYW5nZSA9IDEsDQoN
ClNob3VsZCBjc19jaGFuZ2UgYmUgc2V0IGZvciBib3RoIG1lc3NhZ2VzIG9yIGp1c3QgdGhlIGZp
cnN0Pw0KIEZyb20gcmVhZGluZyB0aGUgZG9jdW1lbnRhdGlvbiwgaXQgbG9va3MgbGlrZSB3ZSBv
bmx5IHdhbnQgaXQNCmZvciB0aGUgZmlyc3Qgb25lLg0KDQpodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2luY2x1ZGUvbGludXgvc3BpL3NwaS5oI0w4OTUNCg0K
VGhhbmtzLA0KQ29ub3IuDQoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0K
Pj4+PiArwqDCoMKgwqDCoMKgIH07DQo+Pj4NCj4+PiBIbW0sIEkgZG9uJ3QgdGhpbmsgdGhhdCB0
aGlzIGlzIGNvcnJlY3QsIG9yIGF0IGxlYXN0IGl0IGlzIG5vdA0KPj4+IGNvcnJlY3QgZnJvbSB0
aGUgcG9sYXJmaXJlIC9zb2MvIHBlcnNwZWN0aXZlLiBJIHdhcyB0b2xkIHRoYXQNCj4+PiB0aGVy
ZSB3YXMgbm90aGluZyBkaWZmZXJlbnQgb3RoZXIgdGhhbiB0aGUgZW52bSBiZXR3ZWVuIHRoZQ0K
Pj4+IHByb2dyYW1taW5nIGZvciBib3RoIGRldmljZXMgLSBidXQgdGhpcyBpcyBhbm90aGVyIHNp
dHVhdGlvbg0KPj4+IHdoZXJlIEkgc3RhcnQgdG8gcXVlc3Rpb24gdGhhdC4NCj4+Pg0KPj4+IFdo
ZW4gSSBydW4gdGhpcyBjb2RlLCBJU0MgZW5hYmxlIC9uZXZlci8gcGFzc2VzIC0gZmFpbGluZyBk
dWUNCj4+PiB0byB0aW1pbmcgb3V0LiBJIHNlZSBzb21ldGhpbmcgbGlrZSB0aGlzIHBpY3R1cmUg
aGVyZToNCj4+PiBodHRwczovL2kuaW1ndXIuY29tL0VLaGQxUzMucG5nDQo+Pj4gWW91IGNhbiBz
ZWUgdGhlIDB4MEIgSVNDIGVuYWJsZSBjb21pbmcgdGhyb3VnaCAmIHRoZW4gYSBzdGF0dXMNCj4+
PiBjaGVjayBhZnRlciBpdC4NCj4+Pg0KPj4+IFdpdGggdGhlIGN1cnJlbnQgY29kZSwgdGhlIHZh
bHVlIG9mIHRoZSAic3RhdHVzIiB2YXJpYWJsZSB3aWxsDQo+Pj4gYmUgMHgwLCBnaXZlbiB5b3Ug
YXJlIG92ZXJ3cml0aW5nIHRoZSBmaXJzdCBNSVNPIHZhbHVlIHdpdGggdGhlDQo+Pj4gc2Vjb25k
LiBBY2NvcmRpbmcgdG8gdGhlIGh3IGd1eXMsIHRoZSBzcGkgaHcgc3RhdHVzICpzaG91bGQqDQo+
Pj4gb25seSBiZSByZXR1cm5lZCBvbiBNSVNPIGluIHRoZSBmaXJzdCBieXRlIGFmdGVyIFNTIGdv
ZXMgbG93Lg0KPj4+DQo+Pj4gSWYgdGhpcyBpcyBub3QgdGhlIGNhc2UgZm9yIGEgbm9uIC1zb2Mg
cGFydCwgd2hpY2gsIGFzIEkgc2FpZA0KPj4+IGJlZm9yZSwgSSBkb24ndCBoYXZlIGEgYm9hcmQg
d2l0aCB0aGUgU1BJIHByb2dyYW1tZXIgZXhwb3NlZA0KPj4+IGZvciAmIEkgaGF2ZSBiZWVuIHRv
bGQgaXMgbm90IHRoZSBjYXNlIHRoZW4gbXkgY29tbWVudHMgY2FuDQo+Pj4ganVzdCBiZSBpZ25v
cmVkIGVudGlyZWx5ICYgSSdsbCBoYXZlIHNvbWUgaGVhZCBzY3JhdGNoaW5nIHRvDQo+Pj4gZG8u
Li4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBDb25vci4NCj4+Pg0KPj4NCj4+IElmIEkgdW5kZXJz
dG9vZCBjb3JyZWN0bHksIFNTIGRvZXNuJ3QgYWx0ZXIgYmV0d2VlbiB0d28gc3RhdHVzIHJlYWRp
bmcNCj4+IHRyYW5zYWN0aW9ucyBkZXNwaXRlIC5jc19jaGFuZ2UgPSAxLiBNYXkgYmUgYWRkaW5n
IHNvbWUgLmNzX2NoYW5nZV9kZWxheQ0KPj4gdG8gc3BpX3RyYW5zZmVyIHN0cnVjdCBjYW4gaGVs
cCB3aXRoIHRoYXQ/DQo+IA0KPiBELW9oIC0gYnVnIGluIHRoZSBzcGkgY29udHJvbGxlciBkcml2
ZXIgOikNCj4gTEdUTSBub3csIHN1Y2Nlc3NmdWxseSBwcm9ncmFtbWVkIG15IFBvbGFyRmlyZSBT
b0Mgd2l0aCB2MTIuDQo+IEknZCBhbG1vc3Qgc3VnZ2VzdCBhZGRpbmcgYSBjb21wYXRpYmxlIGZv
ciBpdCB0b28gLSBidXQgc2luY2UNCj4gdGhlIGVudm0gcHJvZ3JhbW1pbmcgZG9lc24ndCB3b3Jr
IEkgZG9uJ3QgdGhpbmsgdGhhdCB3b3VsZCBiZQ0KPiBjb3JyZWN0Lg0KPiANCj4gVGVzdGVkLWJ5
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gV2l0aCBh
IHNtYWxsIGNvbW1lbnQgYWJvdXQgd2h5IGl0J3MgdXNpbmcgc3BpX3N5bmNfdHJhbnNmZXIoKToN
Cj4gUmV2aWV3ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQo+IA0KPj4NCj4+Pj4gK8KgwqDCoMKgwqDCoCBpbnQgcmV0ID0gc3BpX3N5bmNfdHJhbnNmZXIo
c3BpLCB4ZmVycywgMik7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoKHN0YXR1cyAm
IE1QRl9TVEFUVVNfU1BJX1ZJT0xBVElPTikgfHwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
IChzdGF0dXMgJiBNUEZfU1RBVFVTX1NQSV9FUlJPUikpDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldCA9IC1FSU87DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoMKgwqDCoCByZXR1
cm4gcmV0ID8gOiBzdGF0dXM7DQo+Pj4+ICt9DQo+Pg0KPiANCg0K
