Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647ED5384DB
	for <lists+linux-fpga@lfdr.de>; Mon, 30 May 2022 17:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiE3PZM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 May 2022 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiE3PY5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 May 2022 11:24:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18110A889E;
        Mon, 30 May 2022 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653920782; x=1685456782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uoGXTDUvfE3JVoMM/q7nYw2eU8+aPwk5V+fZqg3x3BM=;
  b=hbgpOgOmeoNIWTvuBCEa5OzKjNPvmvHTo6hsgU0+iaj8k5g2vhcYYDpf
   ufPta9o4SvQblquGihFPnQ4Cxk2iRsE8+V/IBce/Qid/YwvCgslss5tiW
   fmXoAiFz8rTBim1Zcbxkhnf40idmV1ZyrRnNyBgj+CmGJgh3zha3Qa6Rg
   6XgqhlglLKjZgR+1Sn0a4KXJbQvpn9hcKPcRSVUeO8Jy7j02PBkPCBC7N
   s6rc5KwlcJSoXzHivkh9rcs1O58ySejZXg6DPkCdkVhmQMZdlBfTtQtTJ
   hgqBfyadknbZ+SdQrb56q0nVB91JNYi3cG3sLBXNOH8KQAKRMiLRWdR70
   A==;
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="175701078"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2022 07:26:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 30 May 2022 07:26:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 30 May 2022 07:26:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/JWB1PDzM1kyuqpKobGs9tlnlqDfQFi/wuyqtfq8wxzAolqCiwhCb4BxhV+z/3gWR2Nm7wTnGQ4WGo6ce21susoE5rADXjVr0+Xzs+sJbNBeepGUeDxgjlZg0DMEtUUdaU70lTLqtSmrlX3NzHxnRt0P+B8Npm806ZLB289pxHo3vHYaTTy1s6xCNX0NniwdrX8B44APSIyF6Trm3qDu6Onrx4njP8Jbnp2Nuh3zmjwtyvvg2iFIGWDfbVN6TRVzBpbYLRmnh13pjx3Zy0v+XJsB5EIFAjxRVCFYdhZF8V2GUZvWQCENI6ZLrDIoD8gVgu2W1AQOFBYRi1vb/F1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoGXTDUvfE3JVoMM/q7nYw2eU8+aPwk5V+fZqg3x3BM=;
 b=jqWT3G1oN9nHz9+xrBDBJH7A/3ptyx2WhNXRcMml1pEuPSP9x7JWxUNko4HTh/qyF23PT3ND5x0Bod8GjznJ2LRPSDZmOwlIAU3HAESHDPBgpv4gkD76j7A5nV3sSK+N8fH6mtzSd9hxSrhr1oXvaD2EtEDi3KZY6cNhr8hRIp0MeVxHnqK5kd01VHN1t5ype3PSiPiHTx/cbRLh91MUU2XDwVu37KxHnMBPSXCkzkr08kehjDH6OS08sjwVfDkL9k94I6oth1dHdcLDwHEYCUxHdr0vLTge/nkE+Os74GxAYCknVej0II0c6RKhUY4knpblodN1fVEOcavyphgBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoGXTDUvfE3JVoMM/q7nYw2eU8+aPwk5V+fZqg3x3BM=;
 b=qtyfR2Hdt377L9fDAUsIIc/XxVwHjfjcKe5NKklFEATCd2qtOhjk4hJBiXsm1DyLvoItzSBOdhTq1cFjxI2+MGsnf8ThLLiUH26uCyUb7OFopa5qgYEkzXK+3oO9Q/FYyaZg45f6mlflfthJbt7LpLjjV/77sxiSfBCfSYktSq8=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB2761.namprd11.prod.outlook.com (2603:10b6:5:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 14:26:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 14:26:18 +0000
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
Thread-Index: AQHYcS+MqDCo1uYFDUerOTfzxMPcoq03TEoAgAAM4ICAACZ+gA==
Date:   Mon, 30 May 2022 14:26:18 +0000
Message-ID: <95c44458-aeff-e356-1e32-c8f735570c3a@microchip.com>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
 <f655cf2f-555c-6480-a461-bcddb9e510f3@microchip.com>
 <20220530120701.sedwn3qeohlnj52e@x260>
In-Reply-To: <20220530120701.sedwn3qeohlnj52e@x260>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20e80755-1105-4139-9d17-08da42485ca7
x-ms-traffictypediagnostic: DM6PR11MB2761:EE_
x-microsoft-antispam-prvs: <DM6PR11MB27619F98ED1759261835C6FC98DD9@DM6PR11MB2761.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: br4PB7smm9UXqWtna6xFf+0WmvFlv5dBM0gKqvP1hX4KKbkyAveSbS6XsmwS9nMPFsBBL1ow02p3Uwdk7KYxa6ESN+K+AL5NoaDQzPx8dEzqvOUn93pE+vIQbQcGcYJkdWw4RQrYMmqAKzoarsZbRUIXKP+24Ylr1i1y2BRgi45c+BjViSwbyrXcdBmRT0eHYR+uiW2Z+jzCyF+gWgRK7jrYCum/zavG1vB8c5jCAGu5xwJC3v3bSXdP2SJGc2GFbgdj50uPG49Z1eCyPOfl7qzD2E5ose63Vne3tPmKOKuS5Hyow57S58GszQnjU9tG8g9/cKWK6WqQapAVM2gh4TLVKKNlKvUsvrKE+2bqNKHpQmGvClo+xBWMUolSsXdEbacqnGRDkD9OzAk2U2oYubptr5k3gphcQtO/zGWtjb9TcmUWBhLJTatCjbBqHbA+5rhACyWkFKZyOkxKuwvRnaN45srNjL/ooPT1whVxpuT+Q6qYWhHazgyqddL01/8vPcZDvdSGUoDxaoQUtzpEmd/VSBY7cTNXWlZlkXgU46y4rhRGa8o9VWxmqjZoRtQRdiwHh8folItNQys0AR4nP2xwO2uT33ASZg4ftUY8MJ4BIDb4+m7T52qd8zuNcDmFlWEkLA7yHeJDcPg7LzFjzGd7jKa/TTadTJxG6niAD5ayc0ujKIume5BVuHgygxqqMJgPfS+K1mQZIQFJLhjYwV5aRbxGb9P62Hi/Uf9BoKRGgpqWR9dmz6lrNpnQBQIpv4ujHTcHvvk++njlvxCcwQwoVTHe9XklcJP1ExBMehbutDUhhPhcS9qFLwa47T1uM9q2GaoVMhlT4FpHXAofU63rwEqgunaMWXP5QsxtVKVwjbnWggVwZG55pcQh4ze3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(8676002)(6916009)(54906003)(4326008)(36756003)(316002)(91956017)(66476007)(66446008)(76116006)(38070700005)(31686004)(66556008)(66946007)(8936002)(53546011)(6486002)(6506007)(86362001)(966005)(31696002)(7416002)(508600001)(5660300002)(64756008)(122000001)(26005)(6512007)(71200400001)(2906002)(43740500002)(45980500001)(15519875007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZsZTVXbjlUdUVqUkV3RFo3c2gzbUd1WXc1Y0IwMUtOMHptYmpPL0E5Y2N2?=
 =?utf-8?B?VlV1TCtMZDdpR3ltMjQzUnllck02K2NlVE5hLzJEejh0SFpIQ0pZZndQS2lv?=
 =?utf-8?B?cGt4NzNCdHhyMCt4dUp0WU5qblBvTUFpTGswTktpUGhXcXVjckI0bFhUMGl3?=
 =?utf-8?B?SHR2SmswMGx6SzZVcTk5N2hkTE5NU25OcS9nN3pXNUQ4QWNoZEpuSmpiYjMx?=
 =?utf-8?B?aWJkL1dHd2dHQkFNM1VxNkJpSUpMK2YxMmI0MWwzSUM3WGd0ejQxREhMK3JP?=
 =?utf-8?B?SXBDMWNKVFFYT25GWlhkTVFTYnVZMkhoR0ozRk56WUlZSFZseGRENTFjQTFs?=
 =?utf-8?B?L1lDRjlQRUlrcE95MURBRVRKYnVrbzliR3lkcjh5RFlkTjJVajNNQnhiaWwx?=
 =?utf-8?B?N2liTjc4MVY2WkQ2OVMrSFJ4Um5VcnQ2eE9wcXlkV2t2VlZ4V2drM0RGQTNy?=
 =?utf-8?B?U2dheFpBTWVZWStua3prUE9FdlhId0xLN1JWT3JnWGF4c0tFcG0xRU9uTzd3?=
 =?utf-8?B?eU0zNEV0S2NpbVAzeU9vd2JwQlpWY2E1cnJUemlvb3Y3eDhTVzZYbXlpemt2?=
 =?utf-8?B?ck9peWpOM3pIaEpZUFJreVhCR09KeEFpWUFKYjdSUU1PYzlhTE1nT3kzcFlP?=
 =?utf-8?B?U2h3bmxvbGFkQXJEbGh6S2YrcHE2R1hTeGtTS0dYU1liWE5EOW9wSzRjbTUv?=
 =?utf-8?B?OFNDSVhFK01rQi8yZlVkL0FxTDJiZmc2ZUI2b3A2Q1lBdkRtQVoyZUtIaFQ2?=
 =?utf-8?B?SXFzNG8wemZ0dnQyK2lHRGFlUFFxM2pobUZLTWd1MHd4L2pRcEZGSFRHVVVY?=
 =?utf-8?B?VzdwNDRvN1Nod3ZrZkg2TU5UQ3hvZDJmR2hqd2dGSTRUUVpwYkZlcVF4NzZZ?=
 =?utf-8?B?cjJWSFZyemIxNjluZXdoaHJNRWxXNE1GRVFHV2FHSmxoTUtJYzdvTityanVh?=
 =?utf-8?B?cGs1VFFSNG52aTJIQVhPRWJmRjVaVUVyOXczRDk5WUlaZzc4UDBjeTM2R21q?=
 =?utf-8?B?ZW15MTFmM0szY2tzalFxbmREVlNmUjE3QVQ5RlM4YlBmOGQ5TEViUjQxVXJj?=
 =?utf-8?B?dU04TU9FemtJMEw3NEpFN1R1SWtiWjFtMk5aa1BMK3h1QWZvcXlFS0NKcngy?=
 =?utf-8?B?bytRVWNGRnBWb1ExeThZcGxlSFd6NWNsUG9MSytkZnd2b2ZDUGY3U1IzSmJl?=
 =?utf-8?B?dFExNVR1aGQ4MkJKbS9tbUNRblpNNkNyVFNENnlSWmJpbWZFYnA0S1EySjMz?=
 =?utf-8?B?VCtPNElrZUo1Z01GcHdPbTRxL3dmaXBobW5YK1ljSFhCb3ArajNGU29Zam5U?=
 =?utf-8?B?bEQ0WjE1eGJDVkZLWk9ycUVpMDl1UXViZXhieXZwZnZZcEsvZXEwSWJSZE9l?=
 =?utf-8?B?dGU0ZzQyZ1hSdHZ2bHBadmpMYXoza0ZrQkxpZnE1UFlwd3lEMzJ4azU5cXgv?=
 =?utf-8?B?bHh1T2ZwaDg4NWtHWjVReDNhNGsrQWJBenRqUmhpMVRZR1Ara1JzOU5UeVUz?=
 =?utf-8?B?eWZueVNrL1Z5SVdrQThsTVgrbndueGVZSGY1NlIyUXJzaU5YaWNuMmJDQnlK?=
 =?utf-8?B?enVxRjczNnFjeXlTZTBoQnhRaFcvOE80Z3R2bllhNndyTHpKQW9tU3Y4SUFw?=
 =?utf-8?B?US96WEE4ZDFSM3YyV3QyTjlDdzdDcm56Z1o2RWNxM3RhWlpkTzVKdTMvWHQx?=
 =?utf-8?B?elJuUEE4MFZ1bU1SNXJ4elU2cHBIQUh3aitRTWJLR1lEMldmUFlNcWdnZE1V?=
 =?utf-8?B?UUNEVUVUZHZsSFFKS1pqU0Fhb2k5NjVlazdLZVVkeDBwQUw1Uyt5dXZCVTcw?=
 =?utf-8?B?TzlzMUduYnNQSGFOUUhvQ2htdHMzUFloUnZnN3E5K3JWajBwalgwc0s5ZGp2?=
 =?utf-8?B?OXlFZEdoUHQ1NEZoSzVQK1JITWJGV0hqMnkvd3ZOQWdtU3ljK3Y0dmw5blhV?=
 =?utf-8?B?SzVOVlg4ZnowMjJYcGEwdzBGa1VjMEwveHFTcGNyWkEwTHUxclFOTHhndkNa?=
 =?utf-8?B?YWU5OHJDdFNNZWp1ZVFMZFEzZEsvMlk5T0M0SjFGVVp6MHdVUUZHektUV2Fp?=
 =?utf-8?B?U0Z0OHNXWGNnYWNYdEVWZVVFQzdkQ0FPdTBSTDlxSHJZVXpUWGF5N2ZwTy9u?=
 =?utf-8?B?aDBPTW4wNC9QcmlDQkUrYzIyem9zSlFaRzFhWDJUQUszRXJmTzBoNVFPVEVN?=
 =?utf-8?B?SldEWTQ2Qm1DcElVVExkdDZpeTV1Wi9lcGd2WjhXUWp1L1pOK1F1NFp6dFVy?=
 =?utf-8?B?RjdJV2ZLU0Ruemp4cXAycU9nR3V1NVRGU1J2SkowdnpVZUFwTDFQczNrbDgv?=
 =?utf-8?B?eUdudW4xRnlhU1YvUVA5NW9GN3pYOU9ka3Jybm1qYTZCbVRRMGtldz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DBAE617A649C34E9EC95D8AD05A52CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e80755-1105-4139-9d17-08da42485ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 14:26:18.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ry7smGhrT2fTyWBDk9Qz1BtyJObX0S1enViKaArXBd5+o3dRzGnGvgW50Quz0jwrVnUVGJcew0LOr2a6PYyXIO77b7twkA+NlEdq6xatu9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2761
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMzAvMDUvMjAyMiAxMzowNywgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCBNYXkgMzAsIDIwMjIgYXQgMTE6
MjI6MjZBTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAy
Ni8wNS8yMDIyIDE5OjEzLCBJdmFuIEJvcm55YWtvdiB3cm90ZToNCj4+PiArc3RhdGljIGludCBt
cGZfcmVhZF9zdGF0dXMoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4+PiArew0KPj4+ICsgICAg
ICAgdTggc3RhdHVzID0gMCwgc3RhdHVzX2NvbW1hbmQgPSBNUEZfU1BJX1JFQURfU1RBVFVTOw0K
Pj4+ICsgICAgICAgLyoNCj4+PiArICAgICAgICAqIFR3byBpZGVudGljYWwgU1BJIHRyYW5zZmVy
cyBhcmUgdXNlZCBmb3Igc3RhdHVzIHJlYWRpbmcuDQo+Pj4gKyAgICAgICAgKiBUaGUgcmVhc29u
IGlzIHRoYXQgdGhlIGZpcnN0IG9uZSBjYW4gYmUgaW5hZGVxdWF0ZS4NCj4+PiArICAgICAgICAq
IFdlIGlnbm9yZSBpdCBjb21wbGV0ZWx5IGFuZCB1c2UgdGhlIHNlY29uZCBvbmUuDQo+Pj4gKyAg
ICAgICAgKi8NCj4+PiArICAgICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgeGZlcnNbXSA9IHsNCj4+
PiArICAgICAgICAgICAgICAgWzAgLi4uIDFdID0gew0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIC50eF9idWYgPSAmc3RhdHVzX2NvbW1hbmQsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgLnJ4X2J1ZiA9ICZzdGF0dXMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgLmxlbiA9
IDEsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgLmNzX2NoYW5nZSA9IDEsDQo+Pj4gKyAg
ICAgICAgICAgICAgIH0NCj4+PiArICAgICAgIH07DQo+Pg0KPj4gSG1tLCBJIGRvbid0IHRoaW5r
IHRoYXQgdGhpcyBpcyBjb3JyZWN0LCBvciBhdCBsZWFzdCBpdCBpcyBub3QNCj4+IGNvcnJlY3Qg
ZnJvbSB0aGUgcG9sYXJmaXJlIC9zb2MvIHBlcnNwZWN0aXZlLiBJIHdhcyB0b2xkIHRoYXQNCj4+
IHRoZXJlIHdhcyBub3RoaW5nIGRpZmZlcmVudCBvdGhlciB0aGFuIHRoZSBlbnZtIGJldHdlZW4g
dGhlDQo+PiBwcm9ncmFtbWluZyBmb3IgYm90aCBkZXZpY2VzIC0gYnV0IHRoaXMgaXMgYW5vdGhl
ciBzaXR1YXRpb24NCj4+IHdoZXJlIEkgc3RhcnQgdG8gcXVlc3Rpb24gdGhhdC4NCj4+DQo+PiBX
aGVuIEkgcnVuIHRoaXMgY29kZSwgSVNDIGVuYWJsZSAvbmV2ZXIvIHBhc3NlcyAtIGZhaWxpbmcg
ZHVlDQo+PiB0byB0aW1pbmcgb3V0LiBJIHNlZSBzb21ldGhpbmcgbGlrZSB0aGlzIHBpY3R1cmUg
aGVyZToNCj4+IGh0dHBzOi8vaS5pbWd1ci5jb20vRUtoZDFTMy5wbmcNCj4+IFlvdSBjYW4gc2Vl
IHRoZSAweDBCIElTQyBlbmFibGUgY29taW5nIHRocm91Z2ggJiB0aGVuIGEgc3RhdHVzDQo+PiBj
aGVjayBhZnRlciBpdC4NCj4+DQo+PiBXaXRoIHRoZSBjdXJyZW50IGNvZGUsIHRoZSB2YWx1ZSBv
ZiB0aGUgInN0YXR1cyIgdmFyaWFibGUgd2lsbA0KPj4gYmUgMHgwLCBnaXZlbiB5b3UgYXJlIG92
ZXJ3cml0aW5nIHRoZSBmaXJzdCBNSVNPIHZhbHVlIHdpdGggdGhlDQo+PiBzZWNvbmQuIEFjY29y
ZGluZyB0byB0aGUgaHcgZ3V5cywgdGhlIHNwaSBodyBzdGF0dXMgKnNob3VsZCoNCj4+IG9ubHkg
YmUgcmV0dXJuZWQgb24gTUlTTyBpbiB0aGUgZmlyc3QgYnl0ZSBhZnRlciBTUyBnb2VzIGxvdy4N
Cj4+DQo+PiBJZiB0aGlzIGlzIG5vdCB0aGUgY2FzZSBmb3IgYSBub24gLXNvYyBwYXJ0LCB3aGlj
aCwgYXMgSSBzYWlkDQo+PiBiZWZvcmUsIEkgZG9uJ3QgaGF2ZSBhIGJvYXJkIHdpdGggdGhlIFNQ
SSBwcm9ncmFtbWVyIGV4cG9zZWQNCj4+IGZvciAmIEkgaGF2ZSBiZWVuIHRvbGQgaXMgbm90IHRo
ZSBjYXNlIHRoZW4gbXkgY29tbWVudHMgY2FuDQo+PiBqdXN0IGJlIGlnbm9yZWQgZW50aXJlbHkg
JiBJJ2xsIGhhdmUgc29tZSBoZWFkIHNjcmF0Y2hpbmcgdG8NCj4+IGRvLi4uDQo+Pg0KPj4gVGhh
bmtzLA0KPj4gQ29ub3IuDQo+Pg0KPiANCj4gSWYgSSB1bmRlcnN0b29kIGNvcnJlY3RseSwgU1Mg
ZG9lc24ndCBhbHRlciBiZXR3ZWVuIHR3byBzdGF0dXMgcmVhZGluZw0KPiB0cmFuc2FjdGlvbnMg
ZGVzcGl0ZSAuY3NfY2hhbmdlID0gMS4gTWF5IGJlIGFkZGluZyBzb21lIC5jc19jaGFuZ2VfZGVs
YXkNCj4gdG8gc3BpX3RyYW5zZmVyIHN0cnVjdCBjYW4gaGVscCB3aXRoIHRoYXQ/DQoNCkQtb2gg
LSBidWcgaW4gdGhlIHNwaSBjb250cm9sbGVyIGRyaXZlciA6KQ0KTEdUTSBub3csIHN1Y2Nlc3Nm
dWxseSBwcm9ncmFtbWVkIG15IFBvbGFyRmlyZSBTb0Mgd2l0aCB2MTIuDQpJJ2QgYWxtb3N0IHN1
Z2dlc3QgYWRkaW5nIGEgY29tcGF0aWJsZSBmb3IgaXQgdG9vIC0gYnV0IHNpbmNlDQp0aGUgZW52
bSBwcm9ncmFtbWluZyBkb2Vzbid0IHdvcmsgSSBkb24ndCB0aGluayB0aGF0IHdvdWxkIGJlDQpj
b3JyZWN0Lg0KDQpUZXN0ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hp
cC5jb20+DQoNCldpdGggYSBzbWFsbCBjb21tZW50IGFib3V0IHdoeSBpdCdzIHVzaW5nIHNwaV9z
eW5jX3RyYW5zZmVyKCk6DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlA
bWljcm9jaGlwLmNvbT4NCg0KPiANCj4+PiArICAgICAgIGludCByZXQgPSBzcGlfc3luY190cmFu
c2ZlcihzcGksIHhmZXJzLCAyKTsNCj4+PiArDQo+Pj4gKyAgICAgICBpZiAoKHN0YXR1cyAmIE1Q
Rl9TVEFUVVNfU1BJX1ZJT0xBVElPTikgfHwNCj4+PiArICAgICAgICAgICAoc3RhdHVzICYgTVBG
X1NUQVRVU19TUElfRVJST1IpKQ0KPj4+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlPOw0KPj4+
ICsNCj4+PiArICAgICAgIHJldHVybiByZXQgPyA6IHN0YXR1czsNCj4+PiArfQ0KPiANCg0K
