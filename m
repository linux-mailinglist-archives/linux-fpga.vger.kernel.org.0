Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C1542C7C
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiFHKCU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbiFHKBt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 06:01:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB52F59959;
        Wed,  8 Jun 2022 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654681105; x=1686217105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9VID90B5klThcLK2J3lbP8nkVgFkOBPjrg3roxKu81E=;
  b=GsixPv+kJIY0Rtp0L5k2TFgB55IQfFmc9IzgN8nOtWW0PPKALRj7h50w
   rfO/WEDtY+S81CADeASDwvL72mE5e2jWprtaFyACOQzUOW2iYV/YFL8WC
   h403XXBXGRyDTIwzPuP0TFTuI9ghJS6mztlxtsZKQHQ2gg+9yFZM7vSUq
   Jz0DmJNYOh9WLjY2C7k1kb2b0qtKtYjNa692nBbM2IlKkBcEkq4OBeenb
   bN0E80u37IgwodI4GQD13xtihhsWuXZHheTMQNmBZZXs76Y2oCD7pXm+M
   QSKjLWt4Z/yRzHl6elSTpkczjhc2W/xTsWJOPLu94v4a6LCadGtd5hYlD
   w==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="159366943"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 02:38:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 02:38:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 8 Jun 2022 02:38:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCgyS4UJg2xKizvScTxCnf0ir2b1fJvrHrtgX0mLxpn2SJI9R6TAt+8cjEzOLpkttm3M1ubwm3cveAkQO4t9hLJoQdFUig+HYxMGjf8avSCbdjz8uhnZgSoYZ+rboh1/7zdBR/8lN4lZr4W08qW4xBbOB91Cz3WI25opQwd8CvGPGuK9dl8rXArN+5k64uMJasG9CN+IrtJ8bf9vor1KErMF9MJNHRJvSBHCRmO7buerx5wI+0YylqZaUgQy0IgJJJqy9zPu0hGcW5bYpzqV+BxFlVExNR2FfSz9NLFZYNQ4stMyKyXL/hqrQwUziKhH4m4YMM9cejX+T3lHgBLoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VID90B5klThcLK2J3lbP8nkVgFkOBPjrg3roxKu81E=;
 b=hIDBawsPoq/Iy6OacPkagH4jlXuGnPceykQGiQnsu61CGNiy8be9jGJ72b+UtNALKndQcswYoIGOcBUo352F+1umO/z3wnKCDI1CBlduOWes5iF4VZ4LlY1fcf6yWLgRkPK9vUxELTLBWoBOfe5TGjVrbQ+LtZC0/p0go1Fnf/l6hGVDw/5eCqYZd2P2mVOwC+uTPr0tzKD5TuOkrwh/U1Kz/VVDbStCvb5r59KyO7KzAWmo1kyRjNXY/t9wQtL/uz93p5ZdVHT69vFpJymDe9o+idf/PI3Jh/Fzz8ZtUyNGPCs75Z973Frf/wtSd8EBctcfNvKRfSGOjmkPQLgsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VID90B5klThcLK2J3lbP8nkVgFkOBPjrg3roxKu81E=;
 b=YKoAvNKj1RhYv+on2NrW6uQOWRSWkBkDyPWsq0GUWEPDEnb+svmD+qivUViP2EheYTWBkhW5cBOyTcCQGSE8FDLONhJbl686+Xzhd8/90wEdMC9pFuwOxGY7gaBxLFXKFihD+j4t4HAVWe0C3M07aaKGgw0rQ/iHvSqcPBkgpIU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5275.namprd11.prod.outlook.com (2603:10b6:408:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 09:38:20 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 09:38:20 +0000
From:   <Conor.Dooley@microchip.com>
To:     <yilun.xu@intel.com>, <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <trix@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <system@metrotek.ru>,
        <robh@kernel.org>
Subject: Re: [PATCH v16 3/3] dt-bindings: fpga: add binding doc for
 microchip-spi fpga mgr
Thread-Topic: [PATCH v16 3/3] dt-bindings: fpga: add binding doc for
 microchip-spi fpga mgr
Thread-Index: AQHYemJw+BcLSw2JXE+ZgubfHn4DV61FPYuAgAAEPYA=
Date:   Wed, 8 Jun 2022 09:38:20 +0000
Message-ID: <6f408cef-a013-3e62-22b9-fe14d9f6a799@microchip.com>
References: <20220607111030.3003-1-i.bornyakov@metrotek.ru>
 <20220607111030.3003-4-i.bornyakov@metrotek.ru>
 <20220608092139.GC481269@yilunxu-OptiPlex-7050>
In-Reply-To: <20220608092139.GC481269@yilunxu-OptiPlex-7050>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47e4e7a6-83ba-4c84-8cfc-08da49329fbf
x-ms-traffictypediagnostic: BN9PR11MB5275:EE_
x-microsoft-antispam-prvs: <BN9PR11MB5275CF82152D12053B0B163598A49@BN9PR11MB5275.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zTFGotbBhYciBgLS3tuCbxoiLU0AXCuJ6+TbOSPQwHkk3prtPGIhQCcOTw1kgiWQ8feOZamFhrjtKnUHEFHnKrKInzbguVtpQZXl5HDccGXQ598mfuzF10AGj1iajv694ibNkJvpch8HLeqv15c5l9g817yE0dd6dOYD7JivYnQbGPTjufUCh+o9KZ4PLxK7IKVa6UMA2DFfertZs07K6F5AxoG1eje0/kMiJrE3NRpLZxRgWeZHLIA9H/VRKZcSkyCDRlc6Fnx3iKJ7dkzEiOkrxgYuQuIo3UNXwIIfne6QULM+zzuDu+4KtaeAzd8m4RMGmfnTmL6zfcTvwnkmUiPQnzccduPpXkTPA+Bj3Hqz/N0drfXUt3E6JA8sctvKihCn4hCtPlOyKpHos2BWP/kCP1k6a/armNwCh9ZBWx3bRbsTXcOr9zm7ksV9Iu4gryEIZVXaDN8k92jgWBZGMUceDuTKCqp1Ldb5RBrH9PU3/0vQhHnfAbZ64hB0fYDpnqnnrVAaZrjp8S2XuuKyyh0JiMLcUYZikvGedzfXn5qf4AxH+TrR7TnLVSX5/+hx2Zly8Bnl9KCoiyBPB8zare1pXWvtn/oi5aPJk9UwyPVVo94UNVU3NjHzB2Z5w0cLPl4+zZq+usHmNIN+rVCZO4c8fanHDMKUTgY2pf8wqUv/1R7gKmPhIUd2WcTBHlB6Pa2eaJiZ5WR1mEBiz3bCxTuO5V2Vlf9aLnJFM+rDH3oOQThqMQNoH9RcytG7XDia4JOwdI7SAYuxnzKi/d4+WTnIvwIvMMF5VsqoB44xc5+sgxccIMOI+A0rRv74AbPgGlD0dpYtAy6UXrGM3ARSgi+eDiX6DH9dR8ctDv9V6GPHpdSNGQLUgwHNuLS6k1+gs7BAJA0AqP0tBEPgCNvI+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(64756008)(66946007)(6506007)(83380400001)(66556008)(53546011)(4326008)(110136005)(508600001)(966005)(8676002)(86362001)(186003)(6486002)(2616005)(31696002)(66446008)(66476007)(31686004)(91956017)(71200400001)(38100700002)(8936002)(2906002)(54906003)(76116006)(7416002)(26005)(38070700005)(6512007)(122000001)(316002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZua2drZzZWem5OcTU3Z1lPa0Mrc3BZYWJjalRFVGs5ak42WTVxWDZ5NGwz?=
 =?utf-8?B?NUtZcWdxcDVVTkFVUUMvZGJmTkhzYldzeFBxc3U4cVcxY1lXRmpPZEdnZ2dm?=
 =?utf-8?B?Qjh2UFFJVDZKZFJLSkwyYk15d3ZiejNEZ1pIWXRRRFNOWitRbTMwOEdhaksx?=
 =?utf-8?B?b09Hd1p3dEdlTjFpU1J4Qm8vNUJMT0dpWkVYWjFtQmp5aWdkMjRlUStiZTY4?=
 =?utf-8?B?bVlzSnVjU1JVVFlZUXZhWC9TTXRpaGQ2S0tna3Bua0tTRXp2Tk5nV0s3VmNk?=
 =?utf-8?B?Sk9FcDY0S2t0V0xIWGE1VDlFdmRwWXd2UFE1ZDlaUXJVQm85eExjemU5QnBn?=
 =?utf-8?B?ZE1qeWF6VHlMWnU3ZXlFeTExMjBPODA5V1J0dEJ3cFo1eXV0MFNRTXcwYjdJ?=
 =?utf-8?B?R1VCY1dLNkVQQ01TWGJHMjZ5TG9hQ09pTkdHdFErYkt1bHpydmFkKy8rdk1Z?=
 =?utf-8?B?YnAzZjBtbjVkaGF5QzBoaDBoMnBPakt0L04zaVdVVDl5NVFDTmVvMnl2WDlF?=
 =?utf-8?B?d1pjVGlJQjdDdDN1U1pVcTZyYmZ3cXhQLzN2cEh2dnlMcjIybXl2cEZLRm5o?=
 =?utf-8?B?WUdxZTJDcmdGNVJLQytuNHVRS3JUSHY1UUVnM3hTdlVJeStMc3F0eEJ2aWd6?=
 =?utf-8?B?UTRLd0t6NGpNekVhNWJWMDI2UUFBSkUxS0M2NlVINWpUaVNiUldhQUVFZFVw?=
 =?utf-8?B?eXF1UTlqbGgwY3ltS1oxM0JaaFhpM0hpTjZRMXQzaWhtbkppQjVXVWg0UUVV?=
 =?utf-8?B?TS84Mm12eU9jTzRMZW5LQzZaaEMzMlNWbzNZSkZDZjJXa0I1ZXZLUE1PSDNo?=
 =?utf-8?B?M0RJSlVNMVV0Sis2bGlHV1l4K2VOS2dWd1VpWmxIYlFndmd3WEhMaVpvczVl?=
 =?utf-8?B?MWNySUJ0bC9RRlgwcUVMa3ZXMlJkbGE0ZzJUUmw2R2c2VWlvZTRwKzR3d245?=
 =?utf-8?B?bmFhaXRxVFdiWnA0WWpxUC9Jem1xNFBIVTBuZ1o0Y05oTVpKNGJ5SUhueVBq?=
 =?utf-8?B?QnpLbWtsaEwzWEZid0dEazdMMm9lYmhvRjdmUU45cjZvWmw1S2VkVnJFd3Rh?=
 =?utf-8?B?aVFiWFhXeVFUZjZRTGkwUCt4aTlFSGYybXJUbjZtR2VDR0hVV0JUK1RydW5I?=
 =?utf-8?B?SWkwc2N2SmZxeHNKWExKcGJoQmEyazNULzNLUzB6bjk1WjFUclovQXEvVGkx?=
 =?utf-8?B?dWl0T09hTzFSSmVtNnZCbUVCWThTdWNjS3hOTWtQeFZ6aTg3MHpoWlpKaHZy?=
 =?utf-8?B?c0MrQ2M0MkdJUUZnQTVYL01GQWJya2NkRy9mWnU4NUo0Sm40T2FCM1VJOGlh?=
 =?utf-8?B?M1BiYlBFL2FIVTVRdU1oRG9xeWpZQWVVZitOVTFqOEpTVDQycWh3STh3UlJW?=
 =?utf-8?B?WGVZL3lIUGw3endva0l6UGY2V2pEd3NKcFg0VEd4QUZIS2xmT0c3YTNnQXJh?=
 =?utf-8?B?amo1Qm9xQzloVWF3aWVkYkRTZkZGTG1EdlBERDZmNTk4ZEJqR1k1QkRBWUJO?=
 =?utf-8?B?SGlQVFRmbUZQT3g4b204T21ENEtBUDZNOHZtR3Z3Qm9mY29VUW5vRFc3SkU4?=
 =?utf-8?B?enNHSFFjcWtWWmpPQS9lbUZXeGZiMTNNWjFkYURkTDJXa3Y4ZGwwMkxrdTRC?=
 =?utf-8?B?c3hrMStjTTVRQno1c2hUZVp2cVJwazZ5UVRUM09zVG5ONGNpc2RkTDBJazBp?=
 =?utf-8?B?YW02K2dNcFVTNVdhOTdKRzNQc3ZITEZnbDhEbm1JbUtDRytZQ2pWU1Y0aXNY?=
 =?utf-8?B?clVuNkFvYTE4UU1teHV2S1pQTGZLOFFNNmp2Mk9pSlhuZmpxdUpjY010NXp0?=
 =?utf-8?B?cEE0Qm9uR051Vms1SVI1VU1JM3VLbk9tcS9iUHFIRXFUUWhmT3pvQVdZRy8w?=
 =?utf-8?B?M3FKVFJ1ZHA2bE1UQUIvNEIwNkJpOXB3aWNyRThmL0N2WWxkZmU5d3RBY1Zv?=
 =?utf-8?B?eWdXcFp6SHBCeDVwUUJMME5POTJNZDcyaW50VXpHOGkwZ1krREdvWkxQRlZH?=
 =?utf-8?B?NFdRYkpJK1BSVmxuRXZ6T2doVGZZR2lpdE9GM0xKNk9TS2tYTFFDQzVVSEZy?=
 =?utf-8?B?SGFNdHNDRm12V1E1cW9qT2pzMWVIUnpRNGdKQUVVMkxNeWV3bWV5WnV1WXo0?=
 =?utf-8?B?dUdybTAyTzZ5MUU3QXh6M2NWV1d1Y1hXZFlSa3NDZkZGelJNVXlTV0w1UXRi?=
 =?utf-8?B?N3pXZTBYaW12SVRpUzVLemVYS21UU2ZkMkR2RXhSSWJDR1NKWUpLZFJCQ3Uw?=
 =?utf-8?B?SlA3VUkzb01YWHdHQ3FrdzZ5SXZQengvUTJiNk5jV1JKNVhGL0xYYTZFNEhP?=
 =?utf-8?B?OTlsZUpvYW5yODNDYVQreUg5Rzd4MFR6WXJYaktmQmExbjRWWGl5QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DDE5927931A5A47B120ACAFE02D357A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e4e7a6-83ba-4c84-8cfc-08da49329fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 09:38:20.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FPWD1ol1NC2xlRr3TMSMkYynOApVFZwtPL0drzhRdoPxeVFjzwZ6YNR7TxbF4eweDzvEL4t3g7fTHZ3Bv2WZUxqpXAINt+5pmlpmzCZ72qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5275
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMDgvMDYvMjAyMiAxMDoyMSwgWHUgWWlsdW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCBKdW4gMDcsIDIwMjIgYXQgMDI6MTA6MzBQ
TSArMDMwMCwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+PiBBZGQgRGV2aWNlIFRyZWUgQmluZGlu
ZyBkb2MgZm9yIE1pY3JvY2hpcCBQb2xhcmZpcmUgRlBHQSBNYW5hZ2VyIHVzaW5nDQo+PiBzbGF2
ZSBTUEkgdG8gbG9hZCAuZGF0IGZvcm1hdHRlZCBiaXRzdHJlYW0gaW1hZ2UuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogSXZhbiBCb3JueWFrb3YgPGkuYm9ybnlha292QG1ldHJvdGVrLnJ1Pg0KPj4g
UmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPg0KDQpOb3Qgc3VyZSB3aGF0IHRo
ZSBTb0IgdGFncyBhcmUgZm9yPw0KSXZhbiBjYW4ndCBhZGQgdGhlbSBpbiB0aGUgY29ycmVjdCBv
cmRlciB3aGVuIGhlJ3Mgc2VuZGluZyBoaXMgcGF0Y2hlcy4NCkFtIEkgbWlzc2luZyBzb21ldGhp
bmc/DQoNCkNvbmZ1c2VkLA0KQ29ub3IuDQo+IA0KPj4gLS0tDQo+PiAgIC4uLi9mcGdhL21pY3Jv
Y2hpcCxtcGYtc3BpLWZwZ2EtbWdyLnlhbWwgICAgICB8IDQ0ICsrKysrKysrKysrKysrKysrKysN
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxt
cGYtc3BpLWZwZ2EtbWdyLnlhbWwNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvbWljcm9jaGlwLG1wZi1zcGktZnBnYS1tZ3IueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxtcGYtc3Bp
LWZwZ2EtbWdyLnlhbWwNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLmFlZTQ1Y2IxNTU5Mg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvbWljcm9jaGlwLG1wZi1zcGktZnBnYS1tZ3Iu
eWFtbA0KPj4gQEAgLTAsMCArMSw0NCBAQA0KPj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0K
Pj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZnBnYS9taWNyb2NoaXAsbXBm
LXNwaS1mcGdhLW1nci55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBNaWNyb2NoaXAgUG9sYXJm
aXJlIEZQR0EgbWFuYWdlci4NCj4+ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gSXZhbiBC
b3JueWFrb3YgPGkuYm9ybnlha292QG1ldHJvdGVrLnJ1Pg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9u
Og0KPj4gKyAgRGV2aWNlIFRyZWUgQmluZGluZ3MgZm9yIE1pY3JvY2hpcCBQb2xhcmZpcmUgRlBH
QSBNYW5hZ2VyIHVzaW5nIHNsYXZlIFNQSSB0bw0KPj4gKyAgbG9hZCB0aGUgYml0c3RyZWFtIGlu
IC5kYXQgZm9ybWF0Lg0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0K
Pj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gbWljcm9jaGlwLG1wZi1zcGktZnBnYS1tZ3INCj4+
ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgZGVzY3JpcHRpb246IFNQSSBjaGlwIHNlbGVjdA0KPj4g
KyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgc3BpLW1heC1mcmVxdWVuY3k6IHRydWUNCj4+
ICsNCj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsN
Cj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+
ICsgIC0gfA0KPj4gKyAgICBzcGkgew0KPj4gKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPj4gKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKyAgICAg
ICAgICAgIGZwZ2FfbWdyQDAgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsbXBmLXNwaS1mcGdhLW1nciI7DQo+PiArICAgICAgICAgICAgICAgICAgICBz
cGktbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47DQo+PiArICAgICAgICAgICAgICAgICAgICBy
ZWcgPSA8MD47DQo+PiArICAgICAgICAgICAgfTsNCj4+ICsgICAgfTsNCj4+IC0tDQo+PiAyLjM1
LjENCj4+DQoNCg==
