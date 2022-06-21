Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C75536A0
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353157AbiFUPsz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353114AbiFUPsy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 11:48:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE4C2BB3E;
        Tue, 21 Jun 2022 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655826532; x=1687362532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B/FJvZQWI7rIN4xPGIrTzXZGXDsvgcNg9TUDBEcTT/0=;
  b=hYuzqjPbTZwfemJP44owMERJXQrERjXiwSkJGZDqqHz+Jn2lkwE7Kgmo
   t4Gev6/uhwKlpTqVoerb8w0gMzaEa/sIKrBlhogKw63X3n1N7/aPsM/Ws
   vykMMTFjfzs1lLL5yDk2QetMXfEES4QW6FQXfIy0QxcxDGl+ckqPA0Mar
   nxiKjSdqyHFYrdjmUKOLaP97GlEaRXCVc7sB/0PiRxEaiRme1iYhJtP0N
   xJC9LZ8Q7KaX0kVKp4S8i7UBTCxQwQdPtsU7AUSukWEnxPeNEUeg5B0fZ
   aDhQ9aaxZ8mWB8ARLQ/z+ndsChi7bCEvfxotYtd6HpYjWPwFdU0VunCKR
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="101058699"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2022 08:48:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Jun 2022 08:48:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 21 Jun 2022 08:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXk6YSQAVKo8BDeShSkI6qfDBik9u3vt2VSpXYI6grdGQPVX8mNJxHhfwY+B0Pp//exphOaz98YN7QH/FccHzfjxHIkOFdV8kSlUyYqoZCG9P0ZyiLyPHnVzqk8bqbIUFvfdDU5frXLE+9XFPaTlVLb7T8n77kj1PYY6PhRy+pZkgUhyejAV27+jPfcBIO3rqU6bMol6SvnhaJqLWyY2jc9qe2QYql2l7G/Q5WWfDOs7R2LjZtn+2cpdWnfPbPLptIjxBm5a62AbBGnmXlNBaNr7smdFjr0K3FOcIj2baT1yQI4z0xK06wyD2pmBQi/U5DHZ4WGviuN4M7q4/Bhzxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/FJvZQWI7rIN4xPGIrTzXZGXDsvgcNg9TUDBEcTT/0=;
 b=TjuDsBTC4R8fsQ318NAQ69vtvIM5RsVxamt3saWBDx3SKw5oApIBb1gHZ6HeDWicrjD6UiHp9DLHJQQJ+LF+2hy0EGQ9Fe3mmmXEUdm3sdghX3C/a/eowNI5SsSQWKKtXy7DV/SDZaQnmsk2W2m0Xx3GOvpAPyvrDWq1PYxVQz1/nq1BZMdmDxtFUtmGoR1bGFWra3JgGZDa3l27PjyLyzRwjNNuJNu+zqocRwDAcOELTaYaH21WgXgdMlIp17uQPqKCL8B43JcTjh4J4S+R2dY6OHI4V68k8Uh/b4nXKFwTTqG/KnMzHQzOYjKtXpZJPCA49XozlYqme2P8sZF24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/FJvZQWI7rIN4xPGIrTzXZGXDsvgcNg9TUDBEcTT/0=;
 b=Fub1LwOYEBgilxYc2/hBUb7C2Zgfr/sBa5C0xT2Tpi2juGVYnom24d67pHI6/82D6BbY36np63ynmh6s4QyhToj1pRNsdKyQGzVZzNcLCxF+cNk4y0s44Z32Fg0Iim2Cmo1scH44cinX1sIWbyTMnsXcKgPtTco3utOCE/dBZwU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 15:48:45 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:48:45 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <corbet@lwn.net>
CC:     <Conor.Dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <system@metrotek.ru>
Subject: Re: [PATCH v21 5/5] MAINTAINERS: add Microchip PolarFire FPGA drivers
 entry
Thread-Topic: [PATCH v21 5/5] MAINTAINERS: add Microchip PolarFire FPGA
 drivers entry
Thread-Index: AQHYhYU8WGST5RGK0Em7/hZxgGEt/61aAbyA
Date:   Tue, 21 Jun 2022 15:48:45 +0000
Message-ID: <78f97ca4-f124-ae5d-a46a-ec0a1f3c0fe7@microchip.com>
References: <20220621153847.103052-1-i.bornyakov@metrotek.ru>
 <20220621153847.103052-6-i.bornyakov@metrotek.ru>
In-Reply-To: <20220621153847.103052-6-i.bornyakov@metrotek.ru>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c296967-cdd7-49aa-92b5-08da539d8663
x-ms-traffictypediagnostic: SJ1PR11MB6131:EE_
x-microsoft-antispam-prvs: <SJ1PR11MB61315D7ACAE32A3D31A9FA8A98B39@SJ1PR11MB6131.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1xsb+ZbZllx0E89/wV07E5silpXEPAdF5dunPrwa9Uj8HQBoyzYxMK7DsW9y5gS66eQ8JHc0fKCjmx2xNtIXbYqp9KWas/ZrVkhR74eCs9FtiFwQjXe4aWO4TftHbrYsAW4ttGwxOZXJvQlydEr7XjgK7QTKAj9pM8m0R+Yg0GD86UXLmTw1DkOJK2aP2by8qP5Rr2NWPQcaObOUqSZmehCBrnJXGp9oJFDl0EmBZXZKgdMR2cTJYurDiuubsNW28gltNyPVy01jCGj7w3gobcGPvyJB6jsgw/Zv0/V4htxF/u+LW0rKwGKAxWjKvhbEKgEbk8vBRUSu7nvicBjzu6TI87cW+Xnpk3PAJ3xcomTV4ubPoc5vtwGUYfY1QX2N67HlJOK6b7xijqA+XbfnLExrRrqMIe0kvK1OJpvuvDUMUN63dxtRANeSjjfVuJ4qOGfFMcWzsP5O37KQ1PwpaulZ3GAk5AJ1cKhtTiYMrx0jk6/KD46FXyOn2u6IyeIbgoSXPPM4Q7IQ4VTQ1mpCW9jQTeNn86/fcEdd7es0wXzS/4d/d/kcwjciPnFSWCDL75RS+zODQZaDIGkeHNHuMHaBAJSlqjF/oaS8oTvwibYpAldxfMjApBHMHz14vF6hXztky7iZhcCva1gOebo9xs86tJYxkdQNzvzxYGR36Er148mob2HJcN2w8+vRiKahmRTnJgvkJAJSglQ7td/gzChz2f6dIdZ2EJ8XhyFtJ7BY6Pw55q5vzS552notIMRZS8h2A/9Kka4gqCnxfKiQQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(39860400002)(136003)(4744005)(38070700005)(2906002)(91956017)(4326008)(66946007)(53546011)(2616005)(38100700002)(6486002)(6506007)(54906003)(6512007)(478600001)(66556008)(26005)(76116006)(31686004)(110136005)(186003)(122000001)(41300700001)(83380400001)(66446008)(66476007)(8676002)(31696002)(316002)(5660300002)(64756008)(7416002)(71200400001)(8936002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmVJaG1rL085YkkzNDVWVHQ0OEdEbll3THJlUlU4WGRxZUljd2RJZGNBR0lL?=
 =?utf-8?B?czhxb212dzdkNDZDVEY2R0NXa25TNnhFcUZpWkh6eEFIeGJTZll0UmcybmRL?=
 =?utf-8?B?K0U3YWtJcjJZdnZ1V1hkOEpoWTdFOEFTdTBSbzE1TENGVTAvUUx1N0QyVUtZ?=
 =?utf-8?B?RmhMVUgvb3hkMzFUNytLSzQrK0tEcTdOTGlTV3hwWmdCTUIwZGtZSHdIK1pE?=
 =?utf-8?B?dVkzZE44b0xxT1dxeldmVmp1bExidjVEZGIyRWhBYjhSTElWOTIreFpRZzRF?=
 =?utf-8?B?NlV0emhxVHVFZnpDVmFwOVdVaFc1UC9Xbm93cXByQjk2UzB2Q281b2M0MVZq?=
 =?utf-8?B?YmVaT21xS3B3Tk1ZaGMxditDbysxZ3EzODZhRXBPY3ZMRUlNb29jaWxqZ3or?=
 =?utf-8?B?RUxRMnN6eVU0cHZaLzFlMzI5a1NZUEMyejl0bEx0N0JBQmlhYmxGdit6aFFJ?=
 =?utf-8?B?NVZpS1NGYzEzdExBNFBCQ3haOHgxQ2taU1lpTW1pUGNyWnF3dXRsRjZWZmFk?=
 =?utf-8?B?c2VuVmlQK0dST01neDNWU3l0eUl3K1lDdVJFMzZkVjlmVXJSaWJEWmRJMjAz?=
 =?utf-8?B?WjBvOVNtdzA5RVhLMWNySFhIVnl2MkNRK0VNOVFzNHNTQ01IMjFhK2lTdVVL?=
 =?utf-8?B?RXJ3em9UT284dWRmbGZOQjRXNm1vcEtDdkZZb2F3TEVpZEt2bmZ4aFQrMkVS?=
 =?utf-8?B?R2ZPMXNjMVMyYmZkN1lmVVI4VEdSWUdubGNuVllDQkNwZGVYV2UvYjluZU01?=
 =?utf-8?B?UXNsUG1mNGtNTHBBMTNOWTlYMGdkZVpieEV6TUoxZ3hTa3VQYnM1WWlBeVJC?=
 =?utf-8?B?R2Q2VGpIVVViM0c1YllVSjNwY1lHbENoNUNBNFJlYU13N0xvL0R3US9zV2Ry?=
 =?utf-8?B?REFGdVd2UWxrOE9TTjh1N1JPdURoNUxURUJYNEpoRjNzTitqNy83QWYxRGNu?=
 =?utf-8?B?U0YxQXVtbDVEVGFiQ2liRkVxSmtKVlp3TXhIN0NEODZnTnMvekZHYWU4aTFR?=
 =?utf-8?B?MDVzWkpkdS90aVZuQ1JYNWtSR1ZQb1p5aHYzcUxmUzJOSTJTS28yWEpIb0Rw?=
 =?utf-8?B?cXE3aG84WVYzeFg0SSt3VzdIUmgzM0tERzBGV2tMRnJDZzRyMk5lbEl0VXA4?=
 =?utf-8?B?MWNpdE94Q2NjY1JDemplZ2toUDZONkk2OHM2RkEwZTBybGZXZUZzK3NzTzlR?=
 =?utf-8?B?ZmVaQ3pYM3Bwa0RJRGZRT1kvVnlkcEo1NFpHRHNERGI0NzlWU0ZreHZTdXJm?=
 =?utf-8?B?YjBVUkxuN2JBR0tOWjF0dXNKaFBKcHJOYmRNQnNhcHZVZUR4djd1V2JFSkt5?=
 =?utf-8?B?MXlXRHlFMjdQUGhNNVdIRy9KZWQrdUUrUkRyM0ZkSE9BSVIzZzVGQ3ZUbElX?=
 =?utf-8?B?bUxZVlhXT1ZIMzFmR2c4Uk5UZWF6aHpXS0d1eVROdUo1K24vQTQrTjJrbDhu?=
 =?utf-8?B?ZWJvZnM3d1lFSW1IZWdicDdqdHlldGVEeG15ZDBWd3BYUkFzMjBDNG1UWXRk?=
 =?utf-8?B?dUYybHA4em9rcUh2dTllaWs2OFU0Y216M3FDeGl1U3J5Zjg1cVJiMUh0bmhr?=
 =?utf-8?B?djlkTDh0T2MzNlphaGIyYUY3Zjlrd0JEL043YVViVWZ0bmpTTCswQ0d4RHYy?=
 =?utf-8?B?S3RvMmRqQzltMFRVb0dhWkFReUdvZEpmY21jaXdEU2h5TzY3blBnY3M4Y0kv?=
 =?utf-8?B?M2V4UU1hMStKaXd2NDdNQ1E5ODBQb25BeERqZHJydWh6SjltdGRKKzZZdFR6?=
 =?utf-8?B?dUxiUGVhSnlxcGF2cEE2YThkSGJHME83bXFkekhzT01NZFpSQnBjaUJ0djk2?=
 =?utf-8?B?WnhCcGtUd2xqRjFycmdsTmQxWnMwYzNTWUNJaWRRN3h0VVd6U3FrSis3VFFj?=
 =?utf-8?B?bWg1Q3VUdkhnQmpoM3M5dStaTGhXeG5VMzlPR3BYdUo0TlRsWjdtVnpSMVU0?=
 =?utf-8?B?bHJvQXoreldFRHBGeUVqYzhoYVJMYUw0MFhqbUliOEs4SE5yeTM3MmpabG10?=
 =?utf-8?B?Nnh3RFBOV2J3eU91cVphYkkyYnM1M2JVZmxqR1pyUWtTWGdaR0JSM0tmQnZp?=
 =?utf-8?B?WVNXUVlwK1ZkZlN0QUp1VjFXTDZDb3dMektuU3Q4OWdjNkE0YzVSd3cxNm1z?=
 =?utf-8?B?bHlVc0lFelpDRldRQ1BIaWFkUkZNbjRPT0JWYlJ1UCtmVXZMc3MwSEY0QmMx?=
 =?utf-8?B?RVlsRnBtTUJGaVhIcFRXd3dQV1FGRGdUa2tWZnlWVDgxTXFOeEpBNG5pemRk?=
 =?utf-8?B?M0ZUMEFHQVpTVWdXdTNUZitDTDJSV2gvQnpibDl1M25zVmpHQ2w3R2cwUlBG?=
 =?utf-8?B?dFRzWFAzUDZDV2NzNHNjL0xUV0NpcEc4cnlBdzlSblhpZTk3S2ZhbzFSQkpO?=
 =?utf-8?Q?0B6WX0ejTZb7xqvE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC7CF1B20AF68D4BA2B45E2E74C6F47F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c296967-cdd7-49aa-92b5-08da539d8663
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:48:45.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KL8yEx0mAqaosIqV9KR6fbxQYvJJ1ArJUsp8ACZdNUlvkp4h3yPh719frp+Hu++04fETSEB/dlXiUi+yvWywzzZ1187qDXrLrP6Vfvid4h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCk9uIDIxLzA2LzIwMjIgMTY6MzgsIEl2YW4gQm9ybnlha292IHdyb3RlOg0KPiBBZGQgTUFJ
TlRBSU5FUlMgZW50cnkgZm9yIHRoZSBuZXdseSBhZGRlZCBNaWNyb2NoaXAgUG9sYXJGaXJlIChN
UEYpIEZQR0ENCj4gbWFuYWdlci4gQWRkIG15c2VsZiBhcyBhIHJldmlld2VyIGFuZCBDb25vciBE
b29sZXkgYXMgYSBtYWludGFpbmVyLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBDb25vciBEb29sZXkg
PGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBJdmFuIEJvcm55
YWtvdiA8aS5ib3JueWFrb3ZAbWV0cm90ZWsucnU+DQo+IC0tLQ0KPiAgTUFJTlRBSU5FUlMgfCA4
ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBiNzc0ZjIxODI4Zjcu
LmVkMjUxNzU3NDgwNCAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRB
SU5FUlMNCj4gQEAgLTc4ODQsNiArNzg4NCwxNCBAQCBTOglNYWludGFpbmVkDQo+ICBGOglEb2N1
bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWRyaXZlci1pbnRlbC1tMTAtYm1jLXNlYy11cGRh
dGUNCj4gIEY6CWRyaXZlcnMvZnBnYS9pbnRlbC1tMTAtYm1jLXNlYy11cGRhdGUuYw0KPiAgDQo+
ICtNSUNST0NISVAgUE9MQVJGSVJFIEZQR0EgRFJJVkVSUw0KPiArTToJQ29ub3IgRG9vbGV5IDxj
b25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gK1I6CUl2YW4gQm9ybnlha292IDxpLmJvcm55
YWtvdkBtZXRyb3Rlay5ydT4NCj4gK0w6CWxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnDQo+ICtT
OglTdXBwb3J0ZWQNCj4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdh
L21pY3JvY2hpcCxtcGYtc3BpLWZwZ2EtbWdyLnlhbWwNCj4gK0Y6CWRyaXZlcnMvZnBnYS9taWNy
b2NoaXAtc3BpLmMNCj4gKw0KPiAgRlBVIEVNVUxBVE9SDQo+ICBNOglCaWxsIE1ldHplbnRoZW4g
PGJpbGxtQG1lbGJwYy5vcmcuYXU+DQo+ICBTOglNYWludGFpbmVkDQoNCkFja2VkLWJ5OiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
