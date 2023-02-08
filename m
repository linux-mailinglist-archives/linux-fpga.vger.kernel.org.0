Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260D068ED76
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Feb 2023 12:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBHLBX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Feb 2023 06:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBHLBW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Feb 2023 06:01:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E1312F22;
        Wed,  8 Feb 2023 03:01:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIHqzaK8rQYfyMvJXuuginE8gkBFuNjQi8UFt7uRi3aHiorknCamVuW+uHt9jbeJwiUlrOHq15opIfvKi9Wdb/BTP8f+EiTd1DovqK+dcZbpA3DCXJyrmtgC3Y8l1Ref2IgCffvjmkjRELHK2fRm9XnyyLHz4/bnAduXH2GSHhcEK7TqUpOaanNj1nHE+0+H4tLyIDaPW2h53FNfd1ReVJKD1guh4rnHuUfkVnq4qfj7Rnzgz+O+JcejpMIN0IDtJ1SuqJ701nHC9iFrLFTV7yrwaUkQRunzGD82WWo5AxIKAsUBS4GtK6T0Sn0MF82ARs8WtZoxj5zze0BkP9/Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNBxsIHt0EF29p5HtoFEvP33e8N07ZeoNOGcleYvwHc=;
 b=Ij7N3n1fGBmcx1KFt/e+n4WfVA4j3VUNHOirzc7MJedSYyldD24Rpidq2EzGDoivcvPYQ2G7uBPUFyplvgq8v8pHHrH2V4qyHHreuOuhaMGs9RIpgkNqzPSAIurJTmsTXo5wPfkaoWUQ4URDXOQJ/WqsqaJXT6xVqyw+ujsVKDElwUNp9kkdaRrwSW2Pf0AB7gLbTE+TQZOcD1J+HSZiItpjtUG0DxLd70z0rduvWr0K8rRrVyILKyIiXvoUKusM4oK9F24tvm47AZXRvkwfG6GSqBVHfShLCXTbsLW7mk96Ma6Cffv8iR/gjaj8rwoU1VfKwf4wybpztYu00ClPGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNBxsIHt0EF29p5HtoFEvP33e8N07ZeoNOGcleYvwHc=;
 b=oeMfp/v/zxj7pJ9Bx7C8FJhBJOu58YN9PyN/ejIj+YmxfUnxrC22929dvzJLVRFfmsTSRv9/azm8zyJyPJJrvylGwLObhcNA7wQy1EJw6DLViNJ4c2YHWF7AYtRoGHfDxaKhiyZmpYWWT0LXaMbO0ztmZtAVaDir9JkHty08k/k=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Wed, 8 Feb
 2023 11:01:17 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::cf25:1ed8:5dd0:104d]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::cf25:1ed8:5dd0:104d%3]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 11:01:17 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Marco Pagani <marpagan@redhat.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fpga: mgr: Update the state to provide the exact error
 code
Thread-Topic: [PATCH] fpga: mgr: Update the state to provide the exact error
 code
Thread-Index: AQHZOtrgezsWkMy/N0WXVCFTXXm+Ea7Dz68AgAESlNA=
Date:   Wed, 8 Feb 2023 11:01:17 +0000
Message-ID: <DM6PR12MB3993232B3EB5DE00CBC9B452CDD89@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20230207095915.169146-1-nava.kishore.manne@amd.com>
 <8d34bc43-deb4-4166-83ad-34561ee5ac33@redhat.com>
In-Reply-To: <8d34bc43-deb4-4166-83ad-34561ee5ac33@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|CO6PR12MB5489:EE_
x-ms-office365-filtering-correlation-id: e6c43e5e-ee3e-48f9-312f-08db09c3cd4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kktMY8KFxcoG26TBfBC57HlbB7pjwrJ+M6eNDE993cP45EVNU+09lB9Zwa8ubr9V/mYtldka8eEZNyLRw4mJInkMIWbQgE2NCCv4yNwJjULf371Z4/3j9WdSVKiWeRxbx7NbM+sy9Zt/OfuyWtdJ1CK2k5o/Wy/HaeU4poMQe6eIF0jtRMy3215itHu95MbV4boXX67qW/ZvPTxU1AlonV2ExigPtybDhs0dXoumLy0B8K1sfJu8uPfGuNtxkiNPsI6T9K9L+5bCm0jLeRGMDNz6OzVHSBVzgZsVvBv+o1HyAVXCM6MjePC0yU21Yyp67a2luZ5j0EgNdoEyUscw8gjuTDHpdTYXK5EQ4CzsovbFFoBZ+BSKiALO391+wbKuImG6YqezdFUbliuAdJNKcSaL8xvfh5o1xjP1PXlYK7iyEHAo4RDT4SyrI1zxS/QqySByW44OCRCy75YkuOvhEOhvBNL4XOZnX/D9UtT0Y2SAt1OFOQ26CTHSpTxUQ15v4K3ATktY2utqkup4O5scuwRuqXHg7j1w4XUx5/ZS//HpzxmzoXACW6knT1PXGjMBXLTXf75XHHs4BTIp0lqqWcsAXeYykqDnRuARNIy+3WRnbp9jOVjMe04jdSXh7FFbBfgqy7hOgeSDXHid4tQjN462ah2F6tujz2hwjZh2kY3RKOtdaBSPISzJ5KXyOjMUaUN3zKim67/3HT0iW/Fc/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(2906002)(38070700005)(15650500001)(5660300002)(122000001)(38100700002)(478600001)(7696005)(6506007)(71200400001)(53546011)(186003)(33656002)(83380400001)(26005)(9686003)(86362001)(55016003)(41300700001)(66476007)(66556008)(66446008)(64756008)(52536014)(8936002)(4326008)(316002)(66946007)(54906003)(110136005)(8676002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTB2SXZzdnNkOUtRSFdoMGtkcjVrcXY0ZDZhOW9oRWlIZVZnRmIxcHpBSmow?=
 =?utf-8?B?QjBJL3Y5WGZqNXIyYzVCdVNzcFhxRitaZW9mRmxScnN3bkY4S2swM0hWNWhs?=
 =?utf-8?B?T3cyaU50aEErUlRndndoZ044N1A3VWNUSy92dUxIYXp6SkNOdHV5RDdBUVEy?=
 =?utf-8?B?eGNndTExdGN6akk0V2hjMVQ3N1J2QkJCOG5VengyZ2FwMG91dXVDN3BmZ3RD?=
 =?utf-8?B?eTNaWm9JOURlTUVOUmlLZ09jNTVUa2owTlFJWFBFM3N6dFJocHhlb1RYMERD?=
 =?utf-8?B?cnd1bjlsRjdicFBrMC9nL2wzc2RsbGlRM0tsNEhybEpocThwb3NaVFRxVFI5?=
 =?utf-8?B?cEVscWFJbUJFaitpcWpiQ3UzaGNVK1ZoQjYrdDg1NnhVYW9JZWN2V1phY2NE?=
 =?utf-8?B?MzBmTjhxSE4rUG1oOVBsTFhoZkY1S0JKZ0JMOENZWGg0a2ozRHd4enF3aHBR?=
 =?utf-8?B?LzJCd1dsTVhFejZQSWRMQU9laXl3SGdQaSthVWJMTmVaT0xsWHhXN0FvbjMr?=
 =?utf-8?B?TGw1b25VSUduNVhlbFBHZEdMUVd0ZG14djJtMWNiTzNqSENETCtkR3Vja0VR?=
 =?utf-8?B?M0hOV0w2bldFUjBtWFlFYVZPRlUzUG9UOGFiMjJ4eFRrWjVDRUNDQjRYQk1k?=
 =?utf-8?B?UUxaN0RMVEZnbFVWZlZ0Y3owRDFEa2JxcmpsUWZ5eXdsRzJtd2srNzBIZjhG?=
 =?utf-8?B?YVVsalQrMEVVb3U0bHA1a0tkNE5EVVJ5Q0k2U0lFV0gwV1B5UGsrUFp1MWt0?=
 =?utf-8?B?VUVzdFBpSDdnNlpMc2FpL1RwM0pnNklDb2taQXVSY1RFSVJQb2g0NEVhenZN?=
 =?utf-8?B?b2R5ZnBIWFZtNTVDTE54ZjJKMWVmbzNpTlhGVDcvblZMYmYxd2NVNy93OE1y?=
 =?utf-8?B?eVNxVmpqNnVBaVV5eSswNk44NUo2MmYxa1ptdUdsS09vRXk2cUZwMHdaeGpO?=
 =?utf-8?B?SnI3NENiL0RCOUtvR2hnN2FvcUF1RUkrdEFva2JGSjdyV05tZUVNdTUxTTBz?=
 =?utf-8?B?VFZqc3lWRDZtUWpUQTgzdnhVSXY3dU1FSkZCRHhnTHJiWWdkWTdadjNNbkt0?=
 =?utf-8?B?WlBFdStmUEJQSHZPQllzakdYMEdDNGFRMkdQMXdVS2R1ckgrR29wWVk4ZzZK?=
 =?utf-8?B?a2hGSVZCQ3VyVGZEV1R0ci9HYkFKR1UxdVMzd01iYU5hQjlVWUlBK1J3a0pX?=
 =?utf-8?B?OTRqRnBPYm1QWkpkUGlXTjBycWM4MFRlTzVXYmtpT0w2VXNMSXdVK3EwZldv?=
 =?utf-8?B?ME9JT3VqSkhNVW1IRXhQOWRxWXh3c0pMR01ENFZHTURaWENxdFl3M1hrK3lO?=
 =?utf-8?B?U1FkNmY1VktzelpiNnFwV2VKMTZ1Nysyd3V4a2h2NThMdVhRMEVBa1NXWS82?=
 =?utf-8?B?UTNGN0JzcjYwZWNJTFVwZ3A1UVNheHZYYlkxNUxVYU5IbFpyVnBsUUtFcHNl?=
 =?utf-8?B?Nks1UUFkdDNrRlpnUmVGYVNNTTJiZ2lrMEJnZGs3eTRZZDVkL3ExdjJhVGtU?=
 =?utf-8?B?eGRkUXcxZ0NHTDVYUFRpdks3VFQ5UjVuRlU4bEF0cllXUnJxcXAycjYybWJP?=
 =?utf-8?B?YTE3N2ExQm9XQ1M2c1dlY1ZkVkpUckN5aDRXTjMzT0NlNlE4SFNZVlRjSTlY?=
 =?utf-8?B?dmprd2JxbHAzNVBjZStIbTJUc3VraU5rd3V5ZkNQTEVMYlNhbDlHeXIzZXEv?=
 =?utf-8?B?c04rUkRjQkJWdkJoL3NCKzZLTm5KWWR0RUhKVWlNVFdhVnBKbHVMRVI5eU9p?=
 =?utf-8?B?ZTl4MmppekJkcjJXNzBwb0h6OTNUcTZFMkwxTjdJQVB0ZzRtUzdpSXpIVHJr?=
 =?utf-8?B?U3RaenpZY0JvbysxaTd2R2RaNy83QndtVHBQNHZTZHRpbW9OdCtKYk5rclpU?=
 =?utf-8?B?dE5vd1Nzd29KR012UVhxUXdKeEhCQjBmRmVGb1pQVWtndUg5enlWWFV0eDVB?=
 =?utf-8?B?aFpHRDRPOVB3UHo1NU1nNVd0VXpRdFEzSzNrYnhKaUNCVWNmZitSVzdmb3BK?=
 =?utf-8?B?SEV6MUo2WHVaK0tWcjBUYmNrVTBaajVvUEl2bFlMTlkyUkh6QVY3TVRxSzA1?=
 =?utf-8?B?YlNjVjBwUjVPbkRMdlkxOE5tRVBqNytzQ3ZVMWxUNTFobkdkTGNyVnF5ZDFu?=
 =?utf-8?Q?oaOE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c43e5e-ee3e-48f9-312f-08db09c3cd4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 11:01:17.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc/OmPPRSQRxSwL55nDHZ7e/wCk52EsZ4rMXQUdNRPuDve2rRdoMEAjZ4dOXwb8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgTWFyY28sDQoNCglUaGFua3MgZm9yIHByb3ZpZGluZyB0aGUgcmV2aWV3IGNvbW1lbnRzLg0K
UGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lIGJlbG93Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNvIFBhZ2FuaSA8bWFycGFnYW5AcmVkaGF0LmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA4LCAyMDIzIDEyOjA0IEFNDQo+IFRvOiBOYXZh
IGtpc2hvcmUgTWFubmUgPG5hdmEubWFubmVAeGlsaW54LmNvbT4NCj4gQ2M6IE1hbm5lLCBOYXZh
IGtpc2hvcmUgPG5hdmEua2lzaG9yZS5tYW5uZUBhbWQuY29tPjsNCj4gbWRmQGtlcm5lbC5vcmc7
IGhhby53dUBpbnRlbC5jb207IHRyaXhAcmVkaGF0LmNvbTsgeWlsdW4ueHVAaW50ZWwuY29tOw0K
PiBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBmcGdhOiBtZ3I6IFVwZGF0ZSB0aGUgc3RhdGUgdG8g
cHJvdmlkZSB0aGUgZXhhY3QgZXJyb3INCj4gY29kZQ0KPiANCj4gDQo+IE9uIDIwMjMtMDItMDcg
MTA6NTksIE5hdmEga2lzaG9yZSBNYW5uZSB3cm90ZToNCj4gPiBGcm9tOiBOYXZhIGtpc2hvcmUg
TWFubmUgPG5hdmEubWFubmVAeGlsaW54LmNvbT4NCj4gPg0KPiA+IFVwIG9uIGZwZ2EgY29uZmln
dXJhdGlvbiBmYWlsdXJlLCB0aGUgZXhpc3Rpbmcgc3lzZnMgc3RhdGUgaW50ZXJmYWNlDQo+ID4g
aXMganVzdCBwcm92aWRpbmcgdGhlIGdlbmVyaWMgZXJyb3IgbWVzc2FnZSByYXRoZXIgdGhhbiBw
cm92aWRpbmcgdGhlDQo+ID4gZXhhY3QgZXJyb3IgY29kZS4gVGhpcyBwYXRjaCBleHRlbmRzIHN5
c2ZzIHN0YXRlIGludGVyZmFjZSB0byBwcm92aWRlDQo+ID4gdGhlIGV4YWN0IGVycm9yIHJlY2Vp
dmVkIGZyb20gdGhlIGxvd2VyIGxheWVyIGFsb25nIHdpdGggdGhlIGV4aXN0aW5nDQo+ID4gZ2Vu
ZXJpYyBlcnJvciBtZXNzYWdlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3Jl
IE1hbm5lIDxuYXZhLm1hbm5lQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZnBn
YS9mcGdhLW1nci5jICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgaW5jbHVk
ZS9saW51eC9mcGdhL2ZwZ2EtbWdyLmggfCAgMiArKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2ZwZ2EvZnBnYS1tZ3IuYyBiL2RyaXZlcnMvZnBnYS9mcGdhLW1nci5jIGluZGV4DQo+ID4g
OGVmYTY3NjIwZTIxLi5iMmQ3NDcwNWE1YTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9mcGdh
L2ZwZ2EtbWdyLmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2EvZnBnYS1tZ3IuYw0KPiA+IEBAIC02
MSwxMiArNjEsMTQgQEAgc3RhdGljIGlubGluZSBpbnQgZnBnYV9tZ3Jfd3JpdGVfY29tcGxldGUo
c3RydWN0DQo+ID4gZnBnYV9tYW5hZ2VyICptZ3IsICB7DQo+ID4gIAlpbnQgcmV0ID0gMDsNCj4g
Pg0KPiA+ICsJbWdyLT5lcnIgPSAwOw0KPiA+ICAJbWdyLT5zdGF0ZSA9IEZQR0FfTUdSX1NUQVRF
X1dSSVRFX0NPTVBMRVRFOw0KPiA+ICAJaWYgKG1nci0+bW9wcy0+d3JpdGVfY29tcGxldGUpDQo+
ID4gIAkJcmV0ID0gbWdyLT5tb3BzLT53cml0ZV9jb21wbGV0ZShtZ3IsIGluZm8pOw0KPiA+ICAJ
aWYgKHJldCkgew0KPiA+ICAJCWRldl9lcnIoJm1nci0+ZGV2LCAiRXJyb3IgYWZ0ZXIgd3JpdGlu
ZyBpbWFnZSBkYXRhIHRvDQo+IEZQR0FcbiIpOw0KPiA+ICAJCW1nci0+c3RhdGUgPSBGUEdBX01H
Ul9TVEFURV9XUklURV9DT01QTEVURV9FUlI7DQo+ID4gKwkJbWdyLT5lcnIgPSByZXQ7DQo+ID4g
IAkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPiAgCW1nci0+c3RhdGUgPSBGUEdBX01HUl9TVEFU
RV9PUEVSQVRJTkc7IEBAIC0xNTQsNiArMTU2LDcgQEANCj4gc3RhdGljDQo+ID4gaW50IGZwZ2Ff
bWdyX3BhcnNlX2hlYWRlcl9tYXBwZWQoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLCAgew0KPiA+
ICAJaW50IHJldDsNCj4gPg0KPiA+ICsJbWdyLT5lcnIgPSAwOw0KPiA+ICAJbWdyLT5zdGF0ZSA9
IEZQR0FfTUdSX1NUQVRFX1BBUlNFX0hFQURFUjsNCj4gPiAgCXJldCA9IGZwZ2FfbWdyX3BhcnNl
X2hlYWRlcihtZ3IsIGluZm8sIGJ1ZiwgY291bnQpOw0KPiA+DQo+ID4gQEAgLTE2NSw2ICsxNjgs
NyBAQCBzdGF0aWMgaW50IGZwZ2FfbWdyX3BhcnNlX2hlYWRlcl9tYXBwZWQoc3RydWN0DQo+IGZw
Z2FfbWFuYWdlciAqbWdyLA0KPiA+ICAJaWYgKHJldCkgew0KPiA+ICAJCWRldl9lcnIoJm1nci0+
ZGV2LCAiRXJyb3Igd2hpbGUgcGFyc2luZyBGUEdBIGltYWdlDQo+IGhlYWRlclxuIik7DQo+ID4g
IAkJbWdyLT5zdGF0ZSA9IEZQR0FfTUdSX1NUQVRFX1BBUlNFX0hFQURFUl9FUlI7DQo+ID4gKwkJ
bWdyLT5lcnIgPSByZXQ7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gQEAg
LTE4NSw2ICsxODksNyBAQCBzdGF0aWMgaW50IGZwZ2FfbWdyX3BhcnNlX2hlYWRlcl9zZ19maXJz
dChzdHJ1Y3QNCj4gZnBnYV9tYW5hZ2VyICptZ3IsDQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4g
IAltZ3ItPnN0YXRlID0gRlBHQV9NR1JfU1RBVEVfUEFSU0VfSEVBREVSOw0KPiA+ICsJbWdyLT5l
cnIgPSAwOw0KPiA+DQo+ID4gIAlzZ19taXRlcl9zdGFydCgmbWl0ZXIsIHNndC0+c2dsLCBzZ3Qt
Pm5lbnRzLCBTR19NSVRFUl9GUk9NX1NHKTsNCj4gPiAgCWlmIChzZ19taXRlcl9uZXh0KCZtaXRl
cikgJiYNCj4gPiBAQCAtMTk3LDYgKzIwMiw3IEBAIHN0YXRpYyBpbnQgZnBnYV9tZ3JfcGFyc2Vf
aGVhZGVyX3NnX2ZpcnN0KHN0cnVjdA0KPiBmcGdhX21hbmFnZXIgKm1nciwNCj4gPiAgCWlmIChy
ZXQgJiYgcmV0ICE9IC1FQUdBSU4pIHsNCj4gPiAgCQlkZXZfZXJyKCZtZ3ItPmRldiwgIkVycm9y
IHdoaWxlIHBhcnNpbmcgRlBHQSBpbWFnZQ0KPiBoZWFkZXJcbiIpOw0KPiA+ICAJCW1nci0+c3Rh
dGUgPSBGUEdBX01HUl9TVEFURV9QQVJTRV9IRUFERVJfRVJSOw0KPiA+ICsJCW1nci0+ZXJyID0g
cmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+IEBAIC0yNDksNiArMjU1
LDcgQEAgc3RhdGljIHZvaWQgKmZwZ2FfbWdyX3BhcnNlX2hlYWRlcl9zZyhzdHJ1Y3QNCj4gZnBn
YV9tYW5hZ2VyICptZ3IsDQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2X2VycigmbWdyLT5k
ZXYsICJFcnJvciB3aGlsZSBwYXJzaW5nIEZQR0EgaW1hZ2UNCj4gaGVhZGVyXG4iKTsNCj4gPiAg
CQltZ3ItPnN0YXRlID0gRlBHQV9NR1JfU1RBVEVfUEFSU0VfSEVBREVSX0VSUjsNCj4gPiArCQlt
Z3ItPmVyciA9IHJldDsNCj4gPiAgCQlrZnJlZShidWYpOw0KPiA+ICAJCWJ1ZiA9IEVSUl9QVFIo
cmV0KTsNCj4gPiAgCX0NCj4gPiBAQCAtMjcyLDYgKzI3OSw3IEBAIHN0YXRpYyBpbnQgZnBnYV9t
Z3Jfd3JpdGVfaW5pdF9idWYoc3RydWN0DQo+IGZwZ2FfbWFuYWdlciAqbWdyLA0KPiA+ICAJc2l6
ZV90IGhlYWRlcl9zaXplID0gaW5mby0+aGVhZGVyX3NpemU7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+
DQo+ID4gKwltZ3ItPmVyciA9IDA7DQo+ID4gIAltZ3ItPnN0YXRlID0gRlBHQV9NR1JfU1RBVEVf
V1JJVEVfSU5JVDsNCj4gPg0KPiA+ICAJaWYgKGhlYWRlcl9zaXplID4gY291bnQpDQo+ID4gQEAg
LTI4NCw2ICsyOTIsNyBAQCBzdGF0aWMgaW50IGZwZ2FfbWdyX3dyaXRlX2luaXRfYnVmKHN0cnVj
dA0KPiBmcGdhX21hbmFnZXIgKm1nciwNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlkZXZfZXJy
KCZtZ3ItPmRldiwgIkVycm9yIHByZXBhcmluZyBGUEdBIGZvciB3cml0aW5nXG4iKTsNCj4gPiAg
CQltZ3ItPnN0YXRlID0gRlBHQV9NR1JfU1RBVEVfV1JJVEVfSU5JVF9FUlI7DQo+ID4gKwkJbWdy
LT5lcnIgPSByZXQ7DQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPg0KPiA+IEBAIC0z
NzAsNiArMzc5LDcgQEAgc3RhdGljIGludCBmcGdhX21ncl9idWZfbG9hZF9zZyhzdHJ1Y3QNCj4g
PiBmcGdhX21hbmFnZXIgKm1nciwNCj4gPg0KPiA+ICAJLyogV3JpdGUgdGhlIEZQR0EgaW1hZ2Ug
dG8gdGhlIEZQR0EuICovDQo+ID4gIAltZ3ItPnN0YXRlID0gRlBHQV9NR1JfU1RBVEVfV1JJVEU7
DQo+ID4gKwltZ3ItPmVyciA9IDA7DQo+ID4gIAlpZiAobWdyLT5tb3BzLT53cml0ZV9zZykgew0K
PiA+ICAJCXJldCA9IGZwZ2FfbWdyX3dyaXRlX3NnKG1nciwgc2d0KTsNCj4gPiAgCX0gZWxzZSB7
DQo+ID4gQEAgLTQwNSw2ICs0MTUsNyBAQCBzdGF0aWMgaW50IGZwZ2FfbWdyX2J1Zl9sb2FkX3Nn
KHN0cnVjdA0KPiBmcGdhX21hbmFnZXIgKm1nciwNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlk
ZXZfZXJyKCZtZ3ItPmRldiwgIkVycm9yIHdoaWxlIHdyaXRpbmcgaW1hZ2UgZGF0YSB0bw0KPiBG
UEdBXG4iKTsNCj4gPiAgCQltZ3ItPnN0YXRlID0gRlBHQV9NR1JfU1RBVEVfV1JJVEVfRVJSOw0K
PiA+ICsJCW1nci0+ZXJyID0gcmV0Ow0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4N
Cj4gPiBAQCAtNDM3LDEwICs0NDgsMTIgQEAgc3RhdGljIGludCBmcGdhX21ncl9idWZfbG9hZF9t
YXBwZWQoc3RydWN0DQo+IGZwZ2FfbWFuYWdlciAqbWdyLA0KPiA+ICAJICogV3JpdGUgdGhlIEZQ
R0EgaW1hZ2UgdG8gdGhlIEZQR0EuDQo+ID4gIAkgKi8NCj4gPiAgCW1nci0+c3RhdGUgPSBGUEdB
X01HUl9TVEFURV9XUklURTsNCj4gPiArCW1nci0+ZXJyID0gMDsNCj4gPiAgCXJldCA9IGZwZ2Ff
bWdyX3dyaXRlKG1nciwgYnVmLCBjb3VudCk7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2
X2VycigmbWdyLT5kZXYsICJFcnJvciB3aGlsZSB3cml0aW5nIGltYWdlIGRhdGEgdG8NCj4gRlBH
QVxuIik7DQo+ID4gIAkJbWdyLT5zdGF0ZSA9IEZQR0FfTUdSX1NUQVRFX1dSSVRFX0VSUjsNCj4g
PiArCQltZ3ItPmVyciA9IHJldDsNCj4gPiAgCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+
ID4gQEAgLTU0NCwxMCArNTU3LDExIEBAIHN0YXRpYyBpbnQgZnBnYV9tZ3JfZmlybXdhcmVfbG9h
ZChzdHJ1Y3QNCj4gZnBnYV9tYW5hZ2VyICptZ3IsDQo+ID4gIAlkZXZfaW5mbyhkZXYsICJ3cml0
aW5nICVzIHRvICVzXG4iLCBpbWFnZV9uYW1lLCBtZ3ItPm5hbWUpOw0KPiA+DQo+ID4gIAltZ3It
PnN0YXRlID0gRlBHQV9NR1JfU1RBVEVfRklSTVdBUkVfUkVROw0KPiA+IC0NCj4gPiArCW1nci0+
ZXJyID0gMDsNCj4gPiAgCXJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBpbWFnZV9uYW1lLCBk
ZXYpOw0KPiA+ICAJaWYgKHJldCkgew0KPiA+ICAJCW1nci0+c3RhdGUgPSBGUEdBX01HUl9TVEFU
RV9GSVJNV0FSRV9SRVFfRVJSOw0KPiA+ICsJCW1nci0+ZXJyID0gcmV0Ow0KPiA+ICAJCWRldl9l
cnIoZGV2LCAiRXJyb3IgcmVxdWVzdGluZyBmaXJtd2FyZSAlc1xuIiwNCj4gaW1hZ2VfbmFtZSk7
DQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPiBAQCAtNjI2LDYgKzY0MCwxMCBAQCBz
dGF0aWMgc3NpemVfdCBzdGF0ZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgIHsNCj4gPiAgCXN0
cnVjdCBmcGdhX21hbmFnZXIgKm1nciA9IHRvX2ZwZ2FfbWFuYWdlcihkZXYpOw0KPiA+DQo+ID4g
KwlpZiAobWdyLT5lcnIpDQo+ID4gKwkJcmV0dXJuIHNwcmludGYoYnVmLCAiJXM6IDB4JXhcbiIs
DQo+ID4gKwkJCSAgICAgICBzdGF0ZV9zdHJbbWdyLT5zdGF0ZV0sIG1nci0+ZXJyKTsNCj4gPiAr
DQo+ID4gIAlyZXR1cm4gc3ByaW50ZihidWYsICIlc1xuIiwgc3RhdGVfc3RyW21nci0+c3RhdGVd
KTsNCj4gDQo+IA0KPiBJZiBvbmUgb2YgdGhlIGZwZ2EgbWFuYWdlciBvcHMgZmFpbHMsIHRoZSBs
b3ctbGV2ZWwgZXJyb3IgY29kZSBpcyBhbHJlYWR5DQo+IHJldHVybmVkIHRvIHRoZSBjYWxsZXIu
IFdvdWxkbid0IGl0IGJlIGJldHRlciB0byByZWx5IG9uIHRoaXMgaW5zdGVhZCBvZiBwcmludGlu
Zw0KPiB0aGUgbG93LWxldmVsIGVycm9yIGNvZGUgaW4gYSBzeXNmcyBhdHRyaWJ1dGUgYW5kIHNl
bmRpbmcgaXQgdG8gdGhlIHVzZXJzcGFjZT8NCj4gDQpBZ3JlZSwgdGhlIGxvdy1sZXZlbCBlcnJv
ciBjb2RlIGlzIGFscmVhZHkgcmV0dXJuZWQgdG8gdGhlIGNhbGxlciBidXQgdGhlIHVzZXIgYXBw
bGljYXRpb24NCndpbGwgbm90IGhhdmUgYW55IGFjY2VzcyB0byByZWFkIHRoaXMgZXJyb3IgaW5m
by4gU28sIEkgZmVlbCB0aGlzIHBhdGNoIHByb3ZpZGVzIHRoYXQgZmxleGliaWxpdHkgDQp0byB0
aGUgdXNlciBhcHBsaWNhdGlvbiB0byBnZXQgdGhlIGV4YWN0IGVycm9yIGluZm8uIA0KcGxlYXNl
IGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueSBvdGhlciB0aG91Z2h0cyB3aWxsIGltcGxlbWVu
dCB0aGF0Lg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
