Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464C34ED69F
	for <lists+linux-fpga@lfdr.de>; Thu, 31 Mar 2022 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiCaJPv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 31 Mar 2022 05:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiCaJPu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 31 Mar 2022 05:15:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B62B4A;
        Thu, 31 Mar 2022 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648718043; x=1680254043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J9ifRTF7z+ZJp21ebyswW23EhOrYI8Jhj9Gj72xxxFo=;
  b=sjSbUyeVChsndOgeDeOlTcp/OxZ0t8AbkmfpumOxMiC3Mq+Bc9acWtQM
   FnjGjJAM5m+8fFZUec0vIYhvpxWlBV8BcpULy6qhf+OGep8WA8UTA7fGq
   7Q7MfquakQ+F5SoWE1CpCzfmi4uri3vnwLO4HktzFKPf9lgKVkZ5P3VKi
   BYwg7bQI+Zv4H0O+fSbaJQ1lQvSve65yPsoWkjHRoUilzyI2cIaqdB8+8
   mkgoJ0VbiObwPPG0zIIFhL6LfzvB9yeLLW5dWPeyMaK9UqVoVaTVsFdVQ
   eG6M8CuE1vYwhK7iMwWe8AiGliz0GV+I+uUM2z70bJm/JU11wtsP7iulb
   g==;
X-IronPort-AV: E=Sophos;i="5.90,224,1643698800"; 
   d="scan'208";a="153874476"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2022 02:14:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 31 Mar 2022 02:14:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 31 Mar 2022 02:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lacy4taYDjhTqVEKODL/n2VGGmD3ckJ2XL7NVNpGHbwyny1seKb2MTKaG22HAGgy6D1JeJyqFJu+iJhw2kTfk97rg9yc8P3hbczATkkZedKxEPRdm86nsYWSDOK3DYoZjg6tdcQ6bcvdnXHsi4zvZTsLE0uI99ygt743OTlwuuZnLXDT6XlQymiOk0LyGV/iQR6rtZxkNY88b7mlkgG+YU1xEypPUM1IW6tEM1ppJcRgL3de+BxXBLL0C9U09xulYteYPmlte/oBkVCJEhPmttB43dDgkgeFbVfeBA3dCo1H7S9xMXCitjr82X4nWaThMZ15BaEqWKhzLLYeBhcQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9ifRTF7z+ZJp21ebyswW23EhOrYI8Jhj9Gj72xxxFo=;
 b=cNEKa9s3+yEzVYtRKs67J76Z8fu8vPq4ZlfyQOoDjhtazWNgH7/rH8vmLLsnZx2MDwSd8HkfFNhDUE8t0JbtKPIEQAiLSk5sgOReh7MpE/PK+3fY0FQ04OzVLeQTtToSX8up74UGHM2G4PYs/wrSntrFbiGhgdVmcTSMBnFe5jk5GtNOeTYbSVtsvMRZ+vJttSWZxAUL3VPu1L8fn/5UfyUC0n6AHDegLM0OUshuegoId9p33p+vaY5Ps9rW5KLJ5bw2f+66EGuH8kxjAU3/8Kvs2bckBDlXvkfnL09T+v8dyhF2ydzXEDDuIwVH2Y3Wdl6s17o0GTM42UkGp2H84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9ifRTF7z+ZJp21ebyswW23EhOrYI8Jhj9Gj72xxxFo=;
 b=H7oenzHzpG6p1O/BiLmYUC99TEpehB++r6JBhkZ+8M/rAiXMemfqOsqV/CW5vcvvGFF2XDaZNYtE37grR3AhWzubjHQIJlG4PgtpJ8I1E4+pu5V92TvGppsi3tP6AEDOj0lKT9zbnfuPaO/LEXW8WFO2iXHIY6BkuE518BFlPBI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BN6PR11MB1858.namprd11.prod.outlook.com (2603:10b6:404:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 09:13:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%8]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 09:13:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>, <system@metrotek.ru>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <Cyril.Jean@microchip.com>
Subject: Re: [PATCH v8 1/2] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v8 1/2] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYPiQYBSo2vamJ3kSTtBtrK+3xyazYCtwAgAAUEYCAASP0gA==
Date:   Thu, 31 Mar 2022 09:13:49 +0000
Message-ID: <cb25db26-4ea3-c512-e85f-91c091dc54b8@microchip.com>
References: <20220322191552.13156-1-i.bornyakov@metrotek.ru>
 <20220322191552.13156-2-i.bornyakov@metrotek.ru>
 <7fcde9aa-c086-33e1-1619-04663bfeff85@microchip.com>
 <20220330154831.kqqm7cymxa3reffk@x260>
In-Reply-To: <20220330154831.kqqm7cymxa3reffk@x260>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af202974-5593-41af-48e5-08da12f6c4e0
x-ms-traffictypediagnostic: BN6PR11MB1858:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1858E38F327D6588C26A8E5298E19@BN6PR11MB1858.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWWyleinHisgxc6qdNWSu6cbsDKAobNr9MLv5Zv6m5xJSQBWW92D3b3uHk8bdnzIzPBiZg8EeSBTHAh3IZclHmL67oC29j/gDg/5Cr22WfG5QE0csNvn/9RNp7xrsNmmUYYe+5sjSCqigCMdVOLc/i1guFeslVqlsAOUtAk6bSf974jjCetmGLpM4XNwqJWyEfRBa0f6BeRJEoUHnEyNDujkwFd5OZmXXBEzBN1ynsecFGG5L3Vj44MLrywPLAzadxyP498iZSEYfZp1/E26syTHA1Bs11kyDA7HqsMKDprKACzal6aBkGgkQPZzgbvbEQTDXtqOfgKFBNtBhru/4vByY6qHVjNjxzS/yx5FZlgfQe8sTASrk1HzgRhgbbpx29XBs24F/cDVUsK5z1MA4v5ofvqfDhCR+bXfWiiPA8225q+KygY9UvcgYqkG1ueOOOZgX0faFvTOttQ56QrXqeVn6+ZU3c3bFrgSTUqqelxccUxICPn1v/c/uxtj47hRYBJJ/xs9/dmk+EK1F+S5iHVj2rI5HDnOrr0cT7ZY4svQyLscFx0Y25fOq744whdk6a7G2J2H4KtrpcrsyAE8/Xz28bJGCdT2b7VIOPMaflJeYoqfWb2Q/V0oBoYJwJZr4hmRT4HlE8tTrLxSa4IBVxScvNt5LiObialYnPm9QGvYW4xaYpr2hvfyUQiPZeS5r1Nyb+/7vz4+IGdpCTmNXeGYXU7tcwptXdJtQsHg2EOtlGk6p2e3088TMLh3SCQlz/h/uxGq85W7UB2jc0YhNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(26005)(91956017)(86362001)(66476007)(66946007)(66556008)(66446008)(64756008)(53546011)(7416002)(71200400001)(6506007)(6512007)(54906003)(2616005)(316002)(76116006)(107886003)(6916009)(2906002)(38070700005)(186003)(83380400001)(122000001)(5660300002)(36756003)(6486002)(31686004)(38100700002)(31696002)(4326008)(508600001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG10emtvRXA4SldVblMxaEV4bkZtOWE3Kzd3Zml3MHE2bkZDOVJXNmF5Tjgv?=
 =?utf-8?B?Q3ZWdUhCK3hSTlJFeEs5NkZwaVNDSWhQditDYWY0TllZUm01eGgvb25DUExS?=
 =?utf-8?B?MmVsUVZGbGFScjZoOSs3dlpSVElZUCtXRUJSQUlmYWlSYldrZlh4L0owa0NS?=
 =?utf-8?B?TkZpL0pRb2prVGJBeTNielIrb2FCZ3gvVFp6SmJUeUh4SVlvMWM4OVlCUUtO?=
 =?utf-8?B?NERwbU44SG1seE9NVnE5S1ozY1ZqUklOdFAyc25QZ0MwclpXN1AxV0h6bmox?=
 =?utf-8?B?UE9ZcXR0bWt6cEQ0N0tLYWRZS0N0OHRUWmwzc1dHR09PMDNQMTRPdjFKVjlX?=
 =?utf-8?B?WURUcFI3Y2MvL3ZqaUlvMDVzZWh6UXRvZkRueUQrc0UxRFFwQWVkM00yYmNJ?=
 =?utf-8?B?VlJiS3JhTzdXNmxTYzNwamRxb3k4M1FEYlFYUGFQa1E1SXRrelJSUmNOZ0Zm?=
 =?utf-8?B?QmUvQWNyN2NlS0tPbUVuOW9mME4zM2ZrajZLcDJPVWp2RTYzckhMZHVYZ3hh?=
 =?utf-8?B?Q2ZvK2Q3eTRCT3FhUVAyUG5YaENuaDhvNVoydUJ4RlJyazZ1UStCYkxjYnFG?=
 =?utf-8?B?a3A4S3E3L09iR1FaREVLZmp2MUltNjVaYncwYkorRFRTTjNJNjNlb1lyVGRB?=
 =?utf-8?B?TjZoRVFSUm9HVVRieTdnVlZVd2xwWmxsTFpZcTg3MGVpdVpvbm5ic293Z0pX?=
 =?utf-8?B?TEE5d0t0K3l2Y00yMlNSQ214eGdOSVZDVXEyc29Hb3lIQWpuZ3B1OWkyL0Iy?=
 =?utf-8?B?RzgrTDFNUVlrUk5tRXZhdVVONUNvYnlpRjh2ditsdlVxek56UkFHVjZoSzd6?=
 =?utf-8?B?SE5oLzYrVkJrdVNtMHNKbnNyeWpscVNQS29SSklHWlkwMjVOUTdsT3FTZ0dD?=
 =?utf-8?B?ZTVIZ3lxcGhHYVVnYWd1emZHeTV1aERhQmRSRVpRd1c4bXM5OFFYNnU4N0lj?=
 =?utf-8?B?cGNPWnEyM29ZdHlVMjFtT25UL25yWnZPbFFVeEhGZlNXV2tLTXg5ZHM0T2FV?=
 =?utf-8?B?elRKS1g5TS8zcVFHR3NWTklyMXBXTTV1aFJXQ2Q5b2dMWDVkQ2YrWTgrOTFZ?=
 =?utf-8?B?RlZkbHV3Q3VKMkE4dWxPR0hSSm9wQmU3Y2hGT2hHWmlSUG5tWFhPWkpRWkly?=
 =?utf-8?B?bVg2S0g3VHA3cE9pR2xEcGFDVHVqSEJqNGpZdHdRejFYUW02Z2ZxbFJiZWtB?=
 =?utf-8?B?T0tRZXQ0NnhBWDFuSGhmSENWUklnTDJ1ZzZhUDR0bDFwVEx6QWdhN1B1VnNN?=
 =?utf-8?B?S1J3bXJaYXVGL3g5cUs1T2d3Qm9adStsa21nMmIzVWl0U2U0WkhmVWw4TmdH?=
 =?utf-8?B?TGlwT043eXp4WXdabmhrdlVwanhEM21GK01uN0xhT2MxQnRjY2Rjb3BZeGJT?=
 =?utf-8?B?UGsxSjRQYUp5NDdCR21yMWdpaGVMZkJvOVNaaEpiQWdRQmkyVGZ5YVlwbk9J?=
 =?utf-8?B?Q1RacUZKRW5UNTZvbFA1ZVdMUGZqekFoSWsrSVFPRG5zdEZvTkxPZkROb3Zn?=
 =?utf-8?B?UVFJd2gxRDc4a3N1dENFQ1FiT213Z0s0SnF0MzZJbUc5em9lMDBOSmNFeThi?=
 =?utf-8?B?OEpoVGhTRG05d01UMjF5WEVWZUdzUEJmNlFKUmtYQXJKR3IrTHBVc05USS9q?=
 =?utf-8?B?SlF0cnV5R3JrTVVmUWZpRnlLZldZYkMvWXF2VTZkOVltU2wwRUpqTWdmR2VL?=
 =?utf-8?B?VFhkSUdwMlduY20xS3B5UE05bTlMTkx5RENPNmRpMmVlTFdWQThzN3BZNFVN?=
 =?utf-8?B?enNWemVrNUpzRThqL3dMQzJEUHNqSTFlaHh5S1NqYVJqdm1VTlAwNmVVZzVs?=
 =?utf-8?B?cm1NMEZhVUNhWHMzNzF6MDFWd0hiYnMrUlNnNW1WL0R5K0J2OVJuWHNSSlFD?=
 =?utf-8?B?Zk8ya2FPSXJRQkw0cC9vbE91TFF4QlBKL09TOUJZeFlGYUkxYzdQTDlKSk8z?=
 =?utf-8?B?ajZjbjVYUTQwQ1Z0UkI0QUJuekVlTE1WcTNGa2p5WE5KRURVRlVpS3A2cUxO?=
 =?utf-8?B?ZlN5cmlDckIwQU5nSVRPM2RwNjlna0lSZEZvejZKSmFGeEpseEQwdnR5Qjc2?=
 =?utf-8?B?NnZsSkNYQVhhWFBSdXRJYWQ0cmdNRDBHeDVoWS9ycDg4alBaSi9FdHJQdlp0?=
 =?utf-8?B?MGdoVnkyT1BlcFVTbDN1Vm9WZGZnN0ZBNzBjbTEyUnFFZVAwWUh5eTJDSjhk?=
 =?utf-8?B?ZjV6cVp4UVdnYVVkYXhRMTdQN2lxMTVPUVEyZk5vVDRhbkU1VzA1dTZ1MnlD?=
 =?utf-8?B?b0VyRERDSzhReFcwZ1k0MVR1T2M3c21ORXQxNHlOSHJqdzgwSUZIclFuUy84?=
 =?utf-8?B?aTJpRExBODU2SmtWaHpTZlhxOHJKendTVkN1d05EejhkWU02aEd6UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11E54BA105D1414A90B2E4DBCC4F3193@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af202974-5593-41af-48e5-08da12f6c4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 09:13:49.9853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUU307fBQP7ZQtSnmglBxF0WTdZKqydSKXEtBwqWhOhxNA5ezF+DMJlAK/seQoBKdcLOQCXuNEcHhu9/OHWKkyTqsYz7w7eSpX5fhyPwRyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1858
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMzAvMDMvMjAyMiAxNTo0OCwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksIENvbm9yIQ0KPiANCj4gT24gV2VkLCBN
YXIgMzAsIDIwMjIgYXQgMDI6Mzc6MDVQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+PiBIZXkgSXZhbiwNCj4+IEJlZW4gdGVzdGluZyB0aGlzIGFuZCBnZW5lcmF0
ZWQgYSBjb3VwbGUgcXVlc3Rpb25zLg0KPj4gSSd2ZSBwdXQgdGhlbSBpbmxpbmUgd2hlcmUgdGhl
eSB3ZXJlIHJlbGV2YW50Lg0KPj4gVGhhbmtzLA0KPj4gQ29ub3IuDQo+Pg0KPj4gT24gMjIvMDMv
MjAyMiAxOToxNSwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+Pj4NCj4+PiAuLi4gc25pcCAuLi4N
Cj4+Pg0KPj4+ICtzdGF0aWMgaW50IG1wZl9vcHNfd3JpdGVfaW5pdChzdHJ1Y3QgZnBnYV9tYW5h
Z2VyICptZ3IsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGZwZ2Ff
aW1hZ2VfaW5mbyAqaW5mbywgY29uc3QgY2hhciAqYnVmLA0KPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNpemVfdCBjb3VudCkNCj4+PiArew0KPj4+ICsgICAgICAgY29uc3QgdTgg
cHJvZ3JhbV9tb2RlW10gPSB7IE1QRl9TUElfRlJBTUVfSU5JVCwgTVBGX1NQSV9QUkdfTU9ERSB9
Ow0KPj4+ICsgICAgICAgY29uc3QgdTggaXNjX2VuX2NvbW1hbmRbXSA9IHsgTVBGX1NQSV9JU0Nf
RU5BQkxFIH07DQo+Pj4gKyAgICAgICBzdHJ1Y3QgbXBmX3ByaXYgKnByaXYgPSBtZ3ItPnByaXY7
DQo+Pj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmbWdyLT5kZXY7DQo+Pj4gKyAgICAg
ICBzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpOw0KPj4+ICsgICAgICAgdTMyIGlzY19yZXQ7DQo+Pj4g
KyAgICAgICBpbnQgcmV0Ow0KPj4+ICsNCj4+PiArICAgICAgIGlmIChpbmZvLT5mbGFncyAmIEZQ
R0FfTUdSX1BBUlRJQUxfUkVDT05GSUcpIHsNCj4+PiArICAgICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJQYXJ0aWFsIHJlY29uZmlndXJhdGlvbiBpcyBub3Qgc3VwcG9ydGVkXG4iKTsNCj4+PiAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4+ICsgICAgICAgfQ0KPj4+ICsN
Cj4+PiArICAgICAgIHNwaSA9IHByaXYtPnNwaTsNCj4+PiArDQo+Pj4gKyAgICAgICByZXQgPSBt
cGZfc3BpX3dyaXRlX3RoZW5fcmVhZChzcGksIGlzY19lbl9jb21tYW5kLCBzaXplb2YoaXNjX2Vu
X2NvbW1hbmQpLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmlz
Y19yZXQsIHNpemVvZihpc2NfcmV0KSk7DQo+Pj4gKyAgICAgICBpZiAocmV0IHx8IGlzY19yZXQp
IHsNCj4+PiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZW5hYmxlIElT
QzogJWRcbiIsIHJldCA/IDogaXNjX3JldCk7DQo+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiAt
RUZBVUxUOw0KPj4+ICsgICAgICAgfQ0KPj4NCj4+IFNvLCBteSB0ZXN0IGJvYXJkIGZvciB0aGlz
IGhhcyBoYWQgYSBQb2xhckZpcmUgU29DLCBub3QgYSBzdGFuZGFyZA0KPj4gUG9sYXJGaXJlLiBJ
IHJhbiBpbnRvIHNvbWUgcHJvYmxlbXMgd2l0aCB0aGUgSVNDIGVuYWJsZSBjb2RlLCBkdWUgdG8N
Cj4+IGEgc2VxdWVuY2UgZXJyb3IuIEFmdGVyIHNlbmRpbmcgdGhlIFNQSV9JU0NfRU5BQkxFLCB5
b3UgdGhlbiBkbyBhDQo+PiBwb2xsX3N0YXR1c19ub3RfYnVzeSB0byBob2xkIHVudGlsIHlvdSBz
ZWUgYSBTVEFUVVNfUkVBRFkuDQo+PiBwb2xsX3N0YXR1c19ub3RfYnVzeSBkb2VzIGEgdzhyOCB0
byByZXF1ZXN0IGFuZCB0aGVuIHJlYWQgdGhlIHN0YXR1cywNCj4+IGFuZCB5b3UgZXhwZWN0IGEg
c2VxdWVuY2UgYXMgYmVsb3c6DQo+Pg0KPj4gb3A6ICAgICB3ICAgICAgIHcgICByICAgdyAgIHIN
Cj4+IE06ICAgIDB4QiAgICAgMHgwICAgICAweDANCj4+IFM6ICAgICAgICAgICAgICAgIDB4MSAg
ICAgMHgyDQo+Pg0KPj4gSSBjb3VsZCBub3QgZ2V0IHBhc3QgdGhpcyBjaGVjayAmIGl0IHdvdWxk
IGp1c3QgcG9sbCB1bnRpbCB0aGUNCj4+IHRpbWVvdXQuIFdoYXQgSSBzYXcgb24gYSBwcm90b2Nv
bCBhbmFseXNlciB3YXMgbW9yZSBsaWtlIHNvOg0KPj4NCj4+IG9wOiAgICAgdyAgICAgICB3ICAg
ciAgICB3ICAgcg0KPj4gTTogICAgMHhCICAgICAweDAgICAgICAweDANCj4+IFM6ICAgICAgICAg
ICAgMHgxIDB4MCAgMHgyIDB4MA0KPj4NCj4+IFNvIHRoZSByZWFkIGluIHRoYXQgdzhyOCB3b3Vs
ZCBhbHdheXMgZ2V0IGEgemVybyBiYWNrIGFuZCB0aGVuIHRpbWUgb3V0Lg0KPj4gQ2hhbmdpbmcg
dGhlIHBvbGwgZnVuY3Rpb24gKGp1c3QgZm9yIGlzYykgdG8gb25seSByZWFkIGdhdmU6DQo+Pg0K
Pj4gb3A6ICAgICB3ICAgICAgIHIgICAgICAgcg0KPj4gTTogICAgMHhCICAgICAweDAgICAgIDB4
MA0KPj4gUzogICAgICAgICAgICAweDEgICAgIDB4Mg0KPj4NCj4+IEZvciB0aGUgY29kZSBhZnRl
ciB0aGUgSVNDIGVuYWJsZSwgSSByZXZlcnRlZCB0byB5b3VyIGltcGxlbWVudGF0aW9uDQo+PiBv
ZiB0aGUgcG9sbCBmdW5jdGlvbiAmIHRoZSByZXN0IG9mIHRoZSBwcm9ncmFtbWluZyBzZXF1ZW5j
ZSByYW4uDQo+Pg0KPj4gSSBzcG9rZSB0byB0aGUgZ3V5cyB0aGF0IHdyb3RlIHRoZSBIVyBhYm91
dCB0aGlzLCBhbmQgdGhleSBzYWlkIHRoYXQNCj4+IHJlYWRpbmcgdGhlIHN0YXR1cyBiYWNrICph
cyogdGhlIDB4MCB0aGUgcG9sbCBjb21tYW5kIGlzIGNsb2NrZWQgaW4gaXMNCj4+IHRoZSBleHBl
Y3RlZCBiZWhhdmlvdXIuDQo+PiBUaGV5IGFsc28gc2FpZCB0aGF0IE1QRiBzaG91bGQgd29yayBp
ZGVudGljYWxseSB0byBhbiBNUEZTIGFuZCBJIHdhcyB1bmFibGUNCj4+IHRvIGZpbmQgYSBkb2N1
bWVudGVkIGRpZmZlcmVuY2UgYmV0d2VlbiBNUEYgYW5kIE1QRlMgb3RoZXIgdGhhbiB0aGUgZW52
bSwNCj4+IHdoaWNoIGlzIGFuIG9wdGlvbmFsIGNvbXBvbmVudCBhbnl3YXkuDQo+Pg0KPj4gQnV0
IEkgY2FuIG9ubHkgYXNzdW1lIHRoYXQgd2hhdCB5b3Ugd2VyZSBkb2luZyB3b3JrZWQgZm9yIHlv
dSwgc28gaWYNCj4+IHlvdSBjb3VsZCBwb3NzaWJseSBzaGFyZSBzb21lIHdhdmVmb3JtcyBvZiB0
aGUgd3JpdGVfaW5pdCBzZXF1ZW5jZQ0KPj4gdGhhdCdkIGJlIGdyZWF0LiBPciBpZiB0aGVyZSBp
cyBzb21ldGhpbmcgdGhhdCB5b3UgdGhpbmsgSSBhbQ0KPj4gb3Zlcmxvb2tpbmcsIHBsZWFzZSBs
ZXQgbWUga25vdy4NCj4+DQo+IA0KPiBJZiB5b3UgcmVwbGFjZSBwb2xsX3N0YXR1c19ub3RfYnVz
eSgpIGZ1bmN0aW9uIHdpdGggdGhpcyBjb2RlOg0KPiANCj4gc3RhdGljIGludCBwb2xsX3N0YXR1
c19ub3RfYnVzeShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCB1OCBtYXNrKQ0KPiB7DQo+ICAgICAg
ICAgIHU4IHN0YXR1cywgc3RhdHVzX2NvbW1hbmQgPSBNUEZfU1BJX1JFQURfU1RBVFVTOw0KPiAg
ICAgICAgICBpbnQgcmV0LCB0aW1lb3V0ID0gTVBGX1NUQVRVU19QT0xMX1RJTUVPVVQ7DQo+ICAg
ICAgICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgeGZlciA9IHsNCj4gICAgICAgICAgICAgICAgICAu
dHhfYnVmID0gJnN0YXR1c19jb21tYW5kLA0KPiAgICAgICAgICAgICAgICAgIC5yeF9idWYgPSAm
c3RhdHVzLA0KPiAgICAgICAgICAgICAgICAgIC5sZW4gPSAxLA0KPiAgICAgICAgICB9Ow0KPiAN
Cj4gICAgICAgICAgd2hpbGUgKHRpbWVvdXQtLSkgew0KPiAgICAgICAgICAgICAgICAgIHJldCA9
IHNwaV9zeW5jX3RyYW5zZmVyKHNwaSwgJnhmZXIsIDEpOw0KPiAgICAgICAgICAgICAgICAgIGlm
IChyZXQgPCAwKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+
ICAgICAgICAgICAgICAgICAgaWYgKCEoc3RhdHVzICYgTVBGX1NUQVRVU19CVVNZKSAmJiAoIW1h
c2sgfHwgKHN0YXR1cyAmIG1hc2spKSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBzdGF0dXM7DQo+IA0KPiAgICAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAyMDAw
KTsNCj4gICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gfQ0KPiAN
Cj4gV2lsbCBpdCB3b3JrIGZvciB5b3U/IEl0IGlzIHN0aWxsIHdvcmtzIGluIG15IGNhc2UuDQoN
ClllYWgsIHN0YXR1cyBjaGVja2luZyBhZnRlciB0aGUgSVNDIGVuYWJsZSB3b3JrcyBmb3IgbWUg
d2l0aA0KdGhpcyBjaGFuZ2VkLiBIb3dldmVyLCB0aGUgbXBmX29wc19zdGF0ZSBzdGlsbCB1c2Vz
IHc4cjggJg0Kd2lsbCBuZWVkIHRvIGJlIGNoYW5nZWQgdG9vLg0KDQpUaGFua3MsDQpDb25vci4N
Cg==
