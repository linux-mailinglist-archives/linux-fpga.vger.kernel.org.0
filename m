Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C195A5B21
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 07:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiH3FbV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 01:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH3FbT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 01:31:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CB77EFEC;
        Mon, 29 Aug 2022 22:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adhbXDJ7X4xUo/H1xHA2y1S9JO6aMT95I4x5dMl1bXDRtoOJXthLJKsj71i4pTkqwckZfQMPtwBuCV4teltMFRb0ZnGCUziEZxtks364O+qtx5QaVVDm3QYdb7PVOTmvVlBIfeAkUpajKVG2nEB+3t+s4tyUstb52fnHLTdmnZQfg5xuhPVKs65L8D64j2bYNYIozWQ62jTHCjl+Q7bgna6pJf3IuUruDvtb3sfRuBJrbQ8SDG/Eq+LrfabZKY+KgFdkO7I08HdFlFeJ3xwBMNHCHit1fQw7gVgboZtx/gJsoYrcl420VUlwynmkdzufm7B2BzsFXc49UHdEkcxYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA9g2PSu3uRBsOEkvpfQt7akS4qDTQzs+sG+QSgCNvc=;
 b=E+aOjU1KzmJJc+ojhgul+gmMj/n8Zc0lAPwNa8Bam/6uOD4/1MiV3GyESBsjnLdc6VDvh6UmnGdD/05svgZw1A3QmDphAIQRqkF31ExXo0vM8VHTBiWh/eEefJ1SLo3imAvaUSg014ufvuYI3G37ftONTPnGBu+m2801x2v6VIeYlTDxwwT1lWL0RswttccwnsmaYAAOu4TXmcLX7ZR4CsWGSfFDxG8TUOvHroEL6LQWzkDWuyEr4PcFaYRZ/v3vkgNAcxlXnCEeNa2i2oxgcejJ6rPWHwSmxJ61iNK0b7Vftnfg/95+wGTVQHHY3O651GdiAx4fnJa/iOXgl/TRXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA9g2PSu3uRBsOEkvpfQt7akS4qDTQzs+sG+QSgCNvc=;
 b=sCIqEp3wVyHgtqMvs7kyOOrvTQjqfVNRjvTxmw1rjLPm1Yq0kR6hDIyZSL3n1i6/dnY7DPfQf49216DZ+6BobFECEHEGpj3Bm6H5oyYwop6hnd81tAprQhTpTjiguLO/UcpSVajKAQ7txdsUUr5HSrpkFpCQL8cwfCROrxVX6PU=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 05:31:07 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 05:31:07 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi
 config driver
Thread-Topic: [PATCH 2/4] bindings: fpga: Add binding doc for the zynqmp afi
 config driver
Thread-Index: AQHYt212gajiAi2sRUq5elDhJW3DNK2+A5GAgAjwOpA=
Date:   Tue, 30 Aug 2022 05:31:07 +0000
Message-ID: <DM6PR12MB3993A3DF29033DA21DE72185CD799@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-3-nava.kishore.manne@amd.com>
 <f7c9c8ee-675b-216c-0e2d-28d11890477a@linaro.org>
In-Reply-To: <f7c9c8ee-675b-216c-0e2d-28d11890477a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f72ab489-7abb-404e-8a2a-08da8a48d6cb
x-ms-traffictypediagnostic: IA0PR12MB7625:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJ2n8VA6S5usyiuPZZ36wsKdnPOkDVm2f2M41VnngiP4IsC7852oWvvJfMZ0odTwmdzs8zdksh9G+zeFTEYSTu1c6Rg7XcJi5eGeqiDqWGqxjSt/xIh6Z6+/YjrhuD+OEXnW98OayqeQcVoIVrM/6dexb3KVMj3w9qgMznbX/i5cM3Ju5W1Pdqeg+OM/dJe2CbStPFUrBmz9HogFDhv7A9gHkuf1F58PR/UUex5pTT6+kU6ySl8HN88/gPo1NgGeTmtmvyT3bTSqfZbA9sPTHK+dvIVeA9zlTkoC77a9ga3VqAQv3e6m76R4aMvKqhmLKKDvi1iqs6WjnYLoI68CujfFt/Zk5CnO2Jv1clY4KhlvW8XGLYo4UW+NJ2NVoibWj6JSeQZ2Fl6N9AbK3CEafTNw7cjsAvCEdIAOQj32GIMQCOdo7iDCRD92f7cxvxiIGrw9IYYp8tupTCrHyRmd9M2eobxag2C2XzYGg5RBjdfXM/j8Zbza57wCPRPF0Vtz3Byjs+a4POFdpjqSKtbnE2fLJNQTPnZHjgxkMoj8PpzypP+G3QIzsDEEOe2Af4WbubKYpa4O/WNYbdxOw3VBo0Olr83XEpeEPDZSzEMoqnmUXKW6OCKbeo1JAn7HFACQycbca7NzfSazd2IUWQIzxK6UudbXN54uPWj7MyPwQC6sNYC18rg7hHiwHNczC+RSRSQ7T1sXWZbbHXSVaRfMOtsCeSLedEo5NZgcC+SljUuayWlXdHHeZ18tiU9cPJzPHVNtG5zmi5oSgS5Uz4e9rPMNoi8WhW6Y88UzyL46vBCbbn8EqiwlR6V9+KXhtSTLdICmlyIxC4Zp1AqRTSEideQcp95MhzuNUKmPRMNHE74=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(76116006)(66946007)(66556008)(38100700002)(86362001)(8676002)(66476007)(38070700005)(122000001)(64756008)(41300700001)(6506007)(921005)(7696005)(52536014)(8936002)(66446008)(5660300002)(7416002)(53546011)(26005)(478600001)(9686003)(966005)(2906002)(71200400001)(55016003)(110136005)(83380400001)(33656002)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUxzSDhMTzNZNEVTbm54cGFmdUlzODFoZkRucjkxTU5jQ0l0aUFrWUp1aHp6?=
 =?utf-8?B?UVM2YjRkb00vbFU3Y0o1NUlPS0VsU280ZlVSTUt3Vk9SZUtjSHBzcnNBVjc1?=
 =?utf-8?B?cXR0K0M5NWxHVjVSUUdFbEhJaWh5ZUxTWTN5UXZoN2IwYm5PMnBONFdLaTM2?=
 =?utf-8?B?VjRvdGFISzVrbEZCQlZlSURtcEZHR3RJMXV6Q1dTTTV0bDNlQmdHVHNRWjJ6?=
 =?utf-8?B?WTFGbUVyOWpPY05Oa2lqNHl3c2dBNHJHd3VnS2hrRkFORExhdUJpSkEzQUx1?=
 =?utf-8?B?b3hEamVvd1RQUmdxbm94UjRxaDBzQVlKWC82TnZyK3UrV3I2bU80N3pyMDZz?=
 =?utf-8?B?ejFOMVFyYlNjUmVjVjJEdFltMzcvRXdZT1pXRThpYml2ZTQ5S1RkMkQydHdj?=
 =?utf-8?B?WERsNmVRclkyUmJCT2k2UGEyVXNFVzlVVzREYUdVTGFiaTB6NzJzbGVTUG9z?=
 =?utf-8?B?VEpCa0RuNnAzeE9LZ2MxT3MvUUp6OER6WmVrbW9FRmlubGc0c1pqMlZpUTFE?=
 =?utf-8?B?cjA2bE1jQnZuZkJXYlJEdDVDZXU2Zjd5dEdHSmlTY2k5aHE3S04rSCtrNjNM?=
 =?utf-8?B?TFVoUC9wMlF5Ukg3Qkd4Sk0ySmFXcXRlcHhxd1M0NEVVWkFoY3IydXhNUkhU?=
 =?utf-8?B?M2ErWXdmMjhVaCtGdlNsc2hFbjdLVWcyTFZVREp6eHFKWXEzcVh1TFpKNGFX?=
 =?utf-8?B?eFdLQzNoYkRkZm1VN0w1aUM4a1ZTWDJrRER0akpEaURtN0RUVE43MCtSYm5S?=
 =?utf-8?B?anc2WEptM290ak9VdEJYb1FrUWFmRitxSkY3MmFDTlVoY20wSjdrbitIckFC?=
 =?utf-8?B?ckYyWTJ6cllpOFhSWVN0K2JyVENDelVKRisxeWNUTG1FM3d2SVR3YVpLTEdG?=
 =?utf-8?B?VjM4TkRWTmNzWGZGdVFZNmFoY2JFZ1VyQit4ejMyeFlXVjEvM2hwaitzcW9y?=
 =?utf-8?B?eldKUC9nWW55eHYrYnZNeEhYZFV4cUVQOElOOFM5TGNUSnRhZGxaN1RHSVZw?=
 =?utf-8?B?TGtOZWdEUTh6K2pGQW50eTFiejY5MldjQWlHbmFzdFRvVUhZV0VkWjV3NWIx?=
 =?utf-8?B?Q2IvMHNtYTMwbEhJbVJsMmdUQ1MyM1hzUFB4UFNueHFsdUl6d0M4UnhjVFFu?=
 =?utf-8?B?d1k4S1NaT3pMQmZ4UjNLZ1VRcHU4SmFORmxRSXprNnc5M2lPalloTW81Tnlh?=
 =?utf-8?B?ZjZac3hBQ0o3MCtiYlIvbHhTVW54MGhmcllvUTRIRjhxSnFwTFltVmlrVEJm?=
 =?utf-8?B?SzNHZ2E0QzVZdVBXTmllWVpQdUtKa2ZZMi9iM0JoSVcwb2E4b1J4ZmppQW8z?=
 =?utf-8?B?MGs2UXpuVi9KT3NoUWJpWW5JNzdsM1pGUFZtZTI0R1lEemdwc3Z4WXhJak5Z?=
 =?utf-8?B?RkdtejhCbHREdjZwdDNlQmpjczlGZ2ljbWdzdjhWMHRsVmhjTUNLMGRRenpM?=
 =?utf-8?B?aXpEa0JJbEppVStuQis2Yk02S2FWOUZEeFhHcnpuRU0wdXVDZURpUzFtbXR0?=
 =?utf-8?B?R1FzTFo1SWpqRytJMjFqMW16RVVZZzZaRExjVGRUTzJ5blJGcktMODZ6M2tE?=
 =?utf-8?B?MEhXa3RJanpXVXFxS0wrWTdqMnBKL3krR1pDZmNzTXRJOForNHd3eUc0cDd4?=
 =?utf-8?B?aGQ0aG9MRDQxTkdJY0pIRjZQb2hhZzZ4YjJIUjJpeEt3RzZvR0dhTXFPYVUv?=
 =?utf-8?B?N2JjdmtVMzJnVWJGZjgyczZuenQyRE1BTEN6WXUvYlhKMGptTFdpaDN1Vjlp?=
 =?utf-8?B?WVdNSzhPeFJwUFhhWkUyZU8vK2sxS0dXdTJDNm4yTThJdEVIUG1hSXBVQkJu?=
 =?utf-8?B?OTAvN1dseG0vUnNLOUJZRThSdnE5ZjJUMlZVcm9IMkp0MzJibW0xN3hLc1N0?=
 =?utf-8?B?TE9PNEFiSm9RemZob2xiU3VFcHhvWmZ0UkIyMnBuQU1rMm91YmhNbWRFV2hO?=
 =?utf-8?B?Mi90MFZqYzhoOHFRaTUxNFRhZHlieitka3JkcWVPVEVUd2xIaFZET01leTVu?=
 =?utf-8?B?RUdwOFpIUWljYkR2ZndSd0U1UllUdjlORDdpcGk5cDJjQnVqZ3g3aklXbVhj?=
 =?utf-8?B?UTA3YjA1SmV1RHByNE5OMExWV0UzZWN6RFRxd2tEck43UTM4dXlWeEpJeHpV?=
 =?utf-8?Q?Ak9M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72ab489-7abb-404e-8a2a-08da8a48d6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 05:31:07.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtfroZ2sPiZsuHHKrUBagBX2jJ9OuKJ9AbdCnKbBifKfg5OjMhZAvQMkkwNU8taU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3Qg
MjQsIDIwMjIgNjoyOSBQTQ0KPiBUbzogTWFubmUsIE5hdmEga2lzaG9yZSA8bmF2YS5raXNob3Jl
Lm1hbm5lQGFtZC5jb20+OyBnaXQgKEFNRC1YaWxpbngpDQo+IDxnaXRAYW1kLmNvbT47IHJvYmgr
ZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBtaWNo
YWwuc2ltZWtAeGlsaW54LmNvbTsgbWRmQGtlcm5lbC5vcmc7IGhhby53dUBpbnRlbC5jb207DQo+
IHlpbHVuLnh1QGludGVsLmNvbTsgdHJpeEByZWRoYXQuY29tOyBwLnphYmVsQHBlbmd1dHJvbml4
LmRlOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgcm9uYWsuamFpbkB4aWxpbnguY29t
OyByYWphbi52YWphQHhpbGlueC5jb207DQo+IGFiaHl1ZGF5LmdvZGhhc2FyYUB4aWxpbnguY29t
OyBwaXl1c2gubWVodGFAeGlsaW54LmNvbTsNCj4gbGFrc2htaS5zYWkua3Jpc2huYS5wb3R0aHVy
aUB4aWxpbnguY29tOyBoYXJzaGEuaGFyc2hhQHhpbGlueC5jb207DQo+IGxpbnVzLndhbGxlaWpA
bGluYXJvLm9yZzsgbmF2YS5tYW5uZUB4aWxpbnguY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzRdIGJpbmRpbmdzOiBmcGdhOiBBZGQgYmluZGluZyBkb2MgZm9y
IHRoZSB6eW5xbXAgYWZpDQo+IGNvbmZpZyBkcml2ZXINCj4gDQo+IE9uIDI0LzA4LzIwMjIgMDY6
NTUsIE5hdmEga2lzaG9yZSBNYW5uZSB3cm90ZToNCj4gPiBYaWxpbnggWnlucSBVUysgTVBTb0Mg
cGxhdGZvcm0gY29ubmVjdCB0aGUgUFMgdG8gdGhlIHByb2dyYW1tYWJsZQ0KPiA+IGxvZ2ljKFBM
KSB0aHJvdWdoIHRoZSBBWEkgcG9ydC4gVGhpcyBBWEkgcG9ydCBoZWxwcyB0byBlc3RhYmxpc2gN
Cj4gDQo+IFVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0gKGdpdCBs
b2cgLS1vbmVsaW5lIC0tIC4uLikuDQo+IA0KDQpXaWxsIGZpeCBpbiB2Mi4NCg0KPiA+IHRoZSBk
YXRhIHBhdGggYmV0d2VlbiB0aGUgUFMgYW5kIFBMLiBJbi1vcmRlciB0byBlc3RhYmxpc2ggdGhl
IHByb3Blcg0KPiA+IGNvbW11bmljYXRpb24gZGF0YSBwYXRoIGJldHdlZW4gUFMgYW5kIFBMIHRo
ZSBBWEkgcG9ydCBkYXRhIHBhdGgNCj4gPiBzaG91bGQgYmUgY29uZmlndXJlZCB3aXRoIHRoZSBw
cm9wZXIgQnVzLXdpZHRoIHZhbHVlcy4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgYmlu
ZGluZyBkb2N1bWVudCBmb3IgdGhlIHp5bnFtcCBhZmkgY29uZmlnIGRyaXZlcg0KPiA+IHRvIGhh
bmRsZSB0aGUgQVhJIHBvcnQgYnVzLXdpZHRoIGNvbmZpZ3VyYXRpb25zIGFuZCBQUy1QTCByZXNl
dHMuDQo+IA0KPiBEbyBub3QgdXNlICJUaGlzIGNvbW1pdC9wYXRjaCIuDQo+IGh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE3LjEvc291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vz
cy9zdWINCj4gbWl0dGluZy1wYXRjaGVzLnJzdCNMOTUNCj4gDQoNCldpbGwgZml4IGluIHYyLg0K
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmEua2lzaG9y
ZS5tYW5uZUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvZnBnYS94bG54LHp5
bnFtcC1hZmktZnBnYS55YW1sICAgfCAxMDAgKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4g
PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1hZmkt
ZnBnYS55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1hZmktZnBnYS55YW1sDQo+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1hZmktZnBnYS55
YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZh
YWU0OTUxZTk5MQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHp5bnFtcC1hZmktDQo+IGZwZ2EueWFtbA0KPiA+
IEBAIC0wLDAgKzEsMTAwIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwt
Mi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDog
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZnBnYS94bG54LHp5bnFtcC1hZmktZnBnYS55
YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2Nv
cmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBYaWxpbnggWnlucU1QIEFGSSBpbnRlcmZhY2Ug
TWFuYWdlci4NCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhLmtpc2hvcmUubWFubmVAYW1kLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0
aW9uOiBUaGUgWnlucSBVbHRyYVNjYWxlKyBNUFNvQyBQcm9jZXNzaW5nIFN5c3RlbSBjb3JlDQo+
ID4gK3Byb3ZpZGVzIGFjY2Vzcw0KPiA+ICsgIGZyb20gUEwgbWFzdGVycyB0byBQUyBpbnRlcm5h
bCBwZXJpcGhlcmFscywgYW5kIG1lbW9yeSB0aHJvdWdoIEFYSQ0KPiA+ICtGSUZPDQo+ID4gKyAg
aW50ZXJmYWNlKEFGSSkNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJs
ZToNCj4gPiArICAgIGl0ZW1zOg0KPiANCj4gTm8gaXRlbXMsIHlvdSBoYXZlIG9ubHkgb25lIGl0
ZW0uDQo+IA0KDQpXaWxsIGZpeCBpbiB2Mi4NCg0KPiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAg
ICAgICAgICAtIHhsbngsenlucW1wLWFmaS1mcGdhDQo+ID4gKw0KPiA+ICsgIHJlc2V0czoNCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBBIGxpc3Qgb2YgcGhhbmRsZXMgZm9yIHJl
c2V0cyBsaXN0ZWQgaW4gcmVzZXQtbmFtZXMuDQo+IA0KPiBZb3UgbmVlZCBtYXhJdGVtczo0DQo+
IA0KDQpXaWxsIGZpeCBpbiB2Mi4NCg0KPiA+ICsNCj4gPiArICByZXNldC1uYW1lczoNCj4gPiAr
ICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBwbDAtcnN0DQo+ID4gKyAgICAgIC0gY29u
c3Q6IHBsMS1yc3QNCj4gPiArICAgICAgLSBjb25zdDogcGwyLXJzdA0KPiA+ICsgICAgICAtIGNv
bnN0OiBwbDMtcnN0DQo+ID4gKw0KPiA+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4gPiArICAiXnhs
bngsYWZpZm1bMC02XS1yZC1idXMtd2lkdGgkIjoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBidXMg
d2lkdGggdXNlZCB0byBjb25maWd1cmUgdGhlIGFmaWZtLXJkIGludGVyZmFjZS4NCj4gPiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAg
ZW51bTogWyAzMiwgNjQsIDEyOCBdDQo+ID4gKw0KPiA+ICsgICJeeGxueCxhZmlmbVswLTZdLXdy
LWJ1cy13aWR0aCQiOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IGJ1cyB3aWR0aCB1c2VkIHRvIGNv
bmZpZ3VyZSB0aGUgYWZpZm0td3IgaW50ZXJmYWNlLg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gKyAgICBlbnVtOiBbIDMyLCA2NCwg
MTI4IF0NCj4gPiArDQo+ID4gKyAgIl54bG54LGFmaWZzLXNzWzAtMl0tYnVzLXdpZHRoJCI6DQo+
ID4gKyAgICBkZXNjcmlwdGlvbjogYnVzIHdpZHRoIHVzZWQgdG8gY29uZmlndXJlIHRoZSBhZmlm
cyBpbnRlcmZhY2UuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gPiArICAgIGVudW06IFsgMzIsIDY0LCAxMjggXQ0KPiA+ICsNCj4gPiAr
cmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSB4bG54LGFmaWZtMC1yZC1i
dXMtd2lkdGgNCj4gPiArICAtIHhsbngsYWZpZm0xLXJkLWJ1cy13aWR0aA0KPiA+ICsgIC0geGxu
eCxhZmlmbTItcmQtYnVzLXdpZHRoDQo+ID4gKyAgLSB4bG54LGFmaWZtMy1yZC1idXMtd2lkdGgN
Cj4gPiArICAtIHhsbngsYWZpZm00LXJkLWJ1cy13aWR0aA0KPiA+ICsgIC0geGxueCxhZmlmbTUt
cmQtYnVzLXdpZHRoDQo+ID4gKyAgLSB4bG54LGFmaWZtNi1yZC1idXMtd2lkdGgNCj4gPiArICAt
IHhsbngsYWZpZm0wLXdyLWJ1cy13aWR0aA0KPiA+ICsgIC0geGxueCxhZmlmbTEtd3ItYnVzLXdp
ZHRoDQo+ID4gKyAgLSB4bG54LGFmaWZtMi13ci1idXMtd2lkdGgNCj4gPiArICAtIHhsbngsYWZp
Zm0zLXdyLWJ1cy13aWR0aA0KPiA+ICsgIC0geGxueCxhZmlmbTQtd3ItYnVzLXdpZHRoDQo+ID4g
KyAgLSB4bG54LGFmaWZtNS13ci1idXMtd2lkdGgNCj4gPiArICAtIHhsbngsYWZpZm02LXdyLWJ1
cy13aWR0aA0KPiA+ICsgIC0geGxueCxhZmlmcy1zczAtYnVzLXdpZHRoDQo+ID4gKyAgLSB4bG54
LGFmaWZzLXNzMS1idXMtd2lkdGgNCj4gPiArICAtIHhsbngsYWZpZnMtc3MyLWJ1cy13aWR0aA0K
PiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFt
cGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC94
bG54LXp5bnFtcC1yZXNldHMuaD4NCj4gPiArICAgIHp5bnFtcC1hZmkgew0KPiANCj4gTm9kZSBu
YW1lcyBzaG91bGQgYmUgZ2VuZXJpYy4NCj4gaHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRp
b24ucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLQ0KPiBkZXZpY2V0cmVlLWJhc2lj
cy5odG1sI2dlbmVyaWMtbmFtZXMtcmVjb21tZW5kYXRpb24NCj4gDQoNCldpbGwgZml4IGluIHYy
Lg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
