Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6975231EE
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiEKLgq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiEKLgm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 07:36:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56B457A9;
        Wed, 11 May 2022 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652268999; x=1683804999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pDMi9i/8HZxA+smuhylhOULPMUuSY1+x+42COCM5AZM=;
  b=2Hsp/LPhRtjmXiIsX9UCn91/kwrKWVhQzn9lWVbORQTjQveQiNvZJJa6
   yxxFK8gMeBskcXUIZQBzL9yCtDhR+W+R+G8a7Kcwbbw4dmShqkBVSIzO/
   iKiDapDLwPBPCsxOEBaA4rVSZoIlARp9tkpShvr9isahlD5ySn7YJi5Pz
   FhOT3MkgOrRA/MR5OspFbgO4FZkHSnnP6BsGepIueXoRiNymjUjpnONYx
   +aJz/pFzYY45nZy2m59O+6+lXDd2Qwqn5y4/U5Gmodb98k+ZCAapm9Z2f
   CqRWnsKIPzzVG9s604+0Pp7P3/itW3fGxdA1Ew3yQ61giq4HyNw3tfqeK
   g==;
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="163580244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2022 04:36:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 11 May 2022 04:36:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 11 May 2022 04:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5yijlijs7JFb2JxwEifN9OOE+s2jA/Xhnj2u8GnWwXH4+q7euuIBJfXIDf1k4OXsPoq/mlzb0s3G2XHaygC5ThoALcXTXh05hSDm+wIeazl71qUjX0ezboXEAGdN6OuAy+VMFyqj1BjHNBlqYQalA8LKog6nTxB66R+hVhySuerBKQjFcApARMuCKHUwfA//SElI+0vNmgh/Jnx8+ZrsIhtmPnTVQX7dMnp+zP7WPZc/iFUteGAARHZFApJCARQ1Jh3jENqUnfgkCsuJWN7i2ovQMiKTYs3tYeO2of7dtpiMhMrJBhMFedMmBTafJv0Mef+aZZ6PjoSDUqiP1mMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDMi9i/8HZxA+smuhylhOULPMUuSY1+x+42COCM5AZM=;
 b=RWX2zxsn34rxbEW8f9LT80qRseHtQi8C2oUGc0X2wtzg6uB7d/3DXz/oqI5I/XAclU43vDTcq6x+rBR5WtOWpy6fpD0GtgzOUD5CPKn84OCk1lXcGMTSVu8jj11WOEwtESH75BT1XKac5SYpj0FQkQiFTRG12ACrOzwBKaSLA1hSO7VM1D+ujftChY2dp48fOhFXd6yzYnyCSBOgNLHF1O0YG3MbzP4AE4QZ+ZF3AAFTMniiwvIqPJFU+gfioQg5+iQrJvj365x4QqDqXDzKmkmLZ1JXw4rU3uy1+xAMxWzwwFP5T2Dsp2RltfH/oyUUIGY//aTcbZtpPH/aHcoI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDMi9i/8HZxA+smuhylhOULPMUuSY1+x+42COCM5AZM=;
 b=EUNKI5ynfEFlWfa89LVxdk/Gkc50lOkitbuwpfHi74w0U+so6gZ23pzyOBCccgv2zvAa656DxbsgazAivWx0aYUEEYiXpHEUQ6Eqs1ViyalsPztlvofw+anv7q/Kr71vU/jgU0ZQyuO/tJtvdEHwPHWCsfRGqCkEACXHWDf7uvk=
Received: from PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8)
 by SN6PR11MB3519.namprd11.prod.outlook.com (2603:10b6:805:d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 11:36:34 +0000
Received: from PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e]) by PH0PR11MB5160.namprd11.prod.outlook.com
 ([fe80::d10f:cc33:cfd8:365e%8]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 11:36:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>
Subject: Re: [PATCH v11 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v11 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYYekhJeVdxuqcOUSnsjuxyGg64q0Wb3mAgABdtYCAABvqgIABFZ8AgAFcBwCAADfBgA==
Date:   Wed, 11 May 2022 11:36:33 +0000
Message-ID: <f1557776-36c9-083f-2101-db84ca9a9cfa@microchip.com>
References: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
 <20220507074304.11144-3-i.bornyakov@metrotek.ru>
 <bd5cb37b-ee56-f6d5-2d98-c08566b60728@microchip.com>
 <20220509171621.zk4owxwlngxjodgz@x260>
 <da1e5125-de6b-11a8-a52d-7e6e5f45ab70@conchuod.ie>
 <4b752147-1a09-a4af-bc5d-3b132b84ef49@conchuod.ie>
 <20220511081532.7gkmz3uumzxgwfaf@h-e2.ddg>
In-Reply-To: <20220511081532.7gkmz3uumzxgwfaf@h-e2.ddg>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aab681f-1438-4c85-b50b-08da33428052
x-ms-traffictypediagnostic: SN6PR11MB3519:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3519F5566ACD2D53A0DC710798C89@SN6PR11MB3519.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdgDUEK/1pnOjRL7BH9XT0M5Dk6IWKaK+p6PclemgYsx48MyPULbFNSgo2nYlIU0I9hyJQ8foY5cb+oBHWeyw5hAHqsxJgsGiITl5rMtZFIzk+kKZZfVdEW6wGblH24HK6pQMiHmbi6Np7sd0fwVukkATXVctkTLNaE71XmscOTFE2N7MuTE0ssamdy4RiGjnN6TChFFaX4K5QwLRlN2dKkwB0zvDIDl8XqqaJcB/OeOt9QjFFMpiobg6wzE3SiIB7iQhlTsp4I73jPJ9f05fsoa03+d4D4W/g/yCHehoe804T44fd5cVU9z+zrbPTD3BvBGQJBVYizPoSPIQrK4q4YWCqX31/5C5YFj1nMtSeK/Jtym5usomaGGShU3ykm8lwNpbMiCzFjEY6YNuklMBvWgkeRSaXOsT83cupO3jPzM1VBb2PHDRQsz577pPbD2AjWLYJNSeHIDDJUt+PpIrSZoFhnG6nCllNIF3+KU4YOD0zsuYudRoNlHcK+9/p9YQ3goF8fq1XPh7l7WcUSZTTT3u4bzIQ8w8gyuFEfWef5Hjh7hZ2z36kpZhR6VMsjeB+2CTL1P7To11Gpsdor+y5+I6HbQzvo7RlKeAsGNQbXl8i76Mj1zZq6A5btbMMByMrTvzJHKrEBgu5FQ62PFbQ2YXrjb8b5NmYMIAu6TwL3nEf3miQrAsTTp10VmZPKJyZv39Hq5/40qrdr5YvAv5bIH8G9TyG9NKHwMl7C2pgNzR39AUrUc2jfAyA1Sx6UYYtSeCe1A65eheUhB/Jyk6WkZw2pvoG2xWPs9vHeQ0BUhhf+ciGWuHxsbWWEgWRWDznRlPO1mGRg3fD0u/Jyvr8UvW1V9/kZPXpT0CxuSXG3/r1leLl0bu1k+VUA1D/tz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5160.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(38100700002)(31686004)(76116006)(36756003)(4326008)(83380400001)(316002)(66946007)(66476007)(64756008)(66556008)(66446008)(2906002)(8676002)(71200400001)(6916009)(54906003)(91956017)(122000001)(86362001)(5660300002)(186003)(53546011)(6506007)(31696002)(6486002)(508600001)(8936002)(966005)(7416002)(2616005)(6512007)(26005)(45980500001)(15519875007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGRUaDhFL29LMWpSUzFxd1hYOW5mc2RMZEtic2QzSGsySE8wdGFxVDJKZHZx?=
 =?utf-8?B?SkYrT3Y3SU1VM0pncWNJSmtzckhrNXgwOWQ2QlVtemdkNUpWSm11Tk1aZVVq?=
 =?utf-8?B?ZGxKS0xlY3JTMW1meC96b0kxVkIwa2xTTUFEVlJ3aW5rL0paS2RrN283eWwr?=
 =?utf-8?B?U0hNMnJhZ2hsQVd6MGh5ck5jNVFPdnIvSTU4eGdQWDM0ZWJXbTV4KzdxY0Ux?=
 =?utf-8?B?eVlZRFlRZG1heWFVRTdBbnFNNjdkL0t0NTVkRnNPT0R2Z0xJVWp1R1JYT29k?=
 =?utf-8?B?bXVlUmhoQzczS0xjSyt3cTJMdmFhWktDTkpPekswYVZtUFRJc0l3OWQ3c3dU?=
 =?utf-8?B?VGxFdHpKdXp5dWpBQU9KQ3pVbDFQTmU5bjJoTDRScmNwTGlVRTZWZFUvVzR1?=
 =?utf-8?B?YzJHVWg5ajU4enFra2FXNlExTlV2dlhNRzFtdy9hanpEV2NqcGJqdmVuSVhZ?=
 =?utf-8?B?UFNzR3R0MVQ4R29aQnR3RXNkMnZzbU5DVWxjdDNiNlphZXJ3QWNjUTA3UDJ0?=
 =?utf-8?B?SjVicXVyOXlzQnByQ3Q5S3M0eFRXbGhZOGp6anpUVTZreGVoaE5YeVlxZjM3?=
 =?utf-8?B?MzZZUXZTaE00d1l5N2ppVUFycyt3cDFMUm9iQ0pMd1BmVVlUUkxtbDdocmU5?=
 =?utf-8?B?dFFkY3J1MW83SEZVb01tTkxsa0ZFWUVCdVlHUlI2VEU2Rm9KM3N6cGg1czFG?=
 =?utf-8?B?UlF6NlFvbnBPNk80d1NEcDRucWdsaGxLUDFGM0lwYTVqQUdDWnVFUGlmc3ZY?=
 =?utf-8?B?T0ozM1ErcmdHZlB1M1praVYrZTBxMjN2TUh4K2F3bG9BZkRMR2VqN1RsMXZu?=
 =?utf-8?B?Ny9qeFFZSVlzWGZjcWg3RlZKZVZoSklXbkhYMkwxd0ljUjdVTzFWY0tTTEZu?=
 =?utf-8?B?KzVwRkROZ2dBeUcyYlhHYzl6U3ltZjJFd3pnNkFOSExMZll1MVlSMG0vdnBR?=
 =?utf-8?B?bk93N09pNzhsU281RThWRmZtTGlTd3VtNVNpZnhNVkVMQ1MvbXR0K24wN2Rr?=
 =?utf-8?B?RUh2QmtkVkFmWU1Tek1yc2hOMSs1NjliV1pOSEh5bUk0OHBrTGVqeFphdmx5?=
 =?utf-8?B?VnVBd0dSVEY5RU45d2ExTzVnejBWa1B3U0JFbDVBSnp6TzJOc2lsTGpOL0wv?=
 =?utf-8?B?Y2hjV1dvWUNkU3E5bENtYXFrWm1FcW5PN3BlNUV5OXJPQkE3bHlKQ3Uxa0sz?=
 =?utf-8?B?MGpXNjd3TUZLazc2UXc4RzZZbURVVWhWcVlBaGwreWxSMzVsbmhOeWdtOVRy?=
 =?utf-8?B?OS9ldmRQcFAvMThyMVdSU2VTTlhXQjBTKzE5MVBmZnpTRE1MaFF3V202UGxk?=
 =?utf-8?B?YzBwemJGZHA5MzBjK3dYK0NmT1ZrSXZsTEpVOEsra3FCVzAwNXJkSlhWVllJ?=
 =?utf-8?B?S3p1blU2bzhxdkk3YjZwN2RvVjM0U0lkbm9xV3RZMWx6Y1BDVlJscnAvU0VW?=
 =?utf-8?B?VitEa3hQbVUrQUxQbncwSU53UDJKTTZya1hnUVdVTmtxKzN3cjZDRWY2Z2l4?=
 =?utf-8?B?dmxDWkZtMzVoVXVRMmZkUVllKzBjWk5oRTFrVUJMdWc2K2lUR2piMCszRXVo?=
 =?utf-8?B?WXdUU3J1djFhMXdJbXhCdzFhK2NEVzY4bW5TM1ZiMFBqOTlaaGNzeXhIZ2xF?=
 =?utf-8?B?dWcvcGlCdzJFUzc1VXdTNVBzc2tVOTBIR0x3eStTNXpNVldvOG10R3RhWGFp?=
 =?utf-8?B?cWdsUG9DMEcrY0taNWxHY1VmZENJa3I2KzlMYllnNUI4ZDRpeWNmRE1GVno5?=
 =?utf-8?B?M056WlhORStJaUllSE1aKzU4ZU9XcGs4cVNqenZvOTA0RlZCUjEwRHZ5UlQv?=
 =?utf-8?B?VitVL01wRXpTb1g5RjFZODhxWkgrc3NMUTltTnJBZFArZk12eC9QV2RTeEhq?=
 =?utf-8?B?a3ZtalFtbjhxWEhUZElYbHBEdnUvMVFRTnBvMlFPV2lWWE9EMnZ6UFFTTEN4?=
 =?utf-8?B?U2tkZXphR2duSzVNNW1DZ1VTU2x5dGk0UHB0bi9tMXhEbHJudXF2Vy8wWUdM?=
 =?utf-8?B?LzN0VVY3dWQ0OExiS2Zrd0xhTzhuWE1ja0VsbmRYMFlpV2NFdHBCeUhxR2tl?=
 =?utf-8?B?YUJGRXZoTTJZTWwvRUN2RjdwOEJWOWtWVk9OUXk3OTB6RnJzdUp0K3Z4dVVq?=
 =?utf-8?B?NGk2R2dYeEFzc3NQeTBMZlF4OFdPa2g0SEJUTlBjQ3paQTZ0aTRTdmE5UDVv?=
 =?utf-8?B?anJwMytPWDZuYXM5d3RhM2szOUVLK0pIcFhUa0M1MGJ4Y2JmSDJVbThxMnFh?=
 =?utf-8?B?bzZJVHRkSXhVOXdiQUdHV0tMOFV5WlN1YzQ3dHJDUVhmb20yd2lzVVJKMVh4?=
 =?utf-8?B?VTRLbWtRZ05Cak5IcWVDdis0TmliSkZuTjBYN0dwaWNZdHNyVzUzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99A5CAF7029C8741858C6A42BB7BBAE9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5160.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aab681f-1438-4c85-b50b-08da33428052
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 11:36:33.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yg/g/dDqDBlqUrMVfYXq0Kwfl9UZ/WLrzzK9CAQX559sn/aBdNLKrxcPwpkFzEmKZanqydtbFfED7wARKIDTQTtthNMBX5lbQHrhU8t3Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3519
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMTEvMDUvMjAyMiAwOToxNSwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVHVlLCBNYXkgMTAsIDIwMjIgYXQgMTI6
Mjk6NTRQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gT24gMDkvMDUvMjAyMiAxOTo1
NiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+IE9uIDA5LzA1LzIwMjIgMTg6MTYsIEl2YW4gQm9y
bnlha292IHdyb3RlOg0KPj4+PiBPbiBNb24sIE1heSAwOSwgMjAyMiBhdCAxMTo0MToxOEFNICsw
MDAwLCBDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4+IEhleSBJdmFuLCBv
bmUgY29tbWVudCBiZWxvdy4NCj4+Pj4+IFRoYW5rcywNCj4+Pj4+IENvbm9yLg0KPj4+Pj4NCj4+
Pj4+IE9uIDA3LzA1LzIwMjIgMDg6NDMsIEl2YW4gQm9ybnlha292IHdyb3RlOg0KPj4+Pj4+IC4u
LiBzbmlwIC4uLg0KPj4+Pj4+ICtzdGF0aWMgaW50IG1wZl9yZWFkX3N0YXR1cyhzdHJ1Y3Qgc3Bp
X2RldmljZSAqc3BpKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKyAgICAgICB1OCBzdGF0dXMsIHN0YXR1
c19jb21tYW5kID0gTVBGX1NQSV9SRUFEX1NUQVRVUzsNCj4+Pj4+PiArICAgICAgIHN0cnVjdCBz
cGlfdHJhbnNmZXIgeGZlciA9IHsNCj4+Pj4+PiArICAgICAgICAgICAgICAgLnR4X2J1ZiA9ICZz
dGF0dXNfY29tbWFuZCwNCj4+Pj4+PiArICAgICAgICAgICAgICAgLnJ4X2J1ZiA9ICZzdGF0dXMs
DQo+Pj4+Pj4gKyAgICAgICAgICAgICAgIC5sZW4gPSAxLA0KPj4+Pj4+ICsgICAgICAgfTsNCj4+
Pj4+PiArICAgICAgIGludCByZXQgPSBzcGlfc3luY190cmFuc2ZlcihzcGksICZ4ZmVyLCAxKTsN
Cj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICAgICBpZiAoKHN0YXR1cyAmIE1QRl9TVEFUVVNfU1BJX1ZJ
T0xBVElPTikgfHwNCj4+Pj4+PiArICAgICAgICAgICAoc3RhdHVzICYgTVBGX1NUQVRVU19TUElf
RVJST1IpKQ0KPj4+Pj4+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlPOw0KPj4+Pj4+ICsNCj4+
Pj4+PiArICAgICAgIHJldHVybiByZXQgPyA6IHN0YXR1czsNCj4+Pj4+PiArfQ0KPj4+Pj4+ICsN
Cj4+Pj4+PiAuLi4gc25pcCAuLi4NCj4+Pj4+PiArDQo+Pj4+Pj4gK3N0YXRpYyBpbnQgcG9sbF9z
dGF0dXNfbm90X2J1c3koc3RydWN0IHNwaV9kZXZpY2UgKnNwaSwgdTggbWFzaykNCj4+Pj4+PiAr
ew0KPj4+Pj4+ICsgICAgICAgaW50IHN0YXR1cywgdGltZW91dCA9IE1QRl9TVEFUVVNfUE9MTF9U
SU1FT1VUOw0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgIHdoaWxlICh0aW1lb3V0LS0pIHsNCj4+
Pj4+PiArICAgICAgICAgICAgICAgc3RhdHVzID0gbXBmX3JlYWRfc3RhdHVzKHNwaSk7DQo+Pj4+
Pj4gKyAgICAgICAgICAgICAgIGlmIChzdGF0dXMgPCAwIHx8DQo+Pj4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAoIShzdGF0dXMgJiBNUEZfU1RBVFVTX0JVU1kpICYmICghbWFzayB8fCAoc3RhdHVz
ICYgbWFzaykpKSkNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gc3RhdHVz
Ow0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAsIDIw
MDApOw0KPj4+Pj4+ICsgICAgICAgfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICAgICAgIHJldHVybiAt
RUJVU1k7DQo+Pj4+Pj4gK30NCj4+Pj4+DQo+Pj4+PiBJcyB0aGVyZSBhIHJlYXNvbiB5b3UgY2hh
bmdlZCB0aGlzIGZyb20gdGhlIHNuaXBwZXQgeW91IHNlbnQgbWUNCj4+Pj4+IGluIHRoZSByZXNw
b25zZXMgdG8gdmVyc2lvbiA4Og0KPj4+Pj4gc3RhdGljIGludCBwb2xsX3N0YXR1c19ub3RfYnVz
eShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLCB1OCBtYXNrKQ0KPj4+Pj4gew0KPj4+Pj4gICAgICAg
ICAgdTggc3RhdHVzLCBzdGF0dXNfY29tbWFuZCA9IE1QRl9TUElfUkVBRF9TVEFUVVM7DQo+Pj4+
PiAgICAgICAgICBpbnQgcmV0LCB0aW1lb3V0ID0gTVBGX1NUQVRVU19QT0xMX1RJTUVPVVQ7DQo+
Pj4+PiAgICAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5zZmVyIHhmZXIgPSB7DQo+Pj4+PiAgICAgICAg
ICAgICAgICAgIC50eF9idWYgPSAmc3RhdHVzX2NvbW1hbmQsDQo+Pj4+PiAgICAgICAgICAgICAg
ICAgIC5yeF9idWYgPSAmc3RhdHVzLA0KPj4+Pj4gICAgICAgICAgICAgICAgICAubGVuID0gMSwN
Cj4+Pj4+ICAgICAgICAgIH07DQo+Pj4+Pg0KPj4+Pj4gICAgICAgICAgd2hpbGUgKHRpbWVvdXQt
LSkgew0KPj4+Pj4gICAgICAgICAgICAgICAgICByZXQgPSBzcGlfc3luY190cmFuc2ZlcihzcGks
ICZ4ZmVyLCAxKTsNCj4+Pj4+ICAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+Pj4+DQo+Pj4+PiAgICAgICAg
ICAgICAgICAgIGlmICghKHN0YXR1cyAmIE1QRl9TVEFUVVNfQlVTWSkgJiYgKCFtYXNrIHx8IChz
dGF0dXMgJiBtYXNrKSkpDQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHN0
YXR1czsNCj4+Pj4+DQo+Pj4+PiAgICAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAy
MDAwKTsNCj4+Pj4+ICAgICAgICAgIH0NCj4+Pj4+DQo+Pj4+PiAgICAgICAgICByZXR1cm4gLUVC
VVNZOw0KPj4+Pj4gfQ0KPj4+Pj4NCj4+Pj4+IFdpdGggdGhlIGN1cnJlbnQgdmVyc2lvbiwgSSBo
aXQgdGhlICJGYWlsZWQgdG8gd3JpdGUgYml0c3RyZWFtDQo+Pj4+PiBmcmFtZSIgY2hlY2sgaW4g
bXBmX29wc193cml0ZSBhdCByYW5kb20gcG9pbnRzIGluIHRoZSB0cmFuc2Zlci4NCj4+Pj4+IFJl
cGxhY2luZyBwb2xsX3N0YXR1c19ub3RfYnVzeSB3aXRoIHRoZSBhYm92ZSBhbGxvd3MgaXQgdG8g
cnVuDQo+Pj4+PiB0byBjb21wbGV0aW9uLg0KPj4+Pg0KPj4+PiBJbiBteSBleWVzIHRoZXkgYXJl
IGVxdWl2YWxlbnQsIGFyZW4ndCB0aGV5Pw0KPj4+Pg0KPj4+DQo+Pj4gSSB3YXMgaW4gYSBiaXQg
b2YgYSBydXNoIHRvZGF5ICYgZGlkbid0IGhhdmUgdGltZSB0byBkbyBwcm9wZXINCj4+PiBkZWJ1
Z2dpbmcsIEknbGwgcHV0IHNvbWUgZGVidWcgY29kZSBpbiB0b21vcnJvdyBhbmQgdHJ5IHRvIGZp
bmQNCj4+PiBleGFjdGx5IHdoYXQgaXMgZGlmZmVyZW50IGJldHdlZW4gdGhlIHR3by4NCj4+Pg0K
Pj4+IE9mZiB0aGUgdG9wIG9mIG15IGhlYWQsIHNpbmNlIEkgZG9uJ3QgaGF2ZSBhIGJvYXJkIG9u
IG1lIHRvIHRlc3QsDQo+Pj4gdGhlIG9ubHkgZGlmZmVyZW5jZSBJIGNhbiBzZWUgaXMgdGhhdCB3
aXRoIHRoZSBzbmlwcGV0IHlvdSBvbmx5DQo+Pj4gY2hlY2tlZCBpZiBzcGlfc3luY190cmFuc2Zl
ciB3YXMgbmVnYXRpdmUgd2hlcmVhcyBub3cgeW91IGNoZWNrDQo+Pj4gaWYgaXQgaGFzIGEgdmFs
dWUgYXQgYWxsIHcvIHRoYXQgdGVybmFyeSBvcGVyYXRvci4NCj4+Pg0KPj4+IEJ1dCBldmVuIHRo
YXQgc2VlbXMgbGlrZSBpdCAqc2hvdWxkbid0KiBiZSB0aGUgcHJvYmxlbSwgc2luY2UgcmV0DQo+
Pj4gc2hvdWxkIGNvbnRhaW4gLWVycm5vIG9yIHplcm8sIHJpZ2h0Pw0KPj4+IEVpdGhlciB3YXks
IEkgd2lsbCBkbyBzb21lIGRpZ2dpbmcgdG9tb3Jyb3cuDQo+Pg0KPj4gSSBwdXQgYSBwcmludGso
InN0YXR1cyAleCwgcmV0ICVkIiwgc3RhdHVzLCByZXQpOyBpbnRvIHRoZSBmYWlsdXJlDQo+PiBw
YXRoIG9mIG1wZl9yZWFkX3N0YXR1cygpICYgaXQgbG9va3MgbGlrZSBhIHN0YXR1cyAweEEgaXMg
YmVpbmcNCj4+IHJldHVybmVkIC0gZXJyb3IgJiByZWFkeT8gVGhhdCBzZWVtcyBsaWtlIGEgdmVy
eSBvZGQgY29tYm8gdG8gYmUNCj4+IGdldHRpbmcgYmFjayBvdXQgb2YgaXQuIEl0IHNob3VsZG4n
dCBiZSBkb2RneSBkcml2ZXIvY29ubmVjdGlvbg0KPj4gZWl0aGVyLCBiL2MgdGhhdCdzIHdoYXQg
SSBzZWUgaWYgSSBjb25uZWN0IG15IHByb3RvY29sIGFuYWx5c2VyOg0KPj4gaHR0cHM6Ly9pLmlt
Z3VyLmNvbS9WYmpnZkNrLnBuZw0KPj4NCj4+IFRoYXQncyBtb3NpIChoZXgpLCBzcywgc2Nsaywg
bW9zaSwgbWlzbyAoaGV4KSwgbWlzbyBpbiBkZXNjZW5kaW5nDQo+PiBvcmRlci4NCj4+DQo+PiBJ
IHRoaW5rIHdoYXQgd2FzIGhhcHBlbmluZyB3YXMgd2l0aCB0aGUgc25pcHBldCB5b3UgcmV0dXJu
ZWQgb25lDQo+PiBvZiB0aGUgZm9sbG93aW5nOiAtRUJVU1ksIHJldCAoYWthIC1lcnJubykgb3Ig
c3RhdHVzLiBTaW5jZSBzdGF0dXMNCj4+IGlzIHBvc2l0aXZlLCB0aGUgY2hlY2tzIGluIG1wZl9z
cGlfd3JpdGUuKigpIHNhdyBub3RoaW5nIHdyb25nIGF0DQo+PiBhbGwgYW5kIHByb2dyYW1taW5n
IGNvbnRpbnVlZCBkZXNwaXRlIHRoZXJlIGJlaW5nIGEgcHJvYmxlbS4NCj4+DQo+PiBUaGUgbmV3
IHZlcnNpb24gZml4ZXMgdGhpcyBieSByZXR1cm5pbmcgLUVJTyByYXRoZXIgdGhhbiBzdGF0dXMg
ZnJvbQ0KPj4gcG9sbF9zdGF0dXNfbm90X2J1c3koKS4NCj4+DQo+PiBJIHdpc2ggSSBoYWQgYSBz
b2NrZXRhYmxlIFBvbGFyRmlyZSBzbyBJIGNvdWxkIGludmVzdGlnYXRlIGZ1cnRoZXIsDQo+PiBi
dXQgdGhpcyBsb29rcyBsaWtlIGl0IG1pZ2h0IGEgYmUgaGFyZHdhcmUgaXNzdWUgc29tZXdoZXJl
IG9uIG15DQo+PiBlbmQ/DQo+Pg0KPj4gU28geWUsIHNvcnJ5IGZvciB0aGUgbm9pc2UgYW5kIGNh
cnJ5IG9uISBJJ2xsIHRyeSB0b2ZpbmQgd2hhdCBpcyB0bw0KPj4gYmxhbWUgZm9yIGl0Lg0KPj4N
Cj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4gDQo+IEhpLCBDb25vci4NCj4gDQo+IEkndmUg
anVzdCBub3RpY2VkIGluIFNQSS1EaXJlY3RDIFVzZXIgR3VpZGUgWzFdIGNoLiA5IFNtYXJ0RnVz
aW9uMiBhbmQNCj4gSUdMT08yIFNQSS1TbGF2ZSBQcm9ncmFtbWluZyBXYXZlZm9ybSBBbmFseXNp
cywgdGhhdCBodyBzdGF0dXMgY2hlY2tlZA0KPiB0d28gdGltZXMgZXZlcnkgdGltZS4gRG9lcyBN
UEYgZmFtaWx5IGFsc28gbmVlZCBkb3VibGUgY2hlY2sgaHcgc3RhdHVzPw0KPiBEb2VzIGFkZGlu
ZyBzZWNvbmQgbXBmX3JlYWRfc3RhdHVzKCkgdG8gcG9sbF9zdGF0dXNfbm90X2J1c3koKSByb3V0
aW5lDQo+IGhlbHAgd2l0aCB5b3VyIGlzc3VlPw0KDQpIZXkgSXZhbiwNClRyaWVkIHlvdXIgc3Vn
Z2VzdGlvbi4gUHJldmlvdXNseSBJIHdhcyBmYWlsaW5nIHF1aXRlIGNvbnNpc3RlbnRseSBhdA0K
dHJhbnNmZXIgMzQgb2YgNTkwaywgYW5kIHNvbWV0aW1lcyBtYWtpbmcgaXQgYSBmdXJ0aGVyLiBX
aXRoIHlvdXINCnN1Z2dlc3Rpb24sIEkgd2FzIG1ha2luZyBpdCBzaWduaWZpY2FudGx5IGZ1cnRo
ZXIgKDEwMGsrKSBidXQgc3RpbGwNCnJ1bm5pbmcgaW50byBzb21lIG9mIHRoZSAweEEgc3RhdHVz
Lg0KRGVjaWRlZCB0byBtb3ZlIHRoZSBkb3VibGUgY2hlY2sgaW50byBtcGZzX3JlYWRfc3RhdHVz
IChzZWUgdGhlIGJlbG93DQpkaWZmKSBkaWQgbm90IHJ1biBpbnRvIGFueSB0aGUgMHhBIHN0YXR1
c2VzLg0KSXQncyB3b3J0aCBwb2ludGluZyBvdXQgdGhhdCB0aGlzIGlzIHRoZSAqZmlyc3QqIHRp
bWUgSSBoYXZlIHNlZW4NCkZsYXNoIFBybyBFeHByZXNzIHJlcG9ydCB0aGF0IHRoZSBGUEdBIGFy
cmF5IGhhcyBiZWVuIGVuYWJsZWQgYWZ0ZXINCnByb2dyYW1taW5nIQ0KDQpTZWVtcyBsaWtlIGF0
IHRoZSB2ZXJ5IGxlYXN0IHRoaXMgKGhhY2t5KSBkaWZmIGlzIG5vdCBoYXJtZnVsPw0KUGxlYXNl
IGdpdmUgaXQgYSB0cnkgeW91cnNlbGYgYW5kIGNoZWNrIHRoYXQgdGhpbmdzIHN0aWxsIHdvcmsg
Zm9yDQp5b3UuDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jIGIv
ZHJpdmVycy9mcGdhL21pY3JvY2hpcC1zcGkuYw0KaW5kZXggNjNiNzVkZmYyNTIyLi4xODNjZGZj
MDVjNGEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jDQorKysgYi9k
cml2ZXJzL2ZwZ2EvbWljcm9jaGlwLXNwaS5jDQpAQCAtNDcsMTggKzQ3LDMwIEBAIHN0cnVjdCBt
cGZfcHJpdiB7DQogIHN0YXRpYyBpbnQgbXBmX3JlYWRfc3RhdHVzKHN0cnVjdCBzcGlfZGV2aWNl
ICpzcGkpDQogIHsNCiAgICAgICAgIHU4IHN0YXR1cywgc3RhdHVzX2NvbW1hbmQgPSBNUEZfU1BJ
X1JFQURfU1RBVFVTOw0KKyAgICAgICB1OCBzdGF0dXNfcmVwZWF0Ow0KICAgICAgICAgc3RydWN0
IHNwaV90cmFuc2ZlciB4ZmVyID0gew0KICAgICAgICAgICAgICAgICAudHhfYnVmID0gJnN0YXR1
c19jb21tYW5kLA0KICAgICAgICAgICAgICAgICAucnhfYnVmID0gJnN0YXR1cywNCiAgICAgICAg
ICAgICAgICAgLmxlbiA9IDEsDQogICAgICAgICB9Ow0KKyAgICAgICBzdHJ1Y3Qgc3BpX3RyYW5z
ZmVyIHhmZXJfcmVwZWF0ID0gew0KKyAgICAgICAgICAgICAgIC50eF9idWYgPSAmc3RhdHVzX2Nv
bW1hbmQsDQorICAgICAgICAgICAgICAgLnJ4X2J1ZiA9ICZzdGF0dXNfcmVwZWF0LA0KKyAgICAg
ICAgICAgICAgIC5sZW4gPSAxLA0KKyAgICAgICB9Ow0KICAgICAgICAgaW50IHJldCA9IHNwaV9z
eW5jX3RyYW5zZmVyKHNwaSwgJnhmZXIsIDEpOw0KKyAgICAgICBpbnQgcmV0X3JlcGVhdCA9IHNw
aV9zeW5jX3RyYW5zZmVyKHNwaSwgJnhmZXJfcmVwZWF0LCAxKTsNCisNCisgICAgICAgaWYgKHJl
dCB8fCByZXRfcmVwZWF0KQ0KKyAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KICANCi0gICAg
ICAgaWYgKChzdGF0dXMgJiBNUEZfU1RBVFVTX1NQSV9WSU9MQVRJT04pIHx8DQotICAgICAgICAg
ICAoc3RhdHVzICYgTVBGX1NUQVRVU19TUElfRVJST1IpKQ0KKyAgICAgICBpZiAoc3RhdHVzICE9
IHN0YXR1c19yZXBlYXQpDQorICAgICAgICAgICAgICAgcHJpbnRrKCJzdGF0dXMgZGlzYWdyZWVt
ZW50ICV4ICV4Iiwgc3RhdHVzLCBzdGF0dXNfcmVwZWF0KTsNCisgICAgICAgaWYgKChzdGF0dXNf
cmVwZWF0ICYgTVBGX1NUQVRVU19TUElfVklPTEFUSU9OKSB8fA0KKyAgICAgICAgICAgKHN0YXR1
c19yZXBlYXQgJiBNUEZfU1RBVFVTX1NQSV9FUlJPUikpDQogICAgICAgICAgICAgICAgIHJldCA9
IC1FSU87DQogIA0KLSAgICAgICByZXR1cm4gcmV0ID8gOiBzdGF0dXM7DQorICAgICAgIHJldHVy
biByZXQgPzogc3RhdHVzX3JlcGVhdDsNCiAgfQ0KICANCiAgc3RhdGljIGVudW0gZnBnYV9tZ3Jf
c3RhdGVzIG1wZl9vcHNfc3RhdGUoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyKQ0KDQo=
