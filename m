Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F61551684
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 13:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbiFTLB6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241148AbiFTLB5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 07:01:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A7D6339;
        Mon, 20 Jun 2022 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655722917; x=1687258917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wT9bHE7tbjT/zj/883GP2bj9bHFXgGpaYlsA+jfWcl4=;
  b=RHwvR4w2PEtppR8T4rUXCJVkxQcW+jrCphuAvYAR3Ipa48tFZ9vUW0+7
   IPb6dAJ+uUog2FvAKLKOlE0p/2KL7as/f0JeH713ZxhIlEzoRJ8hdAWT4
   eNMnuBFPQbd+3zUiDQuFBuTJfMsBBxR7QVoGtDdHui/9NoT8pFX9/+Ej6
   Owik6f3ZZ4FKBzbA35LdbRRbMOvbTE5litUIocC6knt196lIDt9xCIhOs
   CEY4+fRe5WlkIFA46lJt/MeeekXAjBjMBlNCZ+R5aRrqxtsMe6W2/2nFT
   MLm+wKXot8R2Hq+3+Zx3QpeTSvTMkAKU38gUt/b4zRF1C6Id8rDlUqjID
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="161109731"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 04:01:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 04:01:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 20 Jun 2022 04:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en2b6ffXOefnweS+xHhUo/WVYLPf+nSCno2DghL3Be9kvvdkmx//A40wXz6q2MjB84xOW+pZFrjDWjlTPu/JadlvXaPIuMt85U0gDXsmpCLmmfGJAFOF9cjsodeFvOgNWfYIotkj9gD1lFOUiIaGebTvC9YNMfjO2nCrVwtHiqPOmnPbbKBsjWbzxNK87OR9+cvSqqEPDfsf6kFvEMIa5p300j8QwqJsDNiKX6VEuAydlw40tmyjt1b1OIKIpgdtKroj/2nPjl8us4FkQVX3JY4hnx8SGeoO49dkQX/Jt6wol8LIP42NeZ3VpOppCptPuHaUuBquinw5ik4g51zsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wT9bHE7tbjT/zj/883GP2bj9bHFXgGpaYlsA+jfWcl4=;
 b=dR7MxJR/byDDd9/O3Cy4FlQ2rgdso20kknpynNZDwg5M7Ie8dNN6GF7adU0lPRZneBpLmmSScqeIWvvjUOnKk0ddy2X0Zh+4YvFoDI0WcIIVACPHBDwixnz59gGl8F5PCGo6t4GXK9CiWwR21KT3U1Of03gNbPe2fRUZRkoxh6rpV/57Nbbfph8Ejd5x5yAfntVrVW/U0YwVkEQCBf8I85VlwslmuDZSvtLD3IaqOKUMSAUuYvsGbJ5MqKRxRO8S0QtkAZegQcQNhdhydgsmgBSH8tkuCGspJfPvMHu8/KJRsfSro/51jXFuzd+0ZVhZvdJY1VfyxPhigPHwdxx1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT9bHE7tbjT/zj/883GP2bj9bHFXgGpaYlsA+jfWcl4=;
 b=HtO23hMah1CK9YKeFLssFakNMw49cY5spUjp3npZr+I6Fqu8a8M3Ssxkk/QC/S/6nWRtQ7m++BjUuiH4MAOmqe61LYteubIyW4zhBAU3Y5ubrcRBNknMCdYtW8BM3IkHivBT+XpXzPvg/xZ9N5gBKcGAE/32lTSV7fpi5VDYVVg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH2PR11MB4312.namprd11.prod.outlook.com (2603:10b6:610:3a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 11:01:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.020; Mon, 20 Jun 2022
 11:01:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <corbet@lwn.net>, <devicetree@vger.kernel.org>, <hao.wu@intel.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-doc@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mdf@kernel.org>, <robh+dt@kernel.org>, <system@metrotek.ru>,
        <trix@redhat.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v20 0/4] Microchip Polarfire FPGA manager
Thread-Topic: [PATCH v20 0/4] Microchip Polarfire FPGA manager
Thread-Index: AQHYglEhUIF0rn+w+UerJlcz9NRCpa1XEyyAgAEDXYCAAA38AIAAALKA
Date:   Mon, 20 Jun 2022 11:01:49 +0000
Message-ID: <695b1ea4-ed28-a8ca-8026-88dd58299393@microchip.com>
References: <20220620100745.yxjmq2qtsicxlrgn@h-e2.ddg>
 <20220620105747.2145347-1-conor.dooley@microchip.com>
In-Reply-To: <20220620105747.2145347-1-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2da3656-dba1-4d33-3a6b-08da52ac4683
x-ms-traffictypediagnostic: CH2PR11MB4312:EE_
x-microsoft-antispam-prvs: <CH2PR11MB431216988B310D11FF7AACA498B09@CH2PR11MB4312.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G6ESyrkVK+gSYfZyH5ZNrf9Xg5Rd5oueoSXQ3qPehMaNyAQhuOmj70svqjdnjxe2AGnxyxuplD63bw9nSp6qUwjlKTZTuk4Hl/Jnm8ZOajUet7A3yN1rvWtdixgPpd1wsg9JfTB2SNWJAt9nNIbKdmzUVaFZpapdw52T8bn1RrRouSRbU7A3bhCPcCinRhp8BRCmGjNoYgvFWc7THZQSTiRl9NeXB/oMH+41qB4u+WI7x4vsIvGEhuhqHdWrfscdNqlsqLsDaI68IeUj6srX+yB+bozOH7+k2nTjvaj2FmnbXrc1+aysq3tJto+kDKVl5pxSE/lZyNJBTgFsfg/k1TcsoB24HeQ/+ryp5s3QV+rfjp9C+cSey1Nbwiyx2Lt8tKxjIn8Un8tm8j/EQvyyea+xYbk/fpltnNxTzAMRSvwNxzLckwK6l5mLoQANIqwbME+IjMNCqPfKlbwVLnn65n3ndlPxXEq80C8UwHWudpQWmXCm/DNWlERwAZY55qMPviX7oY4w5meLZ//dc+AmZyjqzkYnnmdTncShcvXumB1TjM5q1TQStZfU+E22qhVlJFmoae6zcpALwMzttZpoNDag38mipy8hyxkFEU4Ax6W5f8BW9io4sbJcmmtdPLWOvnrrGr0U5gwMcMI7HMkaOdRpFvt03Q6tvVFXsJ3CyEZLKe+p8UysozWrHs6TBmcEB76iXxiO7aikX+LFMr7K630JEt/RffXY4GxaU6vkqTI5tb1QMoVJNryZYVh0pf62MR/QBZAZG0Shq4V/foxBZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(366004)(39860400002)(76116006)(8936002)(64756008)(66556008)(66446008)(8676002)(31686004)(5660300002)(4326008)(478600001)(54906003)(91956017)(316002)(66946007)(6486002)(6916009)(66476007)(71200400001)(7416002)(36756003)(31696002)(2906002)(122000001)(26005)(86362001)(38100700002)(6506007)(6512007)(38070700005)(186003)(83380400001)(53546011)(41300700001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZndQNWhqd3JWR3RvcXJSWGFUVlpiVlRnVVgrNXNoTWVhS1ZuMDNUeE1yU0NE?=
 =?utf-8?B?RGN3YWpFcmhJa0dtV2lVMTdLWTI2VUFocC9sVWsvcGFUUE84SE9NdERPYko1?=
 =?utf-8?B?azEzVityaG43VzJrMVBhSEcwcmh0em1QZ0RDbFpRdGVWYXh1KzQwNnNlK3Zz?=
 =?utf-8?B?U1A3UkdsZUxxL0JyQkJEN3hKOWNNSUVTSnhmRzF5M2JvUUNMM3BiUmdMbjE4?=
 =?utf-8?B?c3Q1SngwaDhjT3Q3eTRrYVI0eStZcXVOWVRBOER0d0VlS0hoaTg3VkJUT2Vj?=
 =?utf-8?B?cjZmZTMyOTBHV1g2SFpmcklvOWpCUU5WZ2ExWTZLM2ZBODVabzhabW5MQ3hx?=
 =?utf-8?B?V3JINFJ4ZStBOGErenJNY2wwUTZIY3MxSm1hU2IyeUNIUUM3TCtia01kU1RJ?=
 =?utf-8?B?L2crYjk0SSt5RmJreTlnZGh3Wks5cGpHZWVKaTJPS2tjNXhWQk1XN3BIODNH?=
 =?utf-8?B?cFZ2TVUzYkw1ZHJXbFk3OWtWcFBkMSthU1NBUU41L2s0KzViTWVoVnFOT01M?=
 =?utf-8?B?dHZwejFJb3pVeUcyUEk0a0R6THhpZFA1OHZQRFVpNUFmTzBWUlBtb1BSekx2?=
 =?utf-8?B?Uk1FN2E1RFY1a0hYOWU2WmJuMHNFU2VzRFdKK1BjRUlOQjlOSVRNajNFMTF5?=
 =?utf-8?B?d1ZtaC9pM3FEM2M5RVYwQk9XRFNtdUdoNyt1Y3A1ZmUvenpSRWphNnZXVGNs?=
 =?utf-8?B?eHk4aGpIekdoVjhsRUU5L1E5bEtvbVk4VVB2TGVaaGpSaTh0d3BRWDZLdnRO?=
 =?utf-8?B?YWhhUXk5eGMwNzBBbU5HRStzRytUQWduQXRJNmtnclBGWnBnSlFjYmcySzh0?=
 =?utf-8?B?d2pDVnVhK1VhVzFUUkc0c3MrSFNBcFZFY2pPRHJtNU9EajBBTUtyMm85cmYv?=
 =?utf-8?B?VU9NdHZKSUkvN2Z0eGIwWjlOMU5kMGUzZFltSGVKQWIwOTB5UUwrWCtYYWpU?=
 =?utf-8?B?YTJBc3NtemZ3b1dsbmQ1VFRkTXB3SjJQRE5ReEFvQnVjdlhaK3B2Ukt1eVpn?=
 =?utf-8?B?L1FOTTVrM1kvc01KTWxKS3VuWVMrTThEZENiYUtvcisvTFV3K05CSGR1eFJo?=
 =?utf-8?B?WGUyeUI2U3QyNTc3YS9heTY3cGpxcXZqRmU0UDRXS0hxaXkwdFRzenhOc3Jr?=
 =?utf-8?B?OStBWlg3eGxQczkyN2VETGNHUDl2cUJ6d2FtVWdYOGlMNlI3WFVFaENBS29Y?=
 =?utf-8?B?Ny9UV29GS2txVFZTSkdqV3Y3QUVJaHIra3NsNUtyWUpOZzJRMGk2czBISm94?=
 =?utf-8?B?eEE5UzNuUzZlRmFDQnI2Qmh3N0FnWE9YczUxU3lGN2d2bkQ0bEVpV3dFbU1x?=
 =?utf-8?B?NmRYUmJsYmQ2QzVQRitZQmZORzZUTmxCUjFIcmIwTzZHYm1ZcCtrOGFIdkNM?=
 =?utf-8?B?am15ejdKSDZLZ1ZkTHdGdEdsYnMwM1N3TmtBZU5xRFlmSlExS0JJWWFMcy9s?=
 =?utf-8?B?YWhWZ2RjeG9UMUV6U2wyS2loVmo1V1V2cHhnYnBENThkVE80TXUxS0JMc2I5?=
 =?utf-8?B?VTZmYWZmOG9WeWhDK1U2RXhFNXpZb2lkczVteTZ3NTlsV255NXRIQkFtaUlZ?=
 =?utf-8?B?Rm9LMWJZY0pJV3IrT254eXB6bDdXTTRMSzZmL0RmOGpEZXJ4TVpvU0l0aEcw?=
 =?utf-8?B?YmluVVBGcyt3cWRGdUo0ZUNEM0VYcEdPeW85VGI2RlZQbFhiK1VCSDlOdm9w?=
 =?utf-8?B?WWxWY3RGbjRITGlXVktlYVlqQjVlSzNFVHdNRkJSQy8xNHREQ0ZwSFZKRVVC?=
 =?utf-8?B?ZmNkV01MYlNxNllGdDF6dWd5WXVBaGZ1UXI5b0h2bWErZDlpRHZiWTVqaStG?=
 =?utf-8?B?SSszMVFDa3ZOaWZVaGd5TFVsMWxPejdUcm9GZmUwUlUweEIvYjVTV1pBbDZP?=
 =?utf-8?B?MW5KbVlVVS92Q1hIOXVZQjJiWFFZTGNRcm5KOWJVOWxmRXBGU3Q5MTJDSU9O?=
 =?utf-8?B?TTFzKy9uOUowemNxWHQ3NVp5QlV2M1puQkpXRngzWTdZTisyZjFmT0JNWkxs?=
 =?utf-8?B?bjFtTHNSZzJmTGFtWDRCSExKOVlmOGFoV2c5VTBFY3RPNmFGTE84WnU1RnF2?=
 =?utf-8?B?RVdtSzBwbk8rbDhvZCtZeUErYWE4L05qRUNvbWJUeHo3eS9peDZPT0g5M3Nv?=
 =?utf-8?B?MURlN0dCRThKUCtkTVAwd3Z3MEdtUDlEOFZTMk9EVlk0R1dZVGRWcGNEcS9q?=
 =?utf-8?B?c1h1WnA0YmFuY0Z6R0o5c0JRb0tZRnRPMG9FVWYwQXB5NndZbm5kQjBlVGln?=
 =?utf-8?B?RVRkU3VVdm5Od1o3eDh5UjVMQXBuakJSU0ZMaUw5WmdrZnQxWXF6VWVvQjE5?=
 =?utf-8?B?ZEJ2aWg1cXJrYVU2V3FHZGNwd0hnaEQzZTZCTkI3UUVNVnZDUHM0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F6D681FB328F34DAC0C1F2A20A5F02C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2da3656-dba1-4d33-3a6b-08da52ac4683
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 11:01:49.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIeGx9po1M/PSVhoVuhtxgGivPDWw9BopBr3qtvPIXdXojribMcARMJgk5Q1v3+wIcuuj1QkLvckQY4HCnvilKRj0UQmOZUpDuEljC3+raI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4312
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjAvMDYvMjAyMiAxMTo1NywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBJIGhhZCBhIHF1aWNr
IGNoZWNrIGluIC1uZXh0IGFuZCB0aGVyZSdzIGFuIGVudHJ5IGZvciB0aGUgQk1DDQo+IGRyaXZl
ciB0aGVyZS4NCj4gSG93IGFib3V0IHRoZSBmb2xsb3dpbmc/IEkgcHV0IHlvdSBhcyBSLCBidXQg
Y2xlYXJseSBpZiB5b3Ugd2FudCB0byBiZQ0KPiBtYWludGFpbmVyIHRoZW4geW91IGFyZSAqbW9y
ZSB0aGFuKiBxdWFsaWZpZWQuDQo+IEZlZWwgZnJlZSB0byBlZGl0IHRoZSBwYXRjaCBpZiBzbywg
ZWl0aGVyIGlzIGZpbmUgYnkgbWUuDQo+IFlvdSBjYW4gdGFjayB0aGlzIG9udG8gYSB2MjEgaWYg
eW91IGhhdmUgbW9yZSBjaGFuZ2VzIG9yIEkgY2FuIHJlc2VuZA0KPiBzdGFuZGFsb25lIG9uY2Ug
dGhlIGRyaXZlciBpcyBtZXJnZWQuDQo+IA0KPiBUaGFua3MsDQo+IENvbm9yLg0KPiANCj4gRnJv
bTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gRGF0ZTogTW9u
LCAyMCBKdW4gMjAyMiAxMTo0NjoxOSArMDEwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIE1BSU5UQUlO
RVJTOiBhZGQgcG9sYXJmaXJlIGZwZ2EgcHJvZ3JhbW1lciBkcml2ZXJzPiBBZGQgYSBNQUlOVEFJ
TkVSUyBlbnRyeSBmb3IgdGhlIG5ld2x5IGFkZGVkIFBvbGFyRmlyZSAoTVBGKSBTUEkgc2xhdmUN
Cj4gcHJvZ3JhbW1pbmcgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5
IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICAgTUFJTlRBSU5FUlMgfCA4
ICsrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMTY4ZTBhZjg2OWE3
Li42MGFiM2M0YmY2NWQgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5U
QUlORVJTDQo+IEBAIC03ODY5LDYgKzc4NjksMTQgQEAgUzoJTWFpbnRhaW5lZA0KPiAgIEY6CURv
Y3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtZHJpdmVyLWludGVsLW0xMC1ibWMtc2VjLXVw
ZGF0ZQ0KPiAgIEY6CWRyaXZlcnMvZnBnYS9pbnRlbC1tMTAtYm1jLXNlYy11cGRhdGUuYw0KPiAg
IA0KPiArRlBHQSBQb2xhckZpcmUgRHJpdmVycw0KDQpPbiBzZWNvbmQgdGhvdWdodHMsICJGUEdB
IE1pY3JvY2hpcCBQb2xhckZpcmUgRHJpdmVycyI/DQoNCj4gK006CUNvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+ICtSOglJdmFuIEJvcm55YWtvdiA8aS5ib3JueWFr
b3ZAbWV0cm90ZWsucnU+DQo+ICtMOglsaW51eC1mcGdhQHZnZXIua2VybmVsLm9yZw0KPiArUzoJ
U3VwcG9ydGVkDQo+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBnYS9t
aWNyb2NoaXAsbXBmLXNwaS1mcGdhLW1nci55YW1sDQo+ICtGOglkcml2ZXJzL2ZwZ2EvbWljcm9j
aGlwLXNwaS5jDQo+ICsNCj4gICBGUFUgRU1VTEFUT1INCj4gICBNOglCaWxsIE1ldHplbnRoZW4g
PGJpbGxtQG1lbGJwYy5vcmcuYXU+DQo+ICAgUzoJTWFpbnRhaW5lZA0KPiANCj4gYmFzZS1jb21t
aXQ6IDA3ZGM3ODdiZTIzMTZlMjQzYTE2YTMzZDBhOWI3MzRjZDkzNjViZDMNCg0K
