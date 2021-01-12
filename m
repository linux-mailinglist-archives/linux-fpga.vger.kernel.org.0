Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309B72F29FA
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Jan 2021 09:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392347AbhALI0m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Jan 2021 03:26:42 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25772 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731998AbhALI0l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 Jan 2021 03:26:41 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C8PeL3012808;
        Tue, 12 Jan 2021 03:25:40 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-00128a01.pphosted.com with ESMTP id 35yx29wrsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 03:25:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdq6AOUzIsOBV6E+cLuCcyDClSFYnf3c7sWC2gcT9yq5nT43nRrOYEuBnNRvRa4F2ISVmpkbHfhPGEeH2j0h4a/c/wsuOOuz7leanfQPXnj72HLAtAx5YjoPPV2KOpoJtzWaDe06+jIRfD3GujjUZBMvNK9yrhd45wGrggVlWPpBBbNdhnhmpjKgk2RRLXqt9hDrRnzra7cFsZw9Ki+b+Scuk0PZkJuYQqI6aopAdLoyn3j9EbhcCqzGwgX3TCVmw+xYlxGV7dg9lZf7d2gQTR4wbnPD9bBTHOzCisUf97/XlTi2hS4f7j0xpXyIzBRiXNd3R+oapULBDqp5xZQmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiZ2gfNNvIgiAKjgvNB4yUXrLg979u2VrsCBk+LKZAc=;
 b=i89iNs++t2yNCrdRPABgb10QbToUKFSj8EWA6oefVhsNXi9jYKdBVBBH7HZk4JSii0XiT1qvsXQc1uWGwNI8Q+GP3b1/jg74JVw0ehQBbSN+tGa7Ir0LjruJiNW12nyvaNv80rI2nEI4wC60V6IviPyyrnsTwLE+uOFOmbteexV7OCQn6xkEHnZBvdbGttudHZ6Sy2YNY9QiF2hgBNeXHKcqZx/RzP4mlFVKfQILRrszsIAffhNcoYdFwhIUUt+CoEVKlhvGo3kQu7qzXr3fAaz8CPNeOo7LZUnBamI1rJufMVjqkMFqvOHMcJe6ZLmHIGSBgnt3j+3z2txBGeZgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiZ2gfNNvIgiAKjgvNB4yUXrLg979u2VrsCBk+LKZAc=;
 b=ibo1YLKIhnXS4z8MQpVUUVnpftXUw+E04JCSYxAMJdt7UQ+VJ4+Q5mhY2lTRgx9SafqidhwxIN/Rv8BnB1jDJGKuGmeHDg+eWzJxUoTnhumQBuBMSvb6ef/JNB+AIKeVekOfUFQrIYgxv+jcwFzeBqhBO5s6Q3ooWb4f9GfQLLI=
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DM6PR03MB5049.namprd03.prod.outlook.com (2603:10b6:5:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.7; Tue, 12 Jan
 2021 08:25:37 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::e4d2:490d:16b2:25aa]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::e4d2:490d:16b2:25aa%5]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 08:25:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Tom Rix <trix@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH 1/2] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Thread-Topic: [PATCH 1/2] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Thread-Index: AQHW16cPcn+ol7pDUE6OUYsFhlCFfKoGS5KAgB16W7A=
Date:   Tue, 12 Jan 2021 08:25:37 +0000
Message-ID: <DM6PR03MB5196E1D3541C604A7A958B17F9AA0@DM6PR03MB5196.namprd03.prod.outlook.com>
References: <20201221144224.50814-1-alexandru.ardelean@analog.com>
 <58111fcc-d4c7-4b26-e038-2882b636e17f@redhat.com>
In-Reply-To: <58111fcc-d4c7-4b26-e038-2882b636e17f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVdGeVpHVnNaV0ZjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFqTVRKalpEUXdPUzAxTkdGbUxURXhaV0l0WVRWbU5DMDBNVFUy?=
 =?utf-8?B?TkRVd01EQXdNekJjWVcxbExYUmxjM1JjWXpFeVkyUTBNR0l0TlRSaFppMHhN?=
 =?utf-8?B?V1ZpTFdFMVpqUXROREUxTmpRMU1EQXdNRE13WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STJNakEwSWlCMFBTSXhNekkxTkRreE16VTBNVEl3T1RJd09URWlJR2c5SWpN?=
 =?utf-8?B?Mk1WUk5RMmQ2VWxveFZucHFRV2huUVV0UU1XazROV3BaY3owaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVbFpSRUZCUXpjelNWZEVkazlxVjBGbVdVeFZaaTlXTVVsSFJ6?=
 =?utf-8?B?bG5kRkl2T1ZoVloxbFpSa0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVGWFFYZEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJRVUpCUVVGQmJXeENRMFJSUVVGQlFVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZoVVVKbVFVaE5RVnBSUW1wQlNGVkJZMmRDYkVGR09F?=
 =?utf-8?B?RmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNla0ZHT0VGYVowSm9RVWQzUVdO?=
 =?utf-8?B?M1FteEJSamhCV21kQ2RrRklUVUZoVVVJd1FVZHJRV1JuUW14QlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMFZCV2tGQ2NFRkdPRUZqZDBKc1FVZE5RV1JS?=
 =?utf-8?B?UW5sQlIxVkJXSGRDZDBGSVNVRmlkMEp4UVVkVlFWbDNRakJCU0UxQldIZENN?=
 =?utf-8?B?RUZIYTBGYVVVSjVRVVJGUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsUlFtdEJSMnRCV0hkQ2Vr?=
 =?utf-8?B?RkhWVUZaZDBJeFFVaEpRVnBSUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVo?=
 =?utf-8?B?UlFXTjNRbVpCU0ZGQllWRkNiRUZJU1VGTlowRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSm9RVWhK?=
 =?utf-8?B?UVdGUlFtaEJSamhCV2tGQ2NFRkhUVUZrUVVKd1FVYzRRV0puUW1oQlNFbEJa?=
 =?utf-8?B?VkZDWmtGSVVVRmhVVUpzUVVoSlFVMVJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJt?=
 =?utf-8?B?ZEJRVUZIUlVGalowSndRVWRGUVZoM1FtdEJSMnRCV1hkQ01FRkhhMEZpZDBK?=
 =?utf-8?B?MVFVZEZRV05uUWpWQlJqaEJaRUZDY0VGSFZVRmpaMEY1UVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZE?=
 =?utf-8?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.130.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4809586-deb7-4889-0ce2-08d8b6d3a3c1
x-ms-traffictypediagnostic: DM6PR03MB5049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5049457CBC419425D8F4F5C0F9AA0@DM6PR03MB5049.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRBVw6eczHgL/E1dMP3Di/afq187ntccb1Lp9MI6CSTEy3iyrxlzH9pO6VyGuf+usCN2RlQafIjVWRaRspvBPEJJSkLBGC+Vgma/UJP/pM8vuhdZMKunYjlreY1evnXvpjxOMTsTHyJJF8I/aoOkLLc73xhKGora40bi4fW96b4Ny5AKNfRu3qhU4c8td4cjpJRuzgErNB447D674YNces7c3F8f7JZwTd5hMx8nYzdm4d87GaQI/+6ISb72fZW3KFY/qFdaaQvVPiwH2ZQio254YloTvtsR4Lw/tOu1k0U4nUWU8ATEqk4rso9NJu0cIp2VJMcTrv9G6DEnf1RPnHwvJEIApWR8l+m7HjEC3TtuhC2NLRqqAEdAzon/PUEzKGhkNP7+K+TNsndpVnQ4weXnmBPt7PohMcfMp/hW5wntpNUha9tVGa0Pc/5RuRQTEst931MIejAnArO+UJEtpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(71200400001)(7696005)(33656002)(186003)(6506007)(2906002)(8936002)(8676002)(76116006)(66446008)(64756008)(478600001)(66556008)(26005)(66946007)(5660300002)(966005)(53546011)(9686003)(55016002)(316002)(54906003)(66476007)(107886003)(83380400001)(4326008)(110136005)(52536014)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TW5haGhCTWZaTllsdEFxcDZvTlpMYTVsNzVZUGlDczZiUjNRSUxpaUhHdDJq?=
 =?utf-8?B?cTF3UXVHWTNoQmd5WkREak8weGRJazQ1NHpQRzIrd1Zxc3AwOUVWM3p4VmpJ?=
 =?utf-8?B?WW9rcDhLV3Z2cVpJQkJ5TTlEc3NqM1RnSCtpL1h1dGJGNUsyRno1eFZHSi9x?=
 =?utf-8?B?bW53ZHhXU0RXZ3hwUFdiSHZCMnVvNExzNVZYNXdhZjFHN1o0UklaMkV1ajB1?=
 =?utf-8?B?SGdCem5wMmp4MStBVi91TVFpZEYrRWJUY1JnaGhvR0p2NnM4bFVRWVIyclFr?=
 =?utf-8?B?M3RLUmxRSmN4WGNOb0plSHUwOU9pKzRvV2R6dHlrb1p0RFdrYnYxcFpuVGRE?=
 =?utf-8?B?WVZZNnhyaTV4QkZsQWtpdTU4NWZJUjBUeWZjeXZWTElETGFnZXJ4cWUvQllZ?=
 =?utf-8?B?ZXo5akQ5R1BFN3Ivd0VDVlQvNXhlZ2hEQUVvd3JSRTdwRnFiUE5ZNnIwRk14?=
 =?utf-8?B?Nm1qK0NoUi85ZjJ5V3dKMHNwNFVQdVdZSjFNVW9HT1NVbTR2L1owT3pjTzEw?=
 =?utf-8?B?aUJpV1l2TGNwRXZRUitZU3pTaWt6RW9NMjVwYkwvemw0b3YrbWl0dm9ERkpH?=
 =?utf-8?B?a0VxYW1GMFlMVThmRmlEakNXMWZ0alJJMk5zSUhtcVFMTXk3Z2kxMUpDb0JF?=
 =?utf-8?B?T2I0TWptV2NBT01qcGJLbGZ5UkpSeEZvWDJpaFhCMXZPblpSbm5kTjczdnFp?=
 =?utf-8?B?OVRnYjJMRnY3cW1EQ0J5MWlaT0JkblRDd2d0cysxbXJBeXZMQWF2MEk4Nzc2?=
 =?utf-8?B?cUhkV0czcW5uWjlsQ0doT1JQWmE4aDJ6Z21SRHYzY2o2UzNyK1BLdGQ2eWdq?=
 =?utf-8?B?NlNPV25WMGlVSFRGN1ZoQTdJcTRBTXJXbForRjBpdkJIZlYwVHc5NUZXNEdF?=
 =?utf-8?B?Tk9HU2wrdnVYNENJVlpvM29nUXdPaklKSFlvVzNlS2VOTCtWTDR0RjhYUW9u?=
 =?utf-8?B?YmJuNHh3MGY5U3plcmdQNzRiOW96MEtqRERWMWFCMW9sWG1BZ0JiRDBnMDN0?=
 =?utf-8?B?OTZTcStIYkRJUit4OHA3UTN2cVVrZk5qL3U2SHczclB3WlRNRzBQellKN3dz?=
 =?utf-8?B?andiVzZGZFV0ZzN0bzg5SkFOZjV2UWcya3ZSZ2lZditTS0pCQmlnSWVlTnFU?=
 =?utf-8?B?UUtaUWRiY21FdTZrMFVUcjZBVFZNd0lBblp0Q2RwTk96MkpOMXdQRVJqYXor?=
 =?utf-8?B?NzE3L1hmai9WWWREcFB5YjVvZzcxdkc4RFpXdkZKSCs2NGpPUnIyU1E5dDJl?=
 =?utf-8?B?bWp6WnhoR0tYSitQcTJjdjZhRHBvSjF3WG15K3ZuRDBTcGlqRXl2VndjVlRz?=
 =?utf-8?Q?Kz6f8gi5Zqd50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4809586-deb7-4889-0ce2-08d8b6d3a3c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 08:25:37.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZVBVJJ6YDkew+KsJ0YXxHj6HuCxwyjkqKsd+WRdyUX5jEv9njrhs/SnaE43jBT7b+CEzu5Qe30JqdSAcruNT5BZllZOKX+rfqaKBChdbOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5049
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_03:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120046
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjQsIDIwMjAgNDowMyBQTQ0K
PiBUbzogQXJkZWxlYW4sIEFsZXhhbmRydSA8YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+
OyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG10dXJxdWV0dGVAYmF5bGli
cmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxhcnNAbWV0
YWZvby5kZTsgbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IG1kZkBrZXJuZWwub3JnOyBCb2dk
YW4sDQo+IERyYWdvcyA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29tPjsgTWF0aGlhcyBUYXVzZW4N
Cj4gPG10YUBnb21zcGFjZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBjbGs6IGF4
aS1jbGtnZW46IGFkZCBzdXBwb3J0IGZvciBaeW5xTVAgKFVsdHJhU2NhbGUpDQo+IA0KPiBbRXh0
ZXJuYWxdDQo+IA0KPiANCj4gT24gMTIvMjEvMjAgNjo0MiBBTSwgQWxleGFuZHJ1IEFyZGVsZWFu
IHdyb3RlOg0KPiA+IEZyb206IERyYWdvcyBCb2dkYW4gPGRyYWdvcy5ib2dkYW5AYW5hbG9nLmNv
bT4NCj4gPg0KPiA+IFRoaXMgSVAgY29yZSBhbHNvIHdvcmtzIGFuZCBpcyBzdXBwb3J0ZWQgb24g
dGhlIFhpbGlueCBaeW5xTVANCj4gPiAoVWx0cmFTY2FsZSkgRlBHQSBib2FyZHMuDQo+ID4gVGhp
cyBwYXRjaCBlbmFibGVzIHRoZSBkcml2ZXIgdG8gYmUgYXZhaWxhYmxlIG9uIHRoZXNlIHBsYXRm
b3JtcyBhcyB3ZWxsLg0KPiA+DQo+ID4gU2luY2UgYXhpLWNsa2dlbiBpcyBub3cgc3VwcG9ydGVk
IG9uIFpZTlFNUCwgd2UgbmVlZCB0byBtYWtlIHN1cmUgdGhlDQo+ID4gbWF4L21pbiBmcmVxdWVu
Y2llcyBvZiB0aGUgUEZEIGFuZCBWQ08gYXJlIHJlc3BlY3RlZC4NCj4gPg0KPiA+IFRoaXMgY2hh
bmdlIGFkZHMgdHdvIG5ldyBjb21wYXRpYmxlIHN0cmluZ3MgdG8gc2VsZWN0IGxpbWl0cyBmb3Ig
WnlucQ0KPiA+IG9yIFp5bnFNUCBmcm9tIHRoZSBkZXZpY2UgZGF0YSAoaW4gdGhlIE9GIHRhYmxl
KS4gVGhlIG9sZCBjb21wYXRpYmxlDQo+ID4gc3RyaW5nIChpLmUuIGFkaSxheGktY2xrZ2VuLTIu
MDAuYSkgaXMgdGhlIHNhbWUgYXMNCj4gPiBhZGksenlucS1heGktY2xrZ2VuLTIuMDAuYSwgc2lu
Y2UgdGhlIG9yaWdpbmFsIHZlcnNpb24gb2YgdGhpcyBkcml2ZXINCj4gPiB3YXMgZGVzaWduZWQg
b24gdG9wIG9mIHRoYXQgcGxhdGZvcm0uDQo+ID4NCg0KQXBvbG9naWVzIGZvciB0aGUgbGF0ZSBy
ZXBseSBvbiB0aGlzLCB0aGlzIGxvb2tzIGxpa2UgaXQgd2VudCB0byBzb21lIGZvbGRlciBpbiBt
eSBpbmJveCBhbmQgSSBmb3Jnb3QgYWJvdXQgaXQuDQpBbmQgSGFwcHkgTmV3IFllYXIgOikNCg0K
PiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBCb2dkYW4gPGRyYWdvcy5ib2dkYW5AYW5hbG9nLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXRoaWFzIFRhdXNlbiA8bXRhQGdvbXNwYWNlLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVh
bkBhbmFsb2cuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gVGhpcyBpcyBhIHJlLXNwaW4gb2YgYW4g
b2xkZXIgc2VyaWVzLg0KPiA+IEl0IG5lZWRlZCB0byB3YWl0IGEgdHh0IC0+IHlhbWwgZHQgY29u
dmVyc2lvbjoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4DQo+ID4gLWNsay9wYXRjaC8yMDIwMTAxMzE0MzQy
MS44NDE4OC0xLWFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tL19fOyEhQQ0KPiA+IDNOaThD
UzB5Mlkhc1BuTjdmOWlXamhHa2pJLUd1OFJUbzczZ1ZEVjZ4MC01bTQyUHUya1p3dlZiSE4tDQo+
IHBaekVhRnFUckRZDQo+ID4gaVBQRExkVmMtd2ckDQo+ID4NCj4gPiBJdCdzIDIgcGF0Y2hlcyBz
cXVhc2hlZCBpbnRvIG9uZToNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4DQo+ID4gLWNsay9wYXRjaC8yMDIw
MDkyOTE0NDQxNy44OTgxNi0xMi1hbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbS9fXzshIQ0K
PiA+IEEzTmk4Q1MweTJZIXNQbk43ZjlpV2poR2tqSS1HdThSVG83M2dWRFY2eDAtNW00MlB1Mmta
d3ZWYkhOLQ0KPiBwWnpFYUZxVHJEDQo+ID4gWWlQUEFrd3pidU1BJA0KPiA+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgNCj4gPiAtY2xrL3BhdGNoLzIwMjAwOTI5MTQ0NDE3Ljg5ODE2LTE0LWFsZXhhbmRydS5hcmRl
bGVhbkBhbmFsb2cuY29tL19fOyEhDQo+ID4gQTNOaThDUzB5Mlkhc1BuTjdmOWlXamhHa2pJLUd1
OFJUbzczZ1ZEVjZ4MC01bTQyUHUya1p3dlZiSE4tDQo+IHBaekVhRnFUckQNCj4gPiBZaVBQQ2FE
NlFYZlEkDQo+ID4NCj4gPiBUaGUgc2VyaWVzIGZyb20gd2hlcmUgYWxsIHRoaXMgc3RhcnRlZCBp
czoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtY2xrLzIwMjAwOTI5DQo+ID4gMTQ0NDE3Ljg5ODE2LTEtDQo+IGFsZXhhbmRydS5h
cmRlbGVhbkBhbmFsb2cuY29tL19fOyEhQTNOaThDUzB5Mlkhc1BuTjdmOWkNCj4gPiBXamhHa2pJ
LUd1OFJUbzczZ1ZEVjZ4MC01bTQyUHUya1p3dlZiSE4tcFp6RWFGcVRyRFlpUFBBanV6NG9IZyQN
Cj4gPg0KPiA+IFdlbGwsIHY0IHdhcyB0aGUgcG9pbnQgd2hlcmUgSSBkZWNpZGVkIHRvIHNwbGl0
IHRoaXMgaW50byBzbWFsbGVyDQo+ID4gc2VyaWVzLCBhbmQgYWxzbyBkbyB0aGUgY29udmVyc2lv
biBvZiB0aGUgYmluZGluZyB0byB5YW1sLg0KPiA+DQo+ID4gIGRyaXZlcnMvY2xrL0tjb25maWcg
ICAgICAgICAgfCAgMiArLQ0KPiA+ICBkcml2ZXJzL2Nsay9jbGstYXhpLWNsa2dlbi5jIHwgMTUg
KysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL0tjb25maWcg
Yi9kcml2ZXJzL2Nsay9LY29uZmlnIGluZGV4DQo+ID4gODU4NTZjZmY1MDZjLi4yNTIzMzNlNTg1
ZTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZl
cnMvY2xrL0tjb25maWcNCj4gPiBAQCAtMjQ3LDcgKzI0Nyw3IEBAIGNvbmZpZyBDTEtfVFdMNjA0
MA0KPiA+DQo+ID4gIGNvbmZpZyBDT01NT05fQ0xLX0FYSV9DTEtHRU4NCj4gPiAgCXRyaXN0YXRl
ICJBWEkgY2xrZ2VuIGRyaXZlciINCj4gPiAtCWRlcGVuZHMgb24gQVJDSF9aWU5RIHx8IE1JQ1JP
QkxBWkUgfHwgQ09NUElMRV9URVNUDQo+ID4gKwlkZXBlbmRzIG9uIEFSQ0hfWllOUSB8fCBBUkNI
X1pZTlFNUCB8fCBNSUNST0JMQVpFIHx8DQo+IENPTVBJTEVfVEVTVA0KPiA+ICAJaGVscA0KPiA+
ICAJICBTdXBwb3J0IGZvciB0aGUgQW5hbG9nIERldmljZXMgYXhpLWNsa2dlbiBwY29yZSBjbG9j
ayBnZW5lcmF0b3IgZm9yDQo+IFhpbGlueA0KPiA+ICAJICBGUEdBcy4gSXQgaXMgY29tbW9ubHkg
dXNlZCBpbiBBbmFsb2cgRGV2aWNlcycgcmVmZXJlbmNlIGRlc2lnbnMuDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xrL2Nsay1heGktY2xrZ2VuLmMNCj4gPiBiL2RyaXZlcnMvY2xrL2Nsay1h
eGktY2xrZ2VuLmMgaW5kZXggYWQ4NmUwMzFiYTNlLi5hNDEzYzEzMzM0ZmYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9jbGsvY2xrLWF4aS1jbGtnZW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xr
L2Nsay1heGktY2xrZ2VuLmMNCj4gPiBAQCAtMTA4LDYgKzEwOCwxMyBAQCBzdGF0aWMgdWludDMy
X3QgYXhpX2Nsa2dlbl9sb29rdXBfbG9jayh1bnNpZ25lZCBpbnQNCj4gbSkNCj4gPiAgCXJldHVy
biAweDFmMWYwMGZhOw0KPiA+ICB9DQo+ID4NCj4gDQo+IENvdWxkIHNvbWV0aGluZyBsaWtlDQo+
IA0KPiAjaWZkZWYgQVJDSF9aWU5RTVANCg0KU28sIHdlIGRlY2lkZWQgbm90IHRvIGRvIHRoaXMg
aW4gYW4gb2xkZXIgZGlzY3Vzc2lvbjoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWNs
ay8yMDIwMDkyOTE1MzA0MC5HQTExNDA2N0BhcmNoYm9vay8NCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWNsay8yMDIwMDkzMDE3MTYwNy5HQTEyMTQyMEBhcmNoYm9vay8NCg0KQmVjYXVz
ZSwgdGhlc2UgZHJpdmVycyBzaG91bGQgYWxzbyBiZSB1c2FibGUgaW4gY2FzZXMgd2hlcmUgYSBa
eW5xTVAgb3IgWnlucSBkZXZpY2UgY2FuIGJlIHBsdWdnZWQgaW4gdmlhIFBDSWUgb24gYSBob3N0
IGRldmljZS4NClRoaW5raW5nIGFib3V0IGl0IG5vdywgSSB0aGluayBJIHNob3VsZCByZW1vdmUg
dGhlICJkZXBlbmRzIG9uIEFSQ0hfWllOUSB8fCBBUkNIX1pZTlFNUCIgbGltaXRhdGlvbi4NCg0K
PiANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBheGlfY2xrZ2VuX2xpbWl0cyBheGlfY2xrZ2Vu
X3p5bnFtcF9kZWZhdWx0X2xpbWl0cyA9IHsNCj4gPiArCS5mcGZkX21pbiA9IDEwMDAwLA0KPiA+
ICsJLmZwZmRfbWF4ID0gNDUwMDAwLA0KPiA+ICsJLmZ2Y29fbWluID0gODAwMDAwLA0KPiA+ICsJ
LmZ2Y29fbWF4ID0gMTYwMDAwMCwNCj4gPiArfTsNCj4gDQo+ICNlbmRpZg0KPiANCj4gYmUgYWRk
ZWQgaGVyZSBhbmQgc2ltaWxhciBwbGFjZXMgdG8gbGltaXQgdW51c2VkIGNvZGUgPw0KPiANCj4g
PiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXhpX2Nsa2dlbl9saW1pdHMgYXhpX2Nsa2dl
bl96eW5xX2RlZmF1bHRfbGltaXRzID0gew0KPiA+ICAJLmZwZmRfbWluID0gMTAwMDAsDQo+ID4g
IAkuZnBmZF9tYXggPSAzMDAwMDAsDQo+ID4gQEAgLTU2MCw2ICs1NjcsMTQgQEAgc3RhdGljIGlu
dCBheGlfY2xrZ2VuX3JlbW92ZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpICB9
DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXhpX2Nsa2dlbl9p
ZHNbXSA9IHsNCj4gPiArCXsNCj4gPiArCQkuY29tcGF0aWJsZSA9ICJhZGksenlucW1wLWF4aS1j
bGtnZW4tMi4wMC5hIiwNCj4gPiArCQkuZGF0YSA9ICZheGlfY2xrZ2VuX3p5bnFtcF9kZWZhdWx0
X2xpbWl0cywNCj4gPiArCX0sDQo+ID4gKwl7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAiYWRpLHp5
bnEtYXhpLWNsa2dlbi0yLjAwLmEiLA0KPiA+ICsJCS5kYXRhID0gJmF4aV9jbGtnZW5fenlucV9k
ZWZhdWx0X2xpbWl0cywNCj4gPiArCX0sDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgenlucW1wIEFO
RCB6eW5xIGFyZSBiZWluZyBhZGRlZC4NCj4gDQo+IElzIHRoaXMgYSBtaXN0YWtlID8NCg0KVGhl
IG9yaWdpbmFsIGRyaXZlciBzdXBwb3J0ZWQgb25seSBaeW5xICYgTWljcm9ibGF6ZS4NCkkga2Vl
cCBmb3JnZXR0aW5nIGFib3V0IE1pY3JvYmxhemUsIGJlY2F1c2UgaXQncyBvbmUgb2YgdGhvc2Ug
dGFyZ2V0LWRldmljZXMgd2hpY2ggYXJlbid0IHRoYXQgcG9wdWxhciBjb21wYXJlZCB0byBaeW5x
L1p5bnFNUCBbYmVjYXVzZSBvZiB0aGVpciBsb3dlciBzcGVlZHNdOyB0aG91Z2ggdGhleSBkbyBw
b3AtdXAuDQpJIHRob3VnaHQgSSdkIGFkZCBhbiBleHBsaWNpdCBleHRyYSBjb21wYXRpYmxlIHN0
cmluZyBmb3IgWnlucSB0byBiZSBhYmxlIHRvIGRpZmZlcmVudGlhdGUgaXQgW2V4cGxpY2l0bHld
LCBpbiB0aGUgZGV2aWNlIHRyZWUuDQpCdXQgSSB0aGluaywgaXQgY291bGQgbWFrZSBzZW5zZSB0
byBqdXN0IGFkZCB0aGUgenlucW1wIGNvbXBhdCBzdHJpbmcgZm9yIG5vdy4gDQoNCldpbGwgZml4
IG15IGluYm94IGZpbHRlcnMgZmlyc3QgYW5kIHJlLXNwaW4uDQoNClRoYW5rcw0KQWxleA0KDQo+
IA0KPiBUb20NCj4gDQo+ID4gIAl7DQo+ID4gIAkJLmNvbXBhdGlibGUgPSAiYWRpLGF4aS1jbGtn
ZW4tMi4wMC5hIiwNCj4gPiAgCQkuZGF0YSA9ICZheGlfY2xrZ2VuX3p5bnFfZGVmYXVsdF9saW1p
dHMsDQoNCg==
