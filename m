Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318EF5833A5
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jul 2022 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiG0TaE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jul 2022 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiG0TaC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 27 Jul 2022 15:30:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F813DEB;
        Wed, 27 Jul 2022 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658950200; x=1690486200;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dRCsIYx7m0Eyw8mGGpy3ECsK9xc4kR28I9a1pCdCHao=;
  b=d+pyE6RgHmBu8eovKx63UIZZkLo5BI+C9vRlGU6v8ocBKbxGpdx7pPS9
   bOeanqkuO5yNrx98YtuGlMjB32HCMj8I7ONzsi+ZmxHwxPt5M2tdikgbf
   UdDG2V2/PN9bAHLJeZJIZICuIp8Zx8TgeXnF4ACKb2IiRy+aBysoOrWmo
   BW7Vtl0D/PP5msy8JS2A0r28U/fc68GLqBgBJEXXQerOhJ+9OGBZAlK5d
   HinygBPAAFGW+SntJeWWzMaCWUuktyWVc9MDZEl1oM46UHYzF5CiKaaNu
   OcrUkZtXoGMfLrwYXMDnqmyO0DWVmty1kNuKJbHYSJSHExvd7ofqJxdxc
   w==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="106421356"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 12:29:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 12:29:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 12:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STY4FrZxSDMg3wdjxVDdnp3BGHahtO9Wrn5IGbn5V/sKbCaTxH4A1rX5dMnZjKuQsBgig3mwbByiOzotazmepyTSoJFT+6IIHyR1Of7hVoRbsLCJUClbPOBZzsRUmQ69E+Gx+L50yraHISji4N7EUajNWBRQoYhEAbr19uP87e7qeflUWJ89hkIMpeB2WXEnBhkdsoi9Td3553GzWNGVsdKtPV6nn4VBa20dsnMnThIvRUbiN4p7isWADhj41uWbd6arJTf0w1wGlDNMBKnYdUTINswX8zvDst743J+iF1tMHS5RU6cBbgoDFXHTVeS8rSyqKx1vk42hHaNd5rCepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRCsIYx7m0Eyw8mGGpy3ECsK9xc4kR28I9a1pCdCHao=;
 b=aznQuf4k+3dEBwmfTmxWUJlLW+3zl4efatse1EFw8kH9InDOu0pvS+zIdbrv/R7BAfss2ch2VIzd7sjpls7S9rkvliZUBTjPCjEYd12frlb31v2KlKPT1L/C+ThoqIxnqGq8lVfRJBzI0435ziPG/JobmSapnAlIf3qe0mP0fBji9fQR0qX8WLCMvv0gH8rotOFXooARHW5SXzTlUCPxlMY44pu0S4+miQaNu0kBKU3sJPkh8ApNcRAST0kBIfik/AdX50lzbNq/PPdF267Le9dRQ6egWK8jlAF+GUBfrjLXXRkzX3/bQxuKFhg2Xmz3qaNtKfgEeSdgKo9ukDupqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRCsIYx7m0Eyw8mGGpy3ECsK9xc4kR28I9a1pCdCHao=;
 b=kc+rwHdtm9cnGRkL6xbeAZvtC/avPAev5HXz/vNAV5GXEostBvbZN3htoZlJ4K9A/JGLGS+0s7/i5+g+XBjryydiui/rw7wf9JseasB3wtrPd/KVIM4CfscrjUrg66SF5CIA4PAHrngXSDf+jALwP2KnR2RjYtcJuphRiGERarw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1793.namprd11.prod.outlook.com (2603:10b6:404:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 19:29:52 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 19:29:52 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Conor.Dooley@microchip.com>,
        <i.bornyakov@metrotek.ru>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Thread-Topic: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Thread-Index: AQHYodgiuClAJQHLFkm5YQbKggoK+K2ScESAgAAp+wCAAACLgA==
Date:   Wed, 27 Jul 2022 19:29:51 +0000
Message-ID: <57fa88d2-61c0-2020-06e0-6e5e201527d5@microchip.com>
References: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
 <80eeee3d-ff1c-393f-f894-5f0f32cd4112@microchip.com>
 <16035c69-f283-ea40-5db2-d99d0e932fc1@linaro.org>
In-Reply-To: <16035c69-f283-ea40-5db2-d99d0e932fc1@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51293ec0-f280-4f5a-5cc8-08da700660a2
x-ms-traffictypediagnostic: BN6PR11MB1793:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ly1xgvQ7C4D9VvZ5T3++j6E57i0vZLJ3MWga4BSCNkNGZ+wO44TeSmIgNb7iNCeDjVN2mSk9jTq6EBA3cd7W+vQTSebO//l1K5NdwQfQHPmt94DGT004OT2tLd91ePfquDiFPqsOIaaFVUVFWt9j5mojub91O5AghWU+XG5XFz3Dangrra7gbF64IuWOctiaIqdfKF6/5T+YEbqIg1vGUa2vaEm+gg7EVrgBYGa/Ycg/Jhl2yZLelMfJL2Z38zpHkWV8pVdjNoXFxCeX/vS7VHvVZ9qEnTtxAHG4uXv05wdhWzpSFOaWnjWfMW0r2dpPPEB9DybPQglGXNLddNVDoyrgpjzGQihdDbmnPsBznBn86hWGi42jth3ZQXzg3vDiC6VRag18eDR17Ue7MKG5sF5fHZQj8F/cfQgoLUJL+E0qxnsaXBNAjcTUYUdKDoV1qwvsteGuxFizuiUQDU3d7Lm2nw9rxHbPdfl/7DfWx1lI/+DdJeC3HLrVrRutAx23GrIf6uFSVmF9MqgDPXzzHuMuoSMBZ5PMmnehnXpUC+nQJfgEHXqyUlHiIMa4AMdWw+vTtWM8Mtez+aGeKFZldXQOwAhwb6LW+Viw/wc/6Wu2X6y0Ne+TSQOpEAATUEqwoleJ0+/kYbgqS3lN4z3d4UAPessjkd3fF8+3Ow+NanOZfhBgeymLyHSk1DNeTUNlBBGW7JhExTHD4fQkZsCAUQiv6rndsdUMQ/jYl1p7SM/Z5wFiYI4HTAGDKcZrqB9Qh3AtBODyR44f1zaG6eVC/ThlkLl5DvLDHzRf+2bfAJ/Cj3RwJGg7ywQOMZpF4WqaO4WqxfE2sKkePB1a8LmZMZOhjsc73z8iXdk/k8n0+I4KXCA0KUVM6TOURcrC39G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(346002)(396003)(39860400002)(8936002)(6486002)(478600001)(5660300002)(6506007)(53546011)(31696002)(6512007)(26005)(558084003)(41300700001)(86362001)(186003)(2906002)(7416002)(31686004)(110136005)(36756003)(122000001)(38100700002)(38070700005)(921005)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(2616005)(8676002)(71200400001)(91956017)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2tzcWlMQ0k4WlV6Mm9GUkFuZ0p5ZGZYZjJzZjU2VzBoUFV2T1hvRE1GT0Rz?=
 =?utf-8?B?N1lhR1QzM2o2aHJMN2Z3b3VxSytudzVmUGY2V28rcVVQbmJKSGNPWHRxeDRa?=
 =?utf-8?B?Tmp4ZTFuYUxHSTVoanAvMmhRb0pLSFBudzNYYnRhVkEwRThzT0hUQy9MWFUz?=
 =?utf-8?B?V2FWT0psTDlUaGxwOWdveFNlaTFTQ09lTTJ0U2ViWWl3M0E1Y3hiSFNCWGR2?=
 =?utf-8?B?TEtuNW5XV2dxL0xBWG5PR1hvUnN1SGlWbkFaUitIUnhTMGpQb3d3V3k4MTBT?=
 =?utf-8?B?bUljUHllQU90OEFaQmQwTWR4NWl1RmNuT212V3A1blgyMHlDMFk3U1poUWU3?=
 =?utf-8?B?RW9mRVhzZlVoV1hlQnZkNDcySUVnTXl6N3VMQlJLektVN1dwNHlZelBKcjJN?=
 =?utf-8?B?cFRra3FDdmN3MXdkVEw2VCtQS3lVN2FyZHJlOG5PTVNhTHF6UVR0MWR6OGsz?=
 =?utf-8?B?c0p6bjZnNXhuRlNLY01iNXdDeHZwVmRwKzhXWFg5LzBIdy9hZWVySXd4RmhZ?=
 =?utf-8?B?SHFyOWNCbm9Sb1hQRkpUM2RYY0dTZXg4VTUyZVZHbnJqb084R0RhZllKUG1L?=
 =?utf-8?B?enZFZE1BVFlYenY3WGc1ZHkyWmJLVithWmNROTBURFlqQ2QvNS9MS2hoaDVr?=
 =?utf-8?B?ZW83ZTFqeFlHSEUyNkR1ZWZOLzFjUVFyc1hqTmgyeW1adzlucUR2b1o2TzND?=
 =?utf-8?B?NjNPMEVCUjVOaDVkVitwZ0VBUHVNb2tuam80QWFneXVsbzBLNERZcW1hejBw?=
 =?utf-8?B?bTNNM2RZZGZSMTkwZmlhUnNKVmtWMi83NW4vQ0dONjlvM0RMcVkreEJsRGpz?=
 =?utf-8?B?R2JLa093Z1U0TGdNSTVpM1ZrdHlUODg0Q2lRa3VGRzlNN3pKZ3J5Z29rTHZS?=
 =?utf-8?B?NkpURi9makN2RzI1VG1pRnV1SnZqdVlCd0JkaTlBdFBWc3dOWmc0S1NpNXJu?=
 =?utf-8?B?VUVUdmZrWmI4dS94eThaWEg2dDdTQ052WFpqNWY4U2Z3ZHJvR0VyVEREN1VT?=
 =?utf-8?B?OCsxUWJBWXg2c0JsclQ2RTZ2eFBoWUJDdUVEYkFYOE9ZbHlJK3Q1VXM0dVpJ?=
 =?utf-8?B?L0NkalVldEdvSEZWRmIzcXdWQUwzV3Z4TWliOUFTQ0NSTmNEVWtUMjZhQmFQ?=
 =?utf-8?B?cGJYUEoyZXFYME5NM2MvTHBHaSs3VzRIWWhJOVh0WklpRW9DNk5sL1JrN0Q4?=
 =?utf-8?B?WlNrbjE2T2UvazNpSitTT09yUHVPZ21xT0QrdFNRays4eXJodlJ0bzA3ckRB?=
 =?utf-8?B?bEQveWJEcUROUWUvSW1LSnp6ekQxUWZEY2NFNElOQmI5czQyMXUydjFWaEZM?=
 =?utf-8?B?YlNLY2JWWnBiQTVwcHJYdkttWEhpbVVYNURheWpLQmE0aXBRRjFFOVNDdTNz?=
 =?utf-8?B?Zmh6QnRqckhSYVoxR0VaMm4vazExQm5YWk1JT2NvYUpGVTUrWUdaeVZCWitT?=
 =?utf-8?B?RkdHL2ozdTVMZDZyY3hUYnZ3MUcxREtUaGZHWTNjbVlyZHlkY0s2SHhuc3k5?=
 =?utf-8?B?UFgyaUpocVlxMi9PUDJMY1E2NFl6MUExQXlSMDZyMWNZbCtJNHBxQzBpL1dh?=
 =?utf-8?B?M1ozUENCcDh1eE93d0tjRnk1eTl2d2xycmttcVh1MjNxaHVxQmFhdGZJa3Zt?=
 =?utf-8?B?R0QrM1FRMlo5cm1UN0dMd0M5c2puSitQRG1lWmU5N0x4YkNNdFZqTmdYazJC?=
 =?utf-8?B?ZDdaMWxWZzNlelBUTmZrYVFRUGFjT2ZiNGxlMko5UGV2ci9PMkt0ZG5KN1lJ?=
 =?utf-8?B?VDFmZlEyNk1LQ3J3ZzAxNGdmZjVRdEgrTGdWU216OG5tSVh4ZUg5cXJrUjZI?=
 =?utf-8?B?S3JZclRlZUN2djhEd0dLcHkrVVprN2VmQXRmZ3BrZzZSd2FILzFLUHhKK3g4?=
 =?utf-8?B?UjkrMjN5S1VlNDFEUWt0aW8zZjRhdlVQcVFiLzNmQm05V0o5azlJUFE2NGhD?=
 =?utf-8?B?U2RVOXlHQ0thU2M5RTdPSjFjL05UODJoUzhPUXh5anFnVTdJUUR2Nk1MclI4?=
 =?utf-8?B?OHAwNDFnYkNsaGdoU3ZSOW9rRUhQZXpYNEh2MG96RFN4YWQyZFMybTZjWTg3?=
 =?utf-8?B?cThpM1VsSUhOQXQvK0pvMEdHdEM4KzNxSjQxclp3NUxjT2JKOWk4U1NDM0o0?=
 =?utf-8?B?dzRmVHNPb0wrdUV5dzBPTXZ2WkprUUxHYS9KdWM5MVlic3NmMGNxSGlzN3BU?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E6E6D38A312B145A0C83F9A182D0E50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51293ec0-f280-4f5a-5cc8-08da700660a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 19:29:51.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWdP73+gSUeUKRh/RsGmm+JbJpIP+udaDiaWc4ISXr2opvq9HTgq8U9SUcVR4nkgkLCJ2qiaRuVsVimD3d82y0eUwu4X8HlPrDqpQLifC9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1793
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjcvMDcvMjAyMiAyMDoyNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gVGhlcmVm
b3JlIGZvciBjb25zaXN0ZW5jeSB3aXRoIGFsbCBvdGhlciBTUEkgc2xhdmUgZGV2aWNlcyBJIHB1
dCBpdCBhdA0KPiB0aGUgZW5kLCBidXQgaWYgeW91IGZpbmQgaXQgaW5jb25zaXN0ZW50L21lc3Np
bmcgdXAsIEkgY2FuIG1vdmUgaXQNCj4gYmVmb3JlIHByb3BlcnRpZXMuDQoNCk5haCwganVzdCB3
YW50ZWQgdG8ga25vdyB3aGF0IHRoZSByYXRpb25hbGUgd2FzLg0KVGhhbmtzIQ0K
