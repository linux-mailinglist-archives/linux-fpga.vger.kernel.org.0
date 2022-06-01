Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8346F539EBE
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Jun 2022 09:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350426AbiFAHu7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 1 Jun 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350439AbiFAHt6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 1 Jun 2022 03:49:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AA99CF65;
        Wed,  1 Jun 2022 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654069794; x=1685605794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KMGG3s63g7F8W6U7NOQR/z+zvmuqzdessFjNYbFMXrg=;
  b=bwcbQGvZjX4VNrVPOoYCKFjpPTLOIJLPfaoYmm0VMY2qQM+HGKq9Wo+S
   aiFmBd7mzpz7JctMFVjg+LAzalCzhR2jd3yo/su9UZg/N1al+hhWNtoJe
   rh0mKT2FQOOW+wlU1hEzbC/SO/EgI4FDdGtM8ND1qZcHwwdCn1zBllvUP
   IuRYBlBNY/T6iCF8vxkdslaLjobg6dSSoEV66/mhHEPuERRnukWEXF0QG
   /9QjFnSEgHvgrmiFa/Qk+4tVgG6t7rEvpQ8Q7Sr+smCRSimHtVsAu6KBt
   bsn91oY8PizFoY7BmNxyFaqNjOiei90h+LrfAdYLeRdwQwblxGqmuBWs6
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="176003506"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jun 2022 00:49:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 1 Jun 2022 00:49:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 1 Jun 2022 00:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFA6ksqvGHXU3wan2MHXW8TeWxcWDne+qErRJAFeslrQMoLqsfaAsa+q6ZS/+mn+hYFXByn0OePgmyti8u1v8gQ2es1Fz4eE00baRr9TR92IIulvDXyGT0jeqDOeT3V2H5H/pRKmef3UqzUS3ZpLfhnj955vqz+FwQ/hfR9qUh8GJwX8gQqdjcMSfFmF3fcuL+4jzs56F6bFQzIB1MdVI+woSnGhy1e5Y9w3w8NrqMBDM1J2lHLwqa+YfVBo5sNHtq2EfdRLRl/pdlaiFUV2e6ewzf3RINy+DBeLQoqtE2pKYZ6hykAt1jSjLTI+SwVIMhiF5c06KAzY2GNQINNjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMGG3s63g7F8W6U7NOQR/z+zvmuqzdessFjNYbFMXrg=;
 b=ioOHgVXt6GOOWfgwP+DVfw9XfQNFGHIAo0n9cJcYlBJJ0CnZIVJ93IG8Q4/GRmLxo92sGh2s2A1A6r0eVhJasgB++/tQ4zJrrvny911fHJhKtIsdWpPssQvMfRq29loi72YL6LpLUUnONuLMAPSFrvsI3mKBRhdwDWxY1H/MysGLrLzqRvizNtXUYiOlDqAbZHPCDOzS96kCNIojJPO8aHX4MWZ4DtqWHaIxywMgiaFJFkiZ3s/BJNVnxF0R6FbpwxMxbdfUGBrJF7DjFUNhfwzhzd9PbXy7c7AWqE9TD+yN3TJgUpP1M24qK86p0WUF3xRbmS3Llqcz8HtKN0qa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMGG3s63g7F8W6U7NOQR/z+zvmuqzdessFjNYbFMXrg=;
 b=tnp3s/O7Yj13IEe+WwEpxvWjH9LghtoM15lfyaMJ0ILHGwCf7AHuqXqW0rmw3fmvRnf9X1yyteqVrboES5YuwLbEmKYcpV/kDIYYPmti7/bvXji+6Xt6dwuc9K3Q4I+iWGIS1yNgXC25dFbyLrOHgnaD+TFOqXb/jZEldP4MHTI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 07:49:48 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 07:49:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <system@metrotek.ru>
Subject: Re: [PATCH v14 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v14 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYdSc3E0V1w64Juke2s/z1FzTpC606LZqA
Date:   Wed, 1 Jun 2022 07:49:48 +0000
Message-ID: <7a350b92-d6a6-c0e1-95f7-ff711699f850@microchip.com>
References: <20220531192344.23038-1-i.bornyakov@metrotek.ru>
 <20220531192344.23038-3-i.bornyakov@metrotek.ru>
In-Reply-To: <20220531192344.23038-3-i.bornyakov@metrotek.ru>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d1a3942-a4e2-48a6-1d2c-08da43a34d5a
x-ms-traffictypediagnostic: PH7PR11MB6378:EE_
x-microsoft-antispam-prvs: <PH7PR11MB6378EF3FAAFB1816DAD374B298DF9@PH7PR11MB6378.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tC4vznWQF69HM0qnOwRm5mtCmm+FiLVALJjWsN1VPAhjT7AeyK3PhR2gEG4zdqvWHEEiDmK4UIkmoRFGNfZY4cug8NKGFF224iuSVe/EgB8MpYZHdX/+si6aqZJhxCOgojCKgD75VlJyWqRbYtHkyY5QO8oQQwgaGHj7rfeu4DXcsNHuGQU+WMAXJNYViPZcX3zZJzgl/qp+70ajuIteL2IZRz7ENABAH27M/bD7hcSL3kAxMYb9I+xKxgjbRhkVvVllzm12ZwVEJSDZ1grs46rqCd0VgwBPuChZd3cgefkzgD4hPgNyB91ezDfDbje6pQQg3GrdZMo5uVH3TZnjw/ISrlUCi6JCsKC2STiSWAflIvIziNwyZCFcv5PgVhD8+4Gjy01Hv/SaYHnayhp8HtIZ3os/W5RuKW+8HygC6tKapPOVFiQBekyc365cjYk6292rwYAE20aLLftTlNGocy9IguLapLZ3u1t1dVgUpmND3uGRGPKcS/OKjsd2fCWP5eZHv6RcDs5k+yXg1fxnxPGBLT9otN8cBjv6/G+YUoIC6+woGi+Nk3VXLPXmtw1ZFpmrYbImBBNHAoeR/6zGgLZopIrorzQlw5iFaNJWXN6h04k/Ub1Wo2ekeqSzB0niuLfMN1JquGu843J+Gd83gAkblTvWybHM68exP8VSdh2GaudK/cNAKtLiSfPOl/jlSyL6kb/ulRvgUWyHbFKYDSFa6X01FQsfL5GSxkvpSPUcPmsMUFWEFFs/p5romSkjFgKkUE2E7iW7GCzdnSAozw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(71200400001)(5660300002)(38070700005)(8936002)(6506007)(316002)(31686004)(53546011)(36756003)(6486002)(6512007)(54906003)(110136005)(26005)(83380400001)(2616005)(8676002)(76116006)(31696002)(4326008)(66476007)(66446008)(186003)(66556008)(91956017)(64756008)(66946007)(38100700002)(2906002)(86362001)(122000001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVY1ejdVbWw4bDZiTkNDSFBra0lVNmxOdEd1NUVCMGpLTGRZbCtDcUUvK0JS?=
 =?utf-8?B?bWV1azZSVnZJR1FjM1hYMWtpQy96Z2dLdTNROXlGWXNhaFNaL1dmNGVWSUpZ?=
 =?utf-8?B?V09rdW92U21sQVJHNDAvSWpzZkJ6OXhDQVRmWm96THJKWHZqS0taY0NCWUNs?=
 =?utf-8?B?a21rWTFQclIwdHBVaXlaWnE2cXA2SFF3WEREcGcxUGlUUHd3N0QrWlRPajZm?=
 =?utf-8?B?d25iS3RpVkVjZG92V2x3RVVHeHYyS2c5VkFEcS9SVDhxVUJTNXVvblpNVU5J?=
 =?utf-8?B?bTVNMXhHNkxrcUxXME5rWWdoS25jeXMwcjRjd2EySVlEb0pzUk1ibk9COFVo?=
 =?utf-8?B?eHBNK0tmZ3ZVTkgwZ0RMcjVRZmxkREJ3Wm8rYysvZXhpd0tSS0pQYlUyMk5Y?=
 =?utf-8?B?d3VyYkI4bzMwM1pnSlBHbmFTV21BZERvSkV3VW1FS2c0L21TL2FaZXcwOFhS?=
 =?utf-8?B?RWxITXhqNCt2Uk8yemEvdzFFZHIzMzZySjRvUXNDa0M1VmRsVnBMVFlUa2dt?=
 =?utf-8?B?bUhBZjNnUHhtRjJNUi9mOUZHcVM2TDk2YmpUM1BRaFkzRDREc3kwZzR1ZlJY?=
 =?utf-8?B?WG81Y1pjendHZWdVLy9rdS9rL000RDB4dEc3bWUzOVdRUUNWZTczcXpTQ0V1?=
 =?utf-8?B?a1ZGMC9JUXA5OWZ5ck4zRElpcyttYlJ4Wi9JL0xzMGtPWVpKVmpKUFlvTWkw?=
 =?utf-8?B?azB1TlVKZDdmTXRMdDNrbjByNGRNNnVpbEdzMHFkOG1GR0pLbURNVGNuSVJr?=
 =?utf-8?B?V3lFR1lhVGJRZUhnWDN4SjJsY20xK0xNczErUlF3R1B4MW42cVBLUG4wSmFC?=
 =?utf-8?B?cHQralR3bnpGeUpUZ1F1M2ZBN0tVNmJ0YzNUUVN6K1lVT21sTnFwaHljaVJk?=
 =?utf-8?B?M1gxdXlnUTRSaUVLdVdWUVBWN3VSakVrTnJMa3cxR1ZRaDhZcnlxWDBlZ3lG?=
 =?utf-8?B?UEVqRTRqb3Qwd0V1WHF2YnBGby9iTXN2dG9INEhQOC9zWHlMWUZTanRCNUZk?=
 =?utf-8?B?R0lvMDRoQkNKNWptdlVIYVpNWkcrbVM5MXc1NFpZdlZJMUN4aDBSaHlGK0M0?=
 =?utf-8?B?STFZUTRBbS93OVNsOUR0b29xWnI5aWxOb1VNR0dCVUw1SHBZTWpxMmNsQ2Fk?=
 =?utf-8?B?elN5MWRGM0wwVzlQUmY3U1ZpSTY3UHhHRW1xMXZrcC9QL3hvWnNNUVF6UFNu?=
 =?utf-8?B?WDJBbSttMitzZlZRdDd3Q1JYSGVyRjdCQWY1MlNBUW9FRHBmVmJBMTlRalov?=
 =?utf-8?B?L1FHeUhMb3JveEJwZDREcGJsQlZIc1pvbVRST0h0ci8wbE1QVVpPVyttMEY3?=
 =?utf-8?B?LzNrWFl5US9KTkQxQjYwdUl4Tit2UjBoZFNrVkp3WGhSSFUzMGxjRGhtdnNF?=
 =?utf-8?B?NU1NRnZ0dkJVdDdENDNTalZLY3kzeG4zSTJDNkUzZ3d6dlJSLzNod0NWZ1Bj?=
 =?utf-8?B?c3BIcjA3WTQzajBRMnRjWTRVaWZ6NjRrOEdZc3ljejJ4ME4reXloQUJqNzZS?=
 =?utf-8?B?Um9RSHA4OEpESWJFU3RNS3VERSs0a2haLzdCcUhnckZIWVVFTEU0dmVUSlc4?=
 =?utf-8?B?dU1iY2c4TGFwdmJKTUhhTjNPQnErbG9xWGFXYXRsd01IcHMrSVZjTm56UU1C?=
 =?utf-8?B?Y1NUYXdsWTlxbjJhMVFEekNRS3pmRmdDdHkrYUxZZkRkalhjK09EMy9SSWYr?=
 =?utf-8?B?WnpRTEozQS9VUDgrODFsVFN6aHNaeXVLSldueDd1N2E5Y1BVSnJmRWR5c09x?=
 =?utf-8?B?a0I3YXlzaytvZ0FsMmYzZXpDVDRaSjh3c0V6MzVhalhlMEdadk5aMHB1d3do?=
 =?utf-8?B?SDA0V3VvU09JQ1lDL2tGSjZNQk12V0FoTVErRGlONittSWNFNWpMUlZtNk4x?=
 =?utf-8?B?WGtZU1pIN3QrclNJSFpLK2M5cGZBVFNPTkd3VzhnMUJrd3ZZL2tiZ1hBTDNF?=
 =?utf-8?B?dS9OR0l5WXhnT0ZsRGJvbXNIS2RpN1BoVzN0bGZJWDVYd3ZEZHJ0REdoTGJu?=
 =?utf-8?B?SzBUc3U0ZndDY29vNXFIaFBZWDVQNDRDaE4xeVh6ZUxQdkNxT0d5eUpUK1JC?=
 =?utf-8?B?bVdrZ2tML1hyeFU0cW8wZlB2TVFaVWxFOWtpemhmTjJPL1dKVkZRVlZtZFFM?=
 =?utf-8?B?cDV4NXQyam9RNFNweXIwQ24ycVI1bGcwdXVSY3B1U2JBRVBveDd0ZVY4UkNP?=
 =?utf-8?B?TExzVHZPM0pPYVBvVkE3SUZTcjkvb2ZxenFUUDhVUVBKNS9jUkhSb2RISVoz?=
 =?utf-8?B?K1Jta24yRlArL3lQbk9OVVA2RTNuU3YyV0FrYW14bWVjSWtyTVRlWW5WOThW?=
 =?utf-8?B?SUlvQUFFaHF0ZDVielJsbEdSMktJdUYrOWNweVpFWWJ4YlNZeVBVS0VXaVg1?=
 =?utf-8?Q?Ocp1Wm7GoG/WjJ9o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F808B235EBB77048BA587A50979A10CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1a3942-a4e2-48a6-1d2c-08da43a34d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 07:49:48.2359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWhplOWmP/hXUEQwq9B+g1n/yuYG8eeSkUmRmqe5AHf2f5pBjd2P9P20O1lLiU+nbPeUgaMS8PrBIX6iUQebA30nKZaOpWsjg6KxH46wXdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMzEvMDUvMjAyMiAyMDoyMywgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWRkIHN1cHBvcnQgdG8gdGhlIEZQR0EgbWFu
YWdlciBmb3IgcHJvZ3JhbW1pbmcgTWljcm9jaGlwIFBvbGFyZmlyZQ0KPiBGUEdBcyBvdmVyIHNs
YXZlIFNQSSBpbnRlcmZhY2Ugd2l0aCAuZGF0IGZvcm1hdHRlZCBiaXRzcmVhbSBpbWFnZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEl2YW4gQm9ybnlha292IDxpLmJvcm55YWtvdkBtZXRyb3Rlay5y
dT4NCg0KSGV5IEl2YW4sDQpDb3VsZCd2ZSBrZXB0IGF0IGxlYXN0IHRoZSBSLWIgdGFnIGZyb20g
djEzLCBidXQgZWl0aGVyIHdheToNClRlc3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29s
ZXlAbWljcm9jaGlwLmNvbT4NClJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xl
eUBtaWNyb2NoaXAuY29tPg0KDQpJIGRpZCBoYXZlIGFub3RoZXIgbG9vayBhdCBZaWx1bnMgdHdv
IHF1ZXN0aW9ucy4NClRoZSByZWFzb24gZm9yIHRoZSBkb3VibGUgc3RhdHVzIHJlYWQgZWZmZWN0
aXZlbHkgYm9pbHMgZG93bg0KdG8gdGhlIHN5c3RlbSBjb250cm9sbGVyIHBvdGVudGlhbGx5IG5v
dCBoYXZpbmcgaGFkIGVub3VnaA0KdGltZSB0byBwcm9jZXNzIHRoZSBwcmV2aW91cyBjb21tYW5k
L2ZyYW1lIGFuZCB1cGRhdGUgaXRzDQpzdGF0dXMgeWV0Lg0KDQpBbmQgc2VlIGJlbG93IGFib3V0
IHRoZSBtZW1jcHkoKS4uLg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZnBnYS9LY29uZmlnICAgICAg
ICAgfCAgIDkgKw0KPiAgIGRyaXZlcnMvZnBnYS9NYWtlZmlsZSAgICAgICAgfCAgIDEgKw0KPiAg
IGRyaXZlcnMvZnBnYS9taWNyb2NoaXAtc3BpLmMgfCAzODQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDM5NCBpbnNlcnRpb25zKCspDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZnBnYS9taWNyb2NoaXAtc3BpLmMNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvS2NvbmZpZyBiL2RyaXZlcnMvZnBnYS9LY29uZmln
DQo+IGluZGV4IDI2MDI1ZGJhYjM1My4uNzU4MDZlZjVjOWVhIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2ZwZ2EvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2ZwZ2EvS2NvbmZpZw0KPiBAQCAtMjQ4
LDQgKzI0OCwxMyBAQCBjb25maWcgRlBHQV9NR1JfVkVSU0FMX0ZQR0ENCj4gICAgICAgICAgICBj
b25maWd1cmUgdGhlIHByb2dyYW1tYWJsZSBsb2dpYyhQTCkuDQo+IA0KPiAgICAgICAgICAgIFRv
IGNvbXBpbGUgdGhpcyBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZS4NCj4gKw0KPiArY29uZmln
IEZQR0FfTUdSX01JQ1JPQ0hJUF9TUEkNCj4gKyAgICAgICB0cmlzdGF0ZSAiTWljcm9jaGlwIFBv
bGFyZmlyZSBTUEkgRlBHQSBtYW5hZ2VyIg0KPiArICAgICAgIGRlcGVuZHMgb24gU1BJDQo+ICsg
ICAgICAgaGVscA0KPiArICAgICAgICAgRlBHQSBtYW5hZ2VyIGRyaXZlciBzdXBwb3J0IGZvciBN
aWNyb2NoaXAgUG9sYXJmaXJlIEZQR0FzDQo+ICsgICAgICAgICBwcm9ncmFtbWluZyBvdmVyIHNs
YXZlIFNQSSBpbnRlcmZhY2Ugd2l0aCAuZGF0IGZvcm1hdHRlZA0KPiArICAgICAgICAgYml0c3Ry
ZWFtIGltYWdlLg0KPiArDQo+ICAgZW5kaWYgIyBGUEdBDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2ZwZ2EvTWFrZWZpbGUgYi9kcml2ZXJzL2ZwZ2EvTWFrZWZpbGUNCj4gaW5kZXggZTMyYmZhOTBm
OTY4Li41NDI1YTE1ODkyZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZnBnYS9NYWtlZmlsZQ0K
PiArKysgYi9kcml2ZXJzL2ZwZ2EvTWFrZWZpbGUNCj4gQEAgLTE5LDYgKzE5LDcgQEAgb2JqLSQo
Q09ORklHX0ZQR0FfTUdSX1hJTElOWF9TUEkpICAgICArPSB4aWxpbngtc3BpLm8NCj4gICBvYmot
JChDT05GSUdfRlBHQV9NR1JfWllOUV9GUEdBKSAgICAgICArPSB6eW5xLWZwZ2Eubw0KPiAgIG9i
ai0kKENPTkZJR19GUEdBX01HUl9aWU5RTVBfRlBHQSkgICAgICs9IHp5bnFtcC1mcGdhLm8NCj4g
ICBvYmotJChDT05GSUdfRlBHQV9NR1JfVkVSU0FMX0ZQR0EpICAgICArPSB2ZXJzYWwtZnBnYS5v
DQo+ICtvYmotJChDT05GSUdfRlBHQV9NR1JfTUlDUk9DSElQX1NQSSkgICArPSBtaWNyb2NoaXAt
c3BpLm8NCj4gICBvYmotJChDT05GSUdfQUxURVJBX1BSX0lQX0NPUkUpICAgICAgICAgICAgICAg
ICs9IGFsdGVyYS1wci1pcC1jb3JlLm8NCj4gICBvYmotJChDT05GSUdfQUxURVJBX1BSX0lQX0NP
UkVfUExBVCkgICArPSBhbHRlcmEtcHItaXAtY29yZS1wbGF0Lm8NCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jIGIvZHJpdmVycy9mcGdhL21pY3JvY2hpcC1z
cGkuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjQxM2U1
YzM2NGY2OA0KLS0tODwtLS0NCj4gKw0KPiArc3RhdGljIGludCBtcGZfb3BzX3dyaXRlKHN0cnVj
dCBmcGdhX21hbmFnZXIgKm1nciwgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+ICt7
DQo+ICsgICAgICAgdTggdG1wX2J1ZltNUEZfU1BJX0ZSQU1FX1NJWkUgKyAxXSA9IHsgTVBGX1NQ
SV9GUkFNRSwgfTsNCj4gKyAgICAgICBzdHJ1Y3QgbXBmX3ByaXYgKnByaXYgPSBtZ3ItPnByaXY7
DQo+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJm1nci0+ZGV2Ow0KPiArICAgICAgIHN0
cnVjdCBzcGlfZGV2aWNlICpzcGk7DQo+ICsgICAgICAgaW50IHJldCwgaTsNCj4gKw0KPiArICAg
ICAgIGlmIChjb3VudCAlIE1QRl9TUElfRlJBTUVfU0laRSkgew0KPiArICAgICAgICAgICAgICAg
ZGV2X2VycihkZXYsICJCaXRzdHJlYW0gc2l6ZSBpcyBub3QgYSBtdWx0aXBsZSBvZiAlZFxuIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgTVBGX1NQSV9GUkFNRV9TSVpFKTsNCj4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHNw
aSA9IHByaXYtPnNwaTsNCj4gKw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBjb3VudCAvIE1Q
Rl9TUElfRlJBTUVfU0laRTsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICBtZW1jcHkodG1wX2J1
ZiArIDEsIGJ1ZiArIGkgKiBNUEZfU1BJX0ZSQU1FX1NJWkUsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgTVBGX1NQSV9GUkFNRV9TSVpFKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgcmV0ID0g
bXBmX3NwaV93cml0ZShzcGksIHRtcF9idWYsIHNpemVvZih0bXBfYnVmKSk7DQo+ICsgICAgICAg
ICAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIHdyaXRlIGJpdHN0cmVhbSBmcmFtZSAlZC8lenVcbiIsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaSwgY291bnQgLyBNUEZfU1BJX0ZSQU1FX1NJWkUpOw0K
PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAgICAgICAgICAg
fQ0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KDQpJIHdhcyBh
YmxlIHRvIHByb2dyYW0gd2l0aCB0aGUgZm9sbG93aW5nIGRpZmYsIHdoaWNoIGlzIGVmZmVjdGl2
ZWx5DQp0aGUgc2FtZSBhcyB0aGUgb25lIHlvdSBzZW50ICh3aGljaCBhbHNvIHdvcmtlZCBmb3Ig
bWUpOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL21pY3JvY2hpcC1zcGkuYyBiL2RyaXZl
cnMvZnBnYS9taWNyb2NoaXAtc3BpLmMNCmluZGV4IDQxM2U1YzM2NGY2OC4uZmE2MjIwZTgwNTZh
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9mcGdhL21pY3JvY2hpcC1zcGkuYw0KKysrIGIvZHJpdmVy
cy9mcGdhL21pY3JvY2hpcC1zcGkuYw0KQEAgLTI2OCw3ICsyNjgsOCBAQCBzdGF0aWMgaW50IG1w
Zl9vcHNfd3JpdGVfaW5pdChzdHJ1Y3QgZnBnYV9tYW5hZ2VyICptZ3IsDQogIA0KICBzdGF0aWMg
aW50IG1wZl9vcHNfd3JpdGUoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLCBjb25zdCBjaGFyICpi
dWYsIHNpemVfdCBjb3VudCkNCiAgew0KLSAgICAgICB1OCB0bXBfYnVmW01QRl9TUElfRlJBTUVf
U0laRSArIDFdID0geyBNUEZfU1BJX0ZSQU1FLCB9Ow0KKyAgICAgICB1OCBzcGlfZnJhbWVfY29t
bWFuZCA9IE1QRl9TUElfRlJBTUU7DQorICAgICAgIHN0cnVjdCBzcGlfdHJhbnNmZXIgeGZlcnNb
Ml0gPSB7IDAgfTsNCiAgICAgICAgIHN0cnVjdCBtcGZfcHJpdiAqcHJpdiA9IG1nci0+cHJpdjsN
CiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9ICZtZ3ItPmRldjsNCiAgICAgICAgIHN0cnVj
dCBzcGlfZGV2aWNlICpzcGk7DQpAQCAtMjgyLDExICsyODMsMTYgQEAgc3RhdGljIGludCBtcGZf
b3BzX3dyaXRlKHN0cnVjdCBmcGdhX21hbmFnZXIgKm1nciwgY29uc3QgY2hhciAqYnVmLCBzaXpl
X3QgY291bnQNCiAgDQogICAgICAgICBzcGkgPSBwcml2LT5zcGk7DQogIA0KKyAgICAgICB4ZmVy
c1swXS50eF9idWYgPSAmc3BpX2ZyYW1lX2NvbW1hbmQ7DQorICAgICAgIHhmZXJzWzBdLmxlbiA9
IDE7DQorDQogICAgICAgICBmb3IgKGkgPSAwOyBpIDwgY291bnQgLyBNUEZfU1BJX0ZSQU1FX1NJ
WkU7IGkrKykgew0KLSAgICAgICAgICAgICAgIG1lbWNweSh0bXBfYnVmICsgMSwgYnVmICsgaSAq
IE1QRl9TUElfRlJBTUVfU0laRSwNCi0gICAgICAgICAgICAgICAgICAgICAgTVBGX1NQSV9GUkFN
RV9TSVpFKTsNCisgICAgICAgICAgICAgICB4ZmVyc1sxXS50eF9idWYgPSBidWYgKyBpICogTVBG
X1NQSV9GUkFNRV9TSVpFOw0KKyAgICAgICAgICAgICAgIHhmZXJzWzFdLmxlbiA9IE1QRl9TUElf
RlJBTUVfU0laRTsNCiAgDQotICAgICAgICAgICAgICAgcmV0ID0gbXBmX3NwaV93cml0ZShzcGks
IHRtcF9idWYsIHNpemVvZih0bXBfYnVmKSk7DQorICAgICAgICAgICAgICAgcmV0ID0gbXBmX3Bv
bGxfc3RhdHVzKHNwaSwgMCk7DQorICAgICAgICAgICAgICAgaWYgKHJldCA+PSAwKQ0KKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0gc3BpX3N5bmNfdHJhbnNmZXIoc3BpLCB4ZmVycywgMik7
DQogICAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfZXJyKGRldiwgIkZhaWxlZCB0byB3cml0ZSBiaXRzdHJlYW0gZnJhbWUgJWQvJXp1XG4iLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSwgY291bnQgLyBNUEZfU1BJX0ZSQU1F
X1NJWkUpOw0KDQpIYXZlIHlvdSBiZWVuIGFibGUgdG8gbG9vayBhdCBhIHdhdmVmb3JtIG9mIHBy
b2dyYW1taW5nIGxpa2UgdGhpcw0Kb24geW91ciBoYXJkd2FyZT8gT2ZmIHRoZSB0b3Agb2YgbXkg
aGVhZCwgSSB3YXMgd29uZGVyaW5nIGlmIHlvdXINCnNwaSBjb250cm9sbGVyIHJlbGVhc2VzIENT
IGJldHdlZW4gZXZlcnkgeGZlcj8NCk1pbmUgaXMgcGVyZmVjdGx5IGhhcHB5IG5vdCB0byByZWxl
YXNlIGl0IC0gd2hpY2ggaXMgd2h5IEkgbm90aWNlZA0KdGhlIGV4dHJhIGNzX2NoYW5nZSBpbiBt
cGZfcmVhZF9zdGF0dXMoKS4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCg==
