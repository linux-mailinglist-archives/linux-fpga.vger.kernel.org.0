Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85355200FA
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 17:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiEIPTu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiEIPTs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 11:19:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008772DF1;
        Mon,  9 May 2022 08:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBydyKDQjpQrS644REVjTTtW9XQYvjDBzSJzGRdPsx8uxE9jbd5knCSXJTsaGYfP7CizkF3zeN5b98oZaIW3nThc195v3oMxuF+5rEuGPlDKODfvAMChj4pqHQ6A99MInmr/EroocZYSdkNkdfnOQ3EJQV0n1F8xEnyaJdRlCtE1uv8jgUlS3tB6P4itIsmgU2nD2GLmUjSmasfNmZ9lkqRarzd9XikyZ7kYANFmTcjgTe4ivDUWcbVKCv3ZQ1Cdfd/VDjZHPqi9HY8SFCQTeaL6vr8FtAN8Y2QpgLvJKvNmD5ecoGmkNVAzidcRVWvkG6MLbmAoRn5XF4NXVYUODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4qCX3o+tE6N4RbnRQ9/wGhvzUZ8cB5zqK8aXiV/4zc=;
 b=ZKWf7ZGc2bag7GlEMXfiVVmRMK2KYuSrI3o9C+g1r7OoLkpitimA6oQ+zmik0IVQ4CbeNNYJ0jPYV/fxf7atEI3DiMUi4kepjerpFpu4LOEFjZ870kPfjFzTlifxUyNAeJ+chw/mSz4u6urWeaXUaw3823ERgQFmjolpWJ8jN6vAPJliASUNfYLf8Lsei/+un1KUls7umywVgiIDJlf1FdXornj2TZQl+fmvYJusS8sLHKPePB359+1UGpnALZhnDSP442nx1pEv/gjKFJX0NBjjRt1Kd+ehcfcsGR6pONyex75I93tAtIkgcXhXbaouJEerCoRIS39UvAsvJy0AsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4qCX3o+tE6N4RbnRQ9/wGhvzUZ8cB5zqK8aXiV/4zc=;
 b=tLsjXvXWUkqpa0AOHX24C7du278wttB2lg3Z7qS7nE7rsbw0n+5S/amWdvhrfvHESDJWsm4W6cZkBJl+zdxDS+BST+unyMCL+ThbZbnewgEuKJzx8oDVSMK1r3tHxEtSpSu7sH4dZvYxYQC4NblV8W1v65BQ8SerR0KnCnsCY4U=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BN0PR02MB8206.namprd02.prod.outlook.com (2603:10b6:408:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 15:15:49 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::3ca3:adb0:8f4b:c865]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::3ca3:adb0:8f4b:c865%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 15:15:48 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Tom Rix <trix@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
CC:     Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Thread-Topic: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Thread-Index: AQHYY536ULblJruqZk67DKEGAICzRq0WfaoAgAAojAA=
Date:   Mon, 9 May 2022 15:15:48 +0000
Message-ID: <SN6PR02MB4576F78E793E7C0EE2A0A4FDC2C69@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <YnkE8AbimDa7sfN8@kili>
 <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
In-Reply-To: <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9739033-3db1-462a-16a6-08da31cecbf6
x-ms-traffictypediagnostic: BN0PR02MB8206:EE_
x-microsoft-antispam-prvs: <BN0PR02MB82063ABB64764D68EC502524C2C69@BN0PR02MB8206.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ii5/TuGM4vSZTcm/8u7lgoRqPCmLdkSdf3S9O3dyIqyBMzzWGx4fUtMSYGniweJA4dJt4DIuum/D+cisK+lVN/+q1q2iSgu6kMwDkJYno8ndUrIduJsM04xGdO/Hyky3BQgYPKW2NJSaZipqtiKvZApXr99gVJolKm0Sm1CyYAzWddfYfLcYf1mHMTmlUvOI3fxkzZWv6OV1iggLKHpJ7kKFOsH03Y8UT4aG/mab3AS6a5B+v9fU1ZIg0nCgJmL+XFi6ufoBrvugQrrXfjn6+21X25NhxdNnxRXZJhjQHL8PblN12IInpA9m/zslalEujnOUFiZ4A8Dxad0N0A9aagbSbkpNvHPm/XLMtdiqNCi7GYYWxTmnPsxXi5jfEUi7bSq8++IHI4Ir7JFZegeIRZbbrrcGDZ0bxJZlHY2wCzvH5ael9wqSiaOwCQStytAI26XjLtNaesS/mR26DqNw3EnnOMBnotlKqMpKJTu5v/2QMzxr4PN4fBB0RR6ImyNrxRwmEgqiA9tNlyoNyqol/4x3wNLwzH7O6q4qzWdaOVBARYWdFezsM6IVJGaIssXH7t7YE+sYh2M5drbN3abBgEYEQuhnP+NVNSalksBsnuB4gFanUYbTyn01XxQ8JzFFnQ09LHj1h4QLn2Q0nU+HigDf8ZfiEOg/YnygvjJcguXyz1df7fpWeMTR1D4aik9uO8a641n4lTjZDaUuxL/wRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(6506007)(76116006)(2906002)(9686003)(7696005)(64756008)(71200400001)(8676002)(4326008)(86362001)(33656002)(5660300002)(66556008)(66476007)(53546011)(26005)(66946007)(508600001)(52536014)(55016003)(38070700005)(38100700002)(54906003)(110136005)(122000001)(186003)(316002)(83380400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWdNdnBRMTVaa2luQytDeDdMU25SaVBHVzVxN1BHVUt4L05oSVl3ckk3NHZU?=
 =?utf-8?B?SlM5Y0wwWUhjNWxvU1lKaWhtZG5Ed0lLVEswbGNhUlVQRk55akxjVk1BcE1l?=
 =?utf-8?B?anUrVDNxNlB6bDBKUHpOMk1EVFdKcUZmRmE1K0g5cjZoYVcvMFY0U0hJOFpr?=
 =?utf-8?B?a3YxSGdUM0c5Z0xkNi9RSjJqWkZEVVVGU3lFV3NQZ0dwZ0ZrdUllZGkwdnVX?=
 =?utf-8?B?WE42WmtEVlNwR3ozcWoyeE1vaFF6N2ZORkxsQnlKM3BFSHgzZEZ0UU9KYkM5?=
 =?utf-8?B?TUhUd09aMkxwMTF2Ulg3WXdYYVFOYjJBbEpCMW42ZEllbmMyRk51cnNiOUpk?=
 =?utf-8?B?cHRuUXpZdk0vbVMwdkFGSG8rN1JhbHJwMTMrOU51a3pnTFN1dHI0Q3F3YnpU?=
 =?utf-8?B?VU9qZ0xVSFZacmx2Szg1Sm5mejEvYWoxOHZpbmVpcE1yU3BJQkJQM3hQUEJz?=
 =?utf-8?B?WUoya3J5aUVnZHdIZVlyK243UFRzcGNXOVNJblpwSTh6c3hGYVdORUxPQ3Jq?=
 =?utf-8?B?bHJ0M1BUdEVINFJXUGNIRHppcDczVVpGeGNLbjlkcnQvMGM4OCtjZ0tNaExP?=
 =?utf-8?B?UTdFL2x2VzM5aFJTcStTSmhITTBJMmIzcDlDdkh6cmsxT2Ywb3A5YXluQkN4?=
 =?utf-8?B?SmhpeDdvY2JpdnFYbERZREJwanZpTDZZQlBEN09TM2FHN1ZFNUJEcExwa25u?=
 =?utf-8?B?eU1QVkdSQk5mTmZrRGZNU3RFZ2pidHJjbm0rRmVPSkQ3RHM2MWFTZ3JZdHdx?=
 =?utf-8?B?bkNBeGpTMlJ0c1lHQ0hRR0NTa1A0cjRWNHg0YWs3SXBIUkVNRXlRSE5Db3pp?=
 =?utf-8?B?UnpjVEZIQWhjZGltSlhoZi9RNGVDbElJNWdPVTNHazZDYVh1dGM3WUxsSXV1?=
 =?utf-8?B?c2RDYzBLTnlkRXQybDVLZnVTaVp4bU4wWlM4NHA3NmZ0TkNrY3NvM1ZRNWRM?=
 =?utf-8?B?cVd1OHFTQS95dEZocjh3M1A4ZitKNjJSbjlFWTRka2h1M3NhVFNydWhsK3ow?=
 =?utf-8?B?VVlIVkhpRkZISXNPZHdRQlRTa3VIMDM0RWhSV2VtbDdoMkVGcTkxZzEzKzll?=
 =?utf-8?B?eUY0bHFvdTZaRm4wVVVROWM1MGpjVWNvNkVyQTVabHdaeFU0NmM1eGE0Rmlw?=
 =?utf-8?B?RGRCK3FtVDY5akdiZTZwQUZHeXJSR1EwVDNCMENUZU5xb2V5ZnJpN2NvbWYr?=
 =?utf-8?B?a0xtaTlyS1lLcktMODFXMWoyTmd5TXJGSEZYTHdiTDUyNTRTZzFJYmxUQzJV?=
 =?utf-8?B?ZXo3b1NmUnZjcFhyK0lkckQvRWEwMFVweGZjazk1OWFhK3VwSUdHSnlSWFd6?=
 =?utf-8?B?b0hicFczV3h6YzBQVFpYYmZ4aEpvKyt0M3VVV25FS0lRSnlJNE9xTzFKeE9L?=
 =?utf-8?B?OHJ0aSsrd0ZIU0t1ZXdXb05GbkZnZkh2QWc1V21VNVBiejFSdGtYRGxQVDZN?=
 =?utf-8?B?akdLbzl6aTRtQTFEN00xRmxZNE9XbHdYaE4yMWFyeEx0alJGS0hDL3ZGRjEz?=
 =?utf-8?B?S2VDVjVSeGNCM08xa08rMFNTRjZKMTlzRU9PTHFzSzhBdzZOdTBUWW1ZdURQ?=
 =?utf-8?B?aisvODJESllXT1B6U2JoMHZoMUR0bHNNU21QU1Bsdm84YmtIY3YwUHJ3SjJC?=
 =?utf-8?B?Z2NUeFI5aVBGSkVRUnU1dHZkRTJ5c1QxSExnN0hPdXVnMTI4TVdWL3kwR3ZD?=
 =?utf-8?B?UWtuNjdIUXB4Tk9Fb1BTM2VYRWlKUFd0dXVtWWVzeTVKbDUzQnpnUktxRmpx?=
 =?utf-8?B?WThtY2dweG44RFowQlVGMjNuSU40NFp0TmZXcGlXQ1NwUk1JbUlJamE0QlIy?=
 =?utf-8?B?WGRuR2syUk05WjEwTzJWcG1kVXh6aFJ0TGtzejNNZW9NVGFBa3NYR1kzdXBx?=
 =?utf-8?B?YUJoSkFnNTZuekVrRG94WHJ2aXovRFNDMXp4NUp0SjlUN3hGcEdzS29Od2xF?=
 =?utf-8?B?ZFMzSXBZNldPdHhuaTZEWWY3WEJETVVndmFlT0JheHRORE04TVhPSHhsMkJO?=
 =?utf-8?B?NTRBWFJEMnRWazI3ZWlZMUhmOENqYktEQ3BQWVBWQ3NUdzJYN1lYcmYxQ3RU?=
 =?utf-8?B?Z2VmT2ZTcGpvOFpTRVRjSkJTcUhEVE9uS3pCN0hQanlPa1NjMk0yK011UkY5?=
 =?utf-8?B?UHprYk9LRUYzMi9pTmRKNWszOEx1ejJIL2c4NXk2TGtwYVpJamNRUnFUZStI?=
 =?utf-8?B?MEVwdHJEdzBVeVdKS09CYk9VVGptN3A5TWxQc0I3YS83dDBDZ0dVZ3FRS2ZX?=
 =?utf-8?B?WG83MVRmcnBTUmVLK1g5WFlPMEU3ekNtZkl0U0xtMlhONm50SHBsTXBOM0lz?=
 =?utf-8?B?eW9vR0hoZXZyalRpQktFbStJaW5ONVd1TmVkU0FwM1VGb1F1SDRFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9739033-3db1-462a-16a6-08da31cecbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 15:15:48.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToJARxQPLeTKO0ynJxzXzCXxa+/vcM8MkvbKvUe9vb62ztKgQJdX4O4gs5lA1plyV93W3UmKFeT44AgW+U1NDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8206
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGkgVG9tLA0KDQoJUGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT4NCj4g
U2VudDogTW9uZGF5LCBNYXkgOSwgMjAyMiA2OjE0IFBNDQo+IFRvOiBEYW4gQ2FycGVudGVyIDxk
YW4uY2FycGVudGVyQG9yYWNsZS5jb20+OyBNb3JpdHogRmlzY2hlcg0KPiA8bWRmQGtlcm5lbC5v
cmc+OyBOYXZhIGtpc2hvcmUgTWFubmUgPG5hdmFtQHhpbGlueC5jb20+OyBYdSBZaWx1bg0KPiA8
eWlsdW4ueHVAaW50ZWwuY29tPjsgV3UgSGFvIDxoYW8ud3VAaW50ZWwuY29tPg0KPiBDYzogTWlj
aGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+OyBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9y
Zzsga2VybmVsLQ0KPiBqYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gZnBnYTogenlucTogZml4IHp5bnFfZnBnYV9oYXNfc3luYygpDQo+IA0KPiANCj4gT24g
NS85LzIyIDU6MTEgQU0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+ID4gVGhlIHR5cGUgbmVlZHMg
dG8gYmUgdTguICBUaGUgdHlwZSB3YXMgYWNjaWRlbnRhbGx5IGNoYW5nZWQgdG8gY2hhciBhcw0K
PiA+IGEgY2xlYW51cC4gIFVuZm9ydHVuYXRlbHksIHRoYXQgbWVhbnQgdGhhdCB0aGUgenlucV9m
cGdhX2hhc19zeW5jKCkNCj4gPiBmdW5jdGlvbiBuZXZlciByZXR1cm5zIHRydWUuICBUaGlzIGJ1
ZyB3YXMgZGV0ZWN0ZWQgYnkgU21hdGNoIGFuZCBDbGFuZzoNCj4gPg0KPiA+IGRyaXZlcnMvZnBn
YS96eW5xLWZwZ2EuYzoyNDUgenlucV9mcGdhX2hhc19zeW5jKCkgd2FybjogaW1wb3NzaWJsZQ0K
PiBjb25kaXRpb24gJyhidWZbMl0gPT0gMTUzKSA9PiAoKC0xMjgpLTEyNyA9PSAxNTMpJw0KPiA+
IGRyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYzoyNDYgenlucV9mcGdhX2hhc19zeW5jKCkgd2Fybjog
aW1wb3NzaWJsZQ0KPiBjb25kaXRpb24gJyhidWZbM10gPT0gMTcwKSA9PiAoKC0xMjgpLTEyNyA9
PSAxNzApJw0KPiA+DQo+ID4gZHJpdmVycy9mcGdhL3p5bnEtZnBnYS5jOjI0NjoxNDogd2Fybmlu
ZzogcmVzdWx0IG9mIGNvbXBhcmlzb24gb2YNCj4gPiBjb25zdGFudCAxNzAgd2l0aCBleHByZXNz
aW9uIG9mIHR5cGUgJ2NvbnN0IGNoYXInIGlzIGFsd2F5cyBmYWxzZQ0KPiA+IFstV3RhdXRvbG9n
aWNhbC1jb25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZV0NCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBidWZbM10gPT0gMHhhYSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+
fn4gXiAgfn5+fg0KPiA+IGRyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYzoyNDU6NTA6IHdhcm5pbmc6
IHJlc3VsdCBvZiBjb21wYXJpc29uIG9mDQo+ID4gY29uc3RhbnQgMTUzIHdpdGggZXhwcmVzc2lv
biBvZiB0eXBlICdjb25zdCBjaGFyJyBpcyBhbHdheXMgZmFsc2UNCj4gPiBbLVd0YXV0b2xvZ2lj
YWwtY29uc3RhbnQtb3V0LW9mLXJhbmdlLWNvbXBhcmVdDQo+ID4gICAgICAgICAgICAgICAgICAg
ICBpZiAoYnVmWzBdID09IDB4NjYgJiYgYnVmWzFdID09IDB4NTUgJiYgYnVmWzJdID09IDB4OTkg
JiYNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB+fn5+fn4gXg0KPiA+IH5+fn4NCj4gPg0KPiA+IEZpeGVzOiBhZGExNGEwMjNh
NjQgKCJmcGdhOiB6eW5xOiBGaXggaW5jb3JyZWN0IHZhcmlhYmxlIHR5cGUiKQ0KPiA+IFJlcG9y
dGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQo+ID4gLS0tDQo+
ID4gVGhlIGFkYTE0YTAyM2E2NCAoImZwZ2E6IHp5bnE6IEZpeCBpbmNvcnJlY3QgdmFyaWFibGUg
dHlwZSIpIHBhdGNoDQo+ID4gd2VudCB0aHJvdWdoIHNpeCBvZiByZXZpc2lvbnMuICBUaGUga2J1
aWxkIGJ1ZyBmb3VuZCB0aGlzIGJ1ZyBlYXJseSBvbg0KPiA+IGJ1dCB0aGUgYXV0aG9yIGluZ29y
ZWQga2J1aWxkLWJvdCBhbmQga2VwdCByZXNlbmRpbmcgdGhlIGJ1Z2d5IHBhdGNoDQo+ID4gYW55
d2F5Lg0KPiA+DQo+ID4gQWZ0ZXIgdGhlIHBhdGNoIHdhcyBtZXJnZWQgdGhlbiBJIHNlbnQgYSBz
ZXBhcmF0ZSBidWcgcmVwb3J0IGFuZCBYdQ0KPiA+IFlpbHVuIGFza2VkIGFib3V0IHdoeSBvbmx5
IHRoZSBhdXRob3Igd2FzIG9uIHRoZSBDQyBsaXN0IGZvciB0aGUgZmlyc3QNCj4gPiBidWcgcmVw
b3J0cy4gIEEgdmFsaWQgcXVlc3Rpb24sIGRlZmluaXRlbHkuICBJIHdpbGwgcG9rZSB0aGUga2J1
aWxkDQo+ID4gZGV2cyBhYm91dCB0aGlzLg0KPiA+DQo+ID4gSG0uLi4gIEFjdHVhbGx5IGxvb2tp
bmcgdGhyb3VnaCB0aGUgbGlzdCB0aGVyZSBoYXZlIGJlZW4gYSBidW5jaCBvZg0KPiA+IGJ1ZyBy
ZXBvcnRzIGFib3V0IHRoaXMgYmVjYXVzZSBib3RoIFNtYXRjaCBhbmQgQ2xhbmcgY29tcGxhaW4g
c28NCj4gPiBrYnVpbGQgc2VuZHMgZHVwbGljYXRlIHdhcm5pbmdzIGZvciB0aGlzIHR5cGUgb2Yg
YnVnLiAgQW5kIHRoZW4ga2J1aWxkDQo+ID4gc2VuZHMgYW5vdGhlciB0byBzYXkgIlRoaXMgaXNz
dWUgaXMgc3RpbGwgcmVtYWluaW5nIiB3YXJuaW5nLiAgQW5kDQo+ID4gdGhlbiBYdSBZaWx1biBz
ZW50IGFuIGVtYWlsICJLYnVpbGQtYm90IGlzIHN0aWxsIGNvbXBsYWluaW5nLiAgUGxlYXNlDQo+
ID4gZG9uJ3QgZm9yZ2V0IHRvIGZpeCB0aGlzLiIgIFNvIHRoYXQncyBhdCBsZWFzdCBmb3VyIHB1
YmxpYyBlbWFpbHMNCj4gPiBhYm91dCB0aGlzIGFuZCBvbmUgb3IgdHdvIHByaXZhdGUgZW1haWxz
IGRpcmVjdGx5IGZyb20ga2J1aWxkLWJvdCB0byB0aGUNCj4gYXV0aG9yLg0KPiA+DQo+ID4gVGhl
IGtidWlsZC1ib3Qgd2FudGVkIHRvIHNlbmQgKmFub3RoZXIqIHdhcm5pbmcgdG9kYXksIGJ1dCBJ
IGRlY2lkZWQNCj4gPiB0byBzZW5kIGEgZml4IGluc3RlYWQuDQo+ID4NCj4gPiBMT0wuDQo+ID4N
Cj4gPiAgIGRyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYyBiL2RyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYyBpbmRl
eA0KPiA+IDZiZWFiYTlkZmU5Ny4uNDI2YWEzNGM2YTBkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZnBnYS96eW5xLWZwZ2EuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYw0K
PiA+IEBAIC0yMzksNyArMjM5LDcgQEAgc3RhdGljIGlycXJldHVybl90IHp5bnFfZnBnYV9pc3Io
aW50IGlycSwgdm9pZCAqZGF0YSkNCj4gPiAgICAqIHRoZSBjb3JyZWN0IGJ5dGUgb3JkZXIsIGFu
ZCBiZSBkd29yZCBhbGlnbmVkLiBUaGUgaW5wdXQgaXMgYSBYaWxpbnggLmJpbg0KPiA+ICAgICog
ZmlsZSB3aXRoIGV2ZXJ5IDMyIGJpdCBxdWFudGl0eSBzd2FwcGVkLg0KPiA+ICAgICovDQo+ID4g
LXN0YXRpYyBib29sIHp5bnFfZnBnYV9oYXNfc3luYyhjb25zdCBjaGFyICpidWYsIHNpemVfdCBj
b3VudCkNCj4gPiArc3RhdGljIGJvb2wgenlucV9mcGdhX2hhc19zeW5jKGNvbnN0IHU4ICpidWYs
IHNpemVfdCBjb3VudCkNCj4gDQo+IFRoaXMgaXMgY2FsbGVkIGZyb20genlucV9mcGdhX29wc193
cml0ZV9pbml0LCBhIGZwZ2FfbWFuYWdlcl9vcHMgZnVuY3Rpb24NCj4gdGhhdA0KPiANCj4gdXNl
cyAnY29uc3QgY2hhciAqJyBhcyBhIHR5cGUgZm9yIGl0cyB3cml0ZSgpIGJ1ZidzLg0KPiANCj4g
SSB0aGluayBjb25zdCB1OCAqIHdvdWxkIGJlIGEgYmV0dGVyIHR5cGUgZm9yIGFsbCBvZiB0aGUg
ZnBnYV9tYW5hZ2VyDQo+IGluc3RhbmNlcy4NCj4gDQo+IElmIGZvbGtzIGFncmVlLCBJJ2xsIG1h
a2UgdGhlIGNoYW5nZS4NCj4gDQpJIGFncmVlLCBwbGVhc2UgY2hhbmdlIGl0IHRvIHU4DQoNClJl
Z2FyZHMsDQpOYXZhIGtpc2hvcmUuDQo=
