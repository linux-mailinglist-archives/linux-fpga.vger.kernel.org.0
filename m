Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2F6A024B
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Feb 2023 06:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBWFMG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Feb 2023 00:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWFMF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Feb 2023 00:12:05 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D53B852;
        Wed, 22 Feb 2023 21:12:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UskwVBECsHxOjyp+6ZE+x+63Bd8hdWIZNK6oOhdZKj6S6zjb19AOuRpLmtnQXKPTcg0FoYS07H9loc+4x/V0a3daoj6go0CJDhcYpgrFJgr/YncmEhoenptrLMXqwBCI6iz/GDxldl0/eRgOEj9CFPS2hevY7dqUCpJKq+ECylrMkIvlS9BF8XcTNbcnGReOvWBPPyOL9uRPFs3bV8LC1eIGuRRrdkJ0J8s7yEtiEhew9D4vFSEipUghImTBTp+Yz6J1qvjltaY+jQOpRBRbT5DnXS3kMBX37uppk3guSYFr3zUAoifAMNcJUtTWiNsBdLrZFDmh0PEy8ktSZWKduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E6/BWAG5+r4QftHICMwOsjYIfs/aGJb17wv6yn+Tjc=;
 b=kogMOapP7vNJGWyBEcTNkSanHz9D+qclTTdnCSxxtwdgxeRq0aAXatm0nWAGuROZmz9D4bSWk8K14Vjwfl0vtIVvKIninxD3p0R4y9PJ0bSZFlpsl+ClqWuZFwhvxqZFJ7e9zDHAjR/zin/z9V8fSNnH3jGjCXLPQH5npyyjrumU3K6fMZWQRfpf4W8HuFD2RqJcQ2UdXuVOC5WL7tCgJtASF3uTbbc3gI6KK1MnxPlILb9UkyW71M/4VE0pCbEiDLoDS8tvOaNUBPldfIVIt2HfC1ghuT9Abacs26aEH7hqqFqsBMl/Lyw+wiZYxdXug842h+6yzxIeOLrYQiV+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E6/BWAG5+r4QftHICMwOsjYIfs/aGJb17wv6yn+Tjc=;
 b=RQC2JxKr6AJn1IWTGe7/vRg/Nx8zF889jDSiUvQ8OUAqPHo5CrLHpQnu6PDSGnGBgzyAMOuvyLJVrchvDiJktYIC82FqzxVcyXeiAi0sjcJOY7Nk5zx38h4A6o9Xmg+aiU6wHu40B+1uKC6SJvMihnLFvloORbzIu76tK32nf5U=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 05:12:00 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::ff48:ed63:20ff:ec57]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::ff48:ed63:20ff:ec57%3]) with mapi id 15.20.6111.021; Thu, 23 Feb 2023
 05:12:00 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: fpga: xilinx-pr-decoupler: convert
 bindings to json-schema
Thread-Topic: [PATCH v2] dt-bindings: fpga: xilinx-pr-decoupler: convert
 bindings to json-schema
Thread-Index: AQHZReqxRj8KaksnEUauiroqL3rRM67asvuAgAFJRhA=
Date:   Thu, 23 Feb 2023 05:12:00 +0000
Message-ID: <DM6PR12MB39930B2BC65200510162EF6BCDAB9@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20230221115012.3468798-1-nava.kishore.manne@amd.com>
 <4ce186aa-2cf3-a36c-a5c5-923029b12a29@linaro.org>
In-Reply-To: <4ce186aa-2cf3-a36c-a5c5-923029b12a29@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|CH2PR12MB4859:EE_
x-ms-office365-filtering-correlation-id: 7adb7240-d373-46fd-56f3-08db155c7e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzF0scjlLjhZx6D9J2k5BaYhA9v/WrOU7pdXOAnNyphzNH2PrvLI5nTt/CM93Pqn3BhcxcHNnx/7nSlM3jrKJNzZKRorQHARzvwesMRh6RfU/aOg0eMylGClHybLVfAl4pRfUXnK9MJiB0DnddtU623EddjgAlcDIGDf46v2ZqMlhuKL/l0yjhHMW4dG+rsHX3bzFqbfcX5j877z3gavTbq5n7kHiIHArJJjcOKXnTOm23WsSzKfuRx+MFOS9o0/F+cMqAddm1kyzPXjmPA5gIbPgwl9nwvYRvJPlEvakWco7X1AWkrsK3k5jsoWYSUVLCfTcKWkytldXo9/Um36iIbtCAiXG7DjRntXeXd2DYU+PPu5MkWjlw8aM4B2UbnEHkm87Z3dn7MzgMlos0O971zH4+R3iz5n7p1MZsExS1QD7lkC1h786BXZfHrHqfC4PZOK2r7rGvQjkm28pU28VFKTxX6KfczAAnQaOAkCv/cdmqccusyNyr3EyYnKVFqe/q9eF5UrxuU/oh1yqz1BKRKhe/PRS7eNQJMAC6i5HTkmEmS/vLFiuZVtAEHJbPXMWjjUAmvsB2GnfA9t/fzzoa3VCJXN2nXdj7KjxMDMrDCykuRrkSKXdOcn1h68hZdjSzgwW6nabxOeb5AVhtzzR/Xb4inSFsOEH939jRjgkV24EYYjFd5pL/a2eXRkLd1xl7R9xy8TnPR8v+fx0JkKS/kyqmun+1pdYiA9MG7Dmy5Ny+3L58K/jsPyWekAMNVe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199018)(110136005)(83380400001)(478600001)(71200400001)(2906002)(5660300002)(9686003)(7416002)(86362001)(41300700001)(966005)(52536014)(8936002)(33656002)(7696005)(53546011)(122000001)(38100700002)(26005)(186003)(921005)(38070700005)(6506007)(66946007)(64756008)(66476007)(316002)(66446008)(8676002)(66556008)(76116006)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzNJR2hxYmVNNkY0Sll3NmpWVmlMRjllK3pKRHBQcWI0RUNKU0VvOTNWZmJs?=
 =?utf-8?B?b1VoUFFKOU1sZWpyRkR0UXlsNHZNbEI2WmhBb2ZHb3ZjU0RyTDFaQUFxVG5o?=
 =?utf-8?B?Ui9MQWpEZHhJN085WGt5N0hDZVF1YUlyc2hHVlhsdG1tazY2L25tcnhsKzZj?=
 =?utf-8?B?NnljSnNVQVV5cGQzbng5OWRGTElIQk9WSjVLRnJoQnhiMkZrVzVTZ1lUVlBo?=
 =?utf-8?B?cEtnbDNZbnpUMFUrdit3STJBeHlicnhaWUkvdW5RUUFSYmpnbk83R0NsVzNM?=
 =?utf-8?B?V0RYRThrWUlMOEUwZUdsaDBFR3ZodUpIVllzRmhGK3FIcFJpWVgzYmd4UjdJ?=
 =?utf-8?B?dDZnT1owMEN3azBqV3pZamszaGFmUlRaTzhmT1pwaW95b0Y3TzEyZGRUMDd6?=
 =?utf-8?B?MkhENXIyS1ZlWGtJLzdQY0svN2F3bmpMelRlNVZwV1pBNHlNU3c3WGVUQXBu?=
 =?utf-8?B?cFpMRDZaRXY3cDY4b0xwdDF5WWpMdk5ib3ZiS3pSMXh5WThkbEJMR25FR3Bo?=
 =?utf-8?B?TitWVDMweE9wQkI0aU9wN3hDNlk0c1NhSUJiQXY0TkRyVWV4dGpsQTV6UmNk?=
 =?utf-8?B?RlAySUVOOEpFK2s3eUEwMVB2RThoYURzSWZsMlR2QUJYdVhCRE9RTmhabEl2?=
 =?utf-8?B?QUk2blRVa1JuWitEelYrM1ZlbjQ0aDZJdUlGV1FSbEc5MWs0Zkw2aGlXZFVo?=
 =?utf-8?B?ZWdTZDRnbElTWXE0YVFzd2V1YXp3SVJEd1hCT09QNkRNc2g4cmg5N2MyRVNK?=
 =?utf-8?B?VXNBNGFsV1FueTdaOGNLS09tVXl4dWVuZFlBVjd6S0x0K284dGIvQXluUStV?=
 =?utf-8?B?TkhQcEw4KzJLL1hJazBjekg5OXJUZU8xbENEdjU4ZGRROEFteERWaExiYnk5?=
 =?utf-8?B?aWVBWm91VDZRT2VKaGNhbENwbTR2Q0pIMi9GOUxUdDcrb0FWeEFuTlkwSUQw?=
 =?utf-8?B?UHJidkxQMnR6a0F5Y1kzeWpBeFI2WmJVTU1XYjFiNG5tV1lpKy8yMTNidUdS?=
 =?utf-8?B?dng3WWErSEErc1BodWlvWlkzanF1TnFmaUJxMHVHK3NpMWxNMXUxT0h5bFgy?=
 =?utf-8?B?UVl2Qkd6UFJEYklDY2dlQXhwTGRRQytKaS9tc2JTODNlL0o5VmZ2VkV3cTNi?=
 =?utf-8?B?TkprT1FKMXMyVjZ5OExFYzk1VUhsRml4VUZaQUM5U0ZNU1dGNENOa2hxR3VE?=
 =?utf-8?B?MC8vRGJIbkZCYks5U1psMmN1VFR6clNSRzVZSEFSNGQyeE15ckZZcXU0M0Fo?=
 =?utf-8?B?SzVqYThWQlg0dThqczl6S1U0WnYzdkNxMi8rcnhlMnpDcldWT1M0UnVJU09I?=
 =?utf-8?B?MXRtSmVwalliZm9rWnduR0lkU3J3M01nNk9YVHVncDJlVXFYYmtGRlZWSGdP?=
 =?utf-8?B?QjlqVGY5VjJibEFQS1FVbng3Vk51RHdUTXJlaXRnOXdEOCt6RCtwNWFYM3lF?=
 =?utf-8?B?M1JFUXRSWkZxVWs2RjFzRFdMMWtuOEJDL0NaY1J4NlVFK1UzcDRyQ3FVZC90?=
 =?utf-8?B?ZzdvV1N6cW44dmNqQjZTSnpvZ2drQnJZMWNxU0VqK2h6OEpRWEZna0UrMERl?=
 =?utf-8?B?dXZFNkFNUWxoQ2JCM0QvbnZJQU5UUVc2TXVUWVYyQVJkSTVxbTk0MllLbWNr?=
 =?utf-8?B?eTRsQU15S2NRb2poTUpSNzFXMkZSRE1xdHlvN01JQUdkVzEyR0lsenViUXpO?=
 =?utf-8?B?bzVVMVhtRmVud1ZqbFNNYUMxWEx3eUJhSitEODR6MEMzK2w1bmhBVFNJUFFS?=
 =?utf-8?B?MXRjanl2dnhhN2I3cEhMS2o4VTdyN2o3NVI0WXhON1lGdWZuVi9rYlNRNUlL?=
 =?utf-8?B?ZUJzbnNQUFlCOGd0Zy9SZzEwYnJuNWZnYjIwUlRMMytiay9wTC9ONFBVZ0tz?=
 =?utf-8?B?WXdXc1VZQmtGS0YybHRoenZxSldvNndZdjZjbktMK3Q1dHF2WFZ2UVNJdVg3?=
 =?utf-8?B?aU1pL3JOV2NsSVZVSXVCMUttTmhhSlZuSk5JUEsxaDlvZVFKNm1TcTVRcTFm?=
 =?utf-8?B?VkdvZVI2Z1dxenE3K3A1amgybGptU05qbEg4VEpDZS9TNWNyNjBrMzY3Q0Vm?=
 =?utf-8?B?YktCcFdOL05CTnUvTW1wNXNSVkkzSW80YlU0Qjh1STZuUHRpaHUvZTV2TXV6?=
 =?utf-8?Q?G648=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb7240-d373-46fd-56f3-08db155c7e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 05:12:00.4555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbnIwMhNTBsZrxu4yeKjKqJtgDW49q2SP3mZsEDi+hZKFxeIndxJpfFPYoJUEc7g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQoJVGhhbmtzIGZvciBwcm92aWRpbmcgdGhlIHJldmlldyBjb21tZW50
cy4NClBsZWFzZSBmaW5kIG15IHJlc3BvbnNlIGlubGluZSBiZWxvdy4NCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yu
a296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjIsIDIw
MjMgMjo1NCBQTQ0KPiBUbzogTWFubmUsIE5hdmEga2lzaG9yZSA8bmF2YS5raXNob3JlLm1hbm5l
QGFtZC5jb20+Ow0KPiBtZGZAa2VybmVsLm9yZzsgaGFvLnd1QGludGVsLmNvbTsgeWlsdW4ueHVA
aW50ZWwuY29tOyB0cml4QHJlZGhhdC5jb207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsg
bGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGR0LWJpbmRpbmdzOiBm
cGdhOiB4aWxpbngtcHItZGVjb3VwbGVyOiBjb252ZXJ0DQo+IGJpbmRpbmdzIHRvIGpzb24tc2No
ZW1hDQo+IA0KPiBPbiAyMS8wMi8yMDIzIDEyOjUwLCBOYXZhIGtpc2hvcmUgTWFubmUgd3JvdGU6
DQo+ID4gQ29udmVydCB4aWxpbngtcHItZGVjb3VwbGVyIGJpbmRpbmdzIHRvIERUIHNjaGVtYSBm
b3JtYXQgdXNpbmcNCj4gPiBqc29uLXNjaGVtYQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2
YSBraXNob3JlIE1hbm5lIDxuYXZhLmtpc2hvcmUubWFubmVAYW1kLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2VzIGZvciB2MjoNCj4gPiAgICAgICAgICAgICAgIC0gVXBkYXRlZCB0aGUgZGVzY3Jp
cHRpb24gYW5kIGFkZHJlc3NlZCBzb21lIG1pbm9yIGNvbW1lbnRzDQo+ID4gICAgICAgICAgICAg
ICAgIGFzIHN1Z2dlc3RlZCBieSBLcnp5c3p0b2YuDQo+ID4NCj4gPiAgLi4uL2JpbmRpbmdzL2Zw
Z2EveGlsaW54LXByLWRlY291cGxlci50eHQgICAgIHwgNTQgLS0tLS0tLS0tLS0tLS0NCj4gPiAg
Li4uL2JpbmRpbmdzL2ZwZ2EveGxueCxwci1kZWNvdXBsZXIueWFtbCAgICAgIHwgNzEgKysrKysr
KysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDU0
IGRlbGV0aW9ucygtKSAgZGVsZXRlIG1vZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGlsaW54LXByLWRlY291cGxlci50eHQNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2Ev
eGxueCxwci1kZWNvdXBsZXIueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EveGlsaW54LXByLWRlY291cGxlci50eHQN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL3hpbGlueC1wci1k
ZWNvdXBsZXIudHh0DQo+ID4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMGFj
ZGZhNmQ2MmE0Li4wMDAwMDAwMDAwMDANCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZnBnYS94aWxpbngtcHItZGVjb3VwbGVyLnR4dA0KPiA+ICsrKyAvZGV2L251
bGwNCj4gPiBAQCAtMSw1NCArMCwwIEBADQo+ID4gLVhpbGlueCBMb2dpQ09SRSBQYXJ0aWFsIFJl
Y29uZmlnIERlY291cGxlciBTb2Z0Y29yZQ0KPiA+IC0NCj4gPiAtVGhlIFhpbGlueCBMb2dpQ09S
RSBQYXJ0aWFsIFJlY29uZmlnIERlY291cGxlciBtYW5hZ2VzIG9uZSBvciBtb3JlDQo+ID4gLWRl
Y291cGxlcnMgLyBmcGdhIGJyaWRnZXMuDQo+ID4gLVRoZSBjb250cm9sbGVyIGNhbiBkZWNvdXBs
ZS9kaXNhYmxlIHRoZSBicmlkZ2VzIHdoaWNoIHByZXZlbnRzIHNpZ25hbA0KPiA+IC1jaGFuZ2Vz
IGZyb20gcGFzc2luZyB0aHJvdWdoIHRoZSBicmlkZ2UuICBUaGUgY29udHJvbGxlciBjYW4gYWxz
bw0KPiA+IC1jb3VwbGUgLyBlbmFibGUgdGhlIGJyaWRnZXMgd2hpY2ggYWxsb3dzIHRyYWZmaWMg
dG8gcGFzcyB0aHJvdWdoIHRoZQ0KPiA+IC1icmlkZ2Ugbm9ybWFsbHkuDQo+ID4gLQ0KPiA+IC1Y
aWxpbnggTG9naUNPUkUgRHluYW1pYyBGdW5jdGlvbiBlWGNoYW5nZShERlgpIEFYSSBzaHV0ZG93
biBtYW5hZ2VyDQo+ID4gLVNvZnRjb3JlIGlzIGNvbXBhdGlibGUgd2l0aCB0aGUgWGlsaW54IExv
Z2lDT1JFIHByLWRlY291cGxlci4NCj4gPiAtDQo+ID4gLVRoZSBEeW5hbWljIEZ1bmN0aW9uIGVY
Y2hhbmdlIEFYSSBzaHV0ZG93biBtYW5hZ2VyIHByZXZlbnRzIEFYSQ0KPiA+IHRyYWZmaWMgLWZy
b20gcGFzc2luZyB0aHJvdWdoIHRoZSBicmlkZ2UuIFRoZSBjb250cm9sbGVyIHNhZmVseQ0KPiA+
IGhhbmRsZXMgQVhJNE1NIC1hbmQgQVhJNC1MaXRlIGludGVyZmFjZXMgb24gYSBSZWNvbmZpZ3Vy
YWJsZSBQYXJ0aXRpb24NCj4gPiB3aGVuIGl0IGlzIC11bmRlcmdvaW5nIGR5bmFtaWMgcmVjb25m
aWd1cmF0aW9uLCBwcmV2ZW50aW5nIHRoZSBzeXN0ZW0NCj4gPiBkZWFkbG9jayAtdGhhdCBjYW4g
b2NjdXIgaWYgQVhJIHRyYW5zYWN0aW9ucyBhcmUgaW50ZXJydXB0ZWQgYnkgREZYDQo+ID4gLQ0K
PiA+IC1UaGUgRHJpdmVyIHN1cHBvcnRzIG9ubHkgTU1JTyBoYW5kbGluZy4gQSBQUiByZWdpb24g
Y2FuIGhhdmUgbXVsdGlwbGUNCj4gPiAtUFIgRGVjb3VwbGVycyB3aGljaCBjYW4gYmUgaGFuZGxl
ZCBpbmRlcGVuZGVudGx5IG9yIGNoYWluZWQgdmlhDQo+ID4gZGVjb3VwbGUvIC1kZWNvdXBsZV9z
dGF0dXMgc2lnbmFscy4NCj4gPiAtDQo+ID4gLVJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gLS0g
Y29tcGF0aWJsZQkJOiBTaG91bGQgY29udGFpbiAieGxueCxwci1kZWNvdXBsZXItMS4wMCIgZm9s
bG93ZWQNCj4gYnkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAieGxueCxwci1kZWNv
dXBsZXIiIG9yDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgInhsbngsZGZ4LWF4aS1z
aHV0ZG93bi1tYW5hZ2VyLTEuMDAiIGZvbGxvd2VkIGJ5DQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgInhsbngsZGZ4LWF4aS1zaHV0ZG93bi1tYW5hZ2VyIg0KPiA+IC0tIHJlZ3MJCQk6
IGJhc2UgYWRkcmVzcyBhbmQgc2l6ZSBmb3IgZGVjb3VwbGVyIG1vZHVsZQ0KPiA+IC0tIGNsb2Nr
cwkJOiBpbnB1dCBjbG9jayB0byBJUA0KPiA+IC0tIGNsb2NrLW5hbWVzCQk6IHNob3VsZCBjb250
YWluICJhY2xrIg0KPiA+IC0NCj4gPiAtU2VlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dCBhbmQNCj4gPiAtRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2ZwZ2EvZnBnYS1icmlkZ2UudHh0IGZvciBnZW5lcmljDQo+IGJpbmRpbmdz
Lg0KPiA+IC0NCj4gPiAtRXhhbXBsZToNCj4gPiAtUGFydGlhbCBSZWNvbmZpZyBEZWNvdXBsZXI6
DQo+ID4gLQlmcGdhLWJyaWRnZUAxMDAwMDA0NTAgew0KPiA+IC0JCWNvbXBhdGlibGUgPSAieGxu
eCxwci1kZWNvdXBsZXItMS4wMCIsDQo+ID4gLQkJCSAgICAgInhsbngtcHItZGVjb3VwbGVyIjsN
Cj4gPiAtCQlyZWdzID0gPDB4MTAwMDAwNDUgMHgxMD47DQo+ID4gLQkJY2xvY2tzID0gPCZjbGtj
IDE1PjsNCj4gPiAtCQljbG9jay1uYW1lcyA9ICJhY2xrIjsNCj4gPiAtCQlicmlkZ2UtZW5hYmxl
ID0gPDA+Ow0KPiA+IC0JfTsNCj4gPiAtDQo+ID4gLUR5bmFtaWMgRnVuY3Rpb24gZVhjaGFuZ2Ug
QVhJIHNodXRkb3duIG1hbmFnZXI6DQo+ID4gLQlmcGdhLWJyaWRnZUAxMDAwMDA0NTAgew0KPiA+
IC0JCWNvbXBhdGlibGUgPSAieGxueCxkZngtYXhpLXNodXRkb3duLW1hbmFnZXItMS4wMCIsDQo+
ID4gLQkJCSAgICAgInhsbngsZGZ4LWF4aS1zaHV0ZG93bi1tYW5hZ2VyIjsNCj4gPiAtCQlyZWdz
ID0gPDB4MTAwMDAwNDUgMHgxMD47DQo+ID4gLQkJY2xvY2tzID0gPCZjbGtjIDE1PjsNCj4gPiAt
CQljbG9jay1uYW1lcyA9ICJhY2xrIjsNCj4gPiAtCQlicmlkZ2UtZW5hYmxlID0gPDA+Ow0KPiA+
IC0JfTsNCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZnBnYS94bG54LHByLWRlY291cGxlci55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZnBnYS94bG54LHByLWRlY291cGxlci55YW1sDQo+ID4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjRhMDhkNGJmYTIwZA0KPiA+
IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZnBnYS94bG54LHByLWRlY291cGxlci55YW1sDQo+ID4gQEAgLTAsMCArMSw3MSBAQA0KPiA+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVz
ZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9z
Y2hlbWFzL2ZwZ2EveGxueCxwci1kZWNvdXBsZXIueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRs
ZTogWGlsaW54IExvZ2lDT1JFIFBhcnRpYWwgUmVjb25maWcgRGVjb3VwbGVyL0FYSSBzaHV0ZG93
bg0KPiA+ICttYW5hZ2VyIFNvZnRjb3JlDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiAr
ICAtIE5hdmEga2lzaG9yZSBNYW5uZSA8bmF2YS5raXNob3JlLm1hbm5lQGFtZC5jb20+DQo+ID4g
Kw0KPiA+ICtkZXNjcmlwdGlvbjogVGhlIFhpbGlueCBMb2dpQ09SRSBQYXJ0aWFsIFJlY29uZmln
IERlY291cGxlciBtYW5hZ2VzDQo+ID4gK29uZSBvciBtb3JlDQo+IA0KPiBCbGFuayBsaW5lIGJl
Zm9yZSB0ZXh0Li4uIGRvbid0IHVzZSB5b3VyIG93biBzdHlsZS4gVXNlIHN0eWxlIGNvbnNpc3Rl
bnQgd2l0aA0KPiB0aGUgcHJvamVjdC4NCj4gDQo+ID4gKyAgZGVjb3VwbGVycyAvIGZwZ2EgYnJp
ZGdlcy4gVGhlIGNvbnRyb2xsZXIgY2FuIGRlY291cGxlL2Rpc2FibGUgdGhlDQo+ID4gKyBicmlk
Z2VzICB3aGljaCBwcmV2ZW50cyBzaWduYWwgY2hhbmdlcyBmcm9tIHBhc3NpbmcgdGhyb3VnaCB0
aGUNCj4gPiArIGJyaWRnZS4gIFRoZSBjb250cm9sbGVyICBjYW4gYWxzbyBjb3VwbGUgLyBlbmFi
bGUgdGhlIGJyaWRnZXMgd2hpY2gNCj4gPiArIGFsbG93cyB0cmFmZmljIHRvIHBhc3MgdGhyb3Vn
aCB0aGUgIGJyaWRnZSBub3JtYWxseS4NCj4gPiArICBYaWxpbnggTG9naUNPUkUgRHluYW1pYyBG
dW5jdGlvbiBlWGNoYW5nZShERlgpIEFYSSBzaHV0ZG93biBtYW5hZ2VyDQo+ID4gKyBTb2Z0Y29y
ZSAgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSBYaWxpbnggTG9naUNPUkUgcHItZGVjb3VwbGVyLiBU
aGUNCj4gPiArIER5bmFtaWMgRnVuY3Rpb24gIGVYY2hhbmdlIEFYSSBzaHV0ZG93biBtYW5hZ2Vy
IHByZXZlbnRzIEFYSSB0cmFmZmljDQo+ID4gKyBmcm9tIHBhc3NpbmcgdGhyb3VnaCB0aGUgIGJy
aWRnZS4gVGhlIGNvbnRyb2xsZXIgc2FmZWx5IGhhbmRsZXMNCj4gPiArIEFYSTRNTSBhbmQgQVhJ
NC1MaXRlIGludGVyZmFjZXMgb24gYSAgUmVjb25maWd1cmFibGUgUGFydGl0aW9uIHdoZW4NCj4g
PiArIGl0IGlzIHVuZGVyZ29pbmcgZHluYW1pYyByZWNvbmZpZ3VyYXRpb24sICBwcmV2ZW50aW5n
IHRoZSBzeXN0ZW0NCj4gPiArIGRlYWRsb2NrIHRoYXQgY2FuIG9jY3VyIGlmIEFYSSB0cmFuc2Fj
dGlvbnMgYXJlICBpbnRlcnJ1cHRlZCBieSBERlguDQo+ID4gKyAgUGxlYXNlIHJlZmVyIHRvIGZw
Z2EtcmVnaW9uLnR4dCBhbmQgZnBnYS1icmlkZ2UudHh0IGluIHRoaXMNCj4gPiArIGRpcmVjdG9y
eSBmb3IgIGNvbW1vbiBiaW5kaW5nIHBhcnQgYW5kIHVzYWdlLg0KPiA+ICsNCj4gPiArcHJvcGVy
dGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgb25lT2Y6DQo+ID4gKyAgICAgIC0g
aXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiB4bG54LHByLWRlY291cGxlci0xLjAwICNG
b3IgUFItRGVjb3VwbGVyLg0KPiANCj4gRHJvcCB0aGUgY29tbWVudCwgaXQgZHVwbGljYXRlcyB0
aGUgY29tcGF0aWJsZS4gVGhlcmUgaXMgbm8gcG9pbnQgaW4gaXQuDQo+IA0KPiA+ICsgICAgICAg
ICAgLSBjb25zdDogeGxueCxwci1kZWNvdXBsZXINCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiAr
ICAgICAgICAgIC0gY29uc3Q6IHhsbngsZGZ4LWF4aS1zaHV0ZG93bi1tYW5hZ2VyLTEuMDAgI0Zv
ciBBWEkgc2h1dGRvd24NCj4gbWFuYWdlci4NCj4gDQo+IERpdHRvDQo+IA0KPiA+ICsgICAgICAg
ICAgLSBjb25zdDogeGxueCxkZngtYXhpLXNodXRkb3duLW1hbmFnZXINCj4gPiArDQo+ID4gKyAg
cmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBpdGVt
czoNCj4gPiArICAgICAgLSBjb25zdDogYWNsaw0KPiA+ICsNCj4gPiArICBicmlkZ2UtZW5hYmxl
Og0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMy
DQo+ID4gKyAgICBlbnVtOiBbMCwgMV0NCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAg
ICBaZXJvIGlmIGRyaXZlciBzaG91bGQgZGlzYWJsZSBicmlkZ2UgYXQgc3RhcnR1cC4gT25lIGlm
IGRyaXZlciBzaG91bGQNCj4gPiArICAgICAgZW5hYmxlIGJyaWRnZSBhdCBzdGFydHVwLiBEZWZh
dWx0IGlzIHRvIGxlYXZlIGJyaWRnZSBpbiBjdXJyZW50IHN0YXRlLg0KPiANCj4gVGhpcyBwcm9w
ZXJ0eSB3YXNuJ3QgaW4gb3JpZ2luYWwgYmluZGluZy4gRXZlbiB0aG91Z2ggaXQgaXMgZnBnYS1i
cmlkZ2UudHh0LCB3aHkNCj4gZG8geW91IG5lZWQgaXQ/IEl0J3Mgbm90IHVzZWQuIEFsc28sIGRv
IG5vdCBkZXNjcmliZSBkcml2ZXIgYnV0IHJhdGhlcg0KPiBoYXJkd2FyZS4NCg0KSSBhZ3JlZSwg
dGhpcyBpcyBub3QgcmVsZXZhbnQgdG8gdGhlIEgvVyBwcm9wZXJ0eS4NCldpbGwgZHJvcCB0aGlz
IGluIHYzLg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
