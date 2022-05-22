Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430D53063A
	for <lists+linux-fpga@lfdr.de>; Sun, 22 May 2022 23:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiEVVbE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 22 May 2022 17:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiEVVbD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 22 May 2022 17:31:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5D82738;
        Sun, 22 May 2022 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653255057; x=1684791057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KioIm5cu9dWI/rma4QdqalgKKegWWmnXhBFz4GK8GDs=;
  b=sJp1wQSCFGpBs+wQuijT/lTuPVRUYSoP4d2svwnJvD2vzTYiWl4fncgo
   xVvIwtqJX62X9xOvh7XeiojeDQQod4vgKsnyVU6kGhNAp1EsBcts1v/UH
   YRci32vR5cIuAMo8rrWoPjbTA1HLYFZq7WR4QK8gStZTzWc0z932bChei
   7X6omQhgLmMLePAxphSpjp+/Z+cGYplDPFkTnSBDsRu+EKj+0cYMMZJgU
   hQaiAwHzudGc+chqcaLumEvJrhUNcvloVD7RngkFf0gao7soydbDZJKY6
   igAQlNR5OnshQp9jveAPV7mVPAFjoyf1xyhubYwLCWASx1qvCLLI5gdvV
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="96832802"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2022 14:30:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 22 May 2022 14:30:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 22 May 2022 14:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJoOlyrdikfVdfo8i7wCCyn+kWudQcVXWFxvTuLyDcwSmHrOfIbFRrzxOayGjtNgwEqQVyig2oqrEMFb6clBbzQ1WnNbaMc+C2g5BaX/VAOxzwCDAZtafzjvxGUDvJSpcyclV+IuKSw0raV5aaBeL+q0zahNkYWJf8r8pX+41PEWSN08WnUtNWd1dSJ1BcQ892k72foOoLp22lw2xFj+vqugCyKMajdzlPJJhhxBJw5Dd2poiAW/qIesGyGmcGqEJJfy9DXXbiabb32uFSZyawTR94EXsp9C6BOu86zpf2WdVDy3PYkxUqFuoCbe1vVH6KIZPjL9WeovF2Pf+CAp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KioIm5cu9dWI/rma4QdqalgKKegWWmnXhBFz4GK8GDs=;
 b=denYz1vYK22wQi4i8wdImbwbD4bIRj8abBFLKokIvxQLbafOveR39Oa5Kv2BjjbW6D0mDxlEh2KSBMBdRUGUWW/lDa01g0GtAm4mzjLodY/SF6s7A9cibOxZUAd4ic8kMGhKJPOrRKw+NBhVAkoZdM6hR3x1bPnmhZpRIH9YegEwTmQYkyttuh9ECshlHd3pApiiU4XsqiJkGOcdrwaEF0oaCbD7tv6/J/6cgeM9Ig5g6OD+KamMdyMBnRcZy8lnVjK3ZYvMapgVCciOyf61ZP3fjvfp5s9v1ywFJ2awhnYZhrItFoztLLjo8NLLM048pPF/8ZKTVApeBomP7vLqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KioIm5cu9dWI/rma4QdqalgKKegWWmnXhBFz4GK8GDs=;
 b=hMlveYehR/vbJ4pv2TuBwyoWXh0Hi7VkJWD30eHKkyHbecAiFx3z0+PV1HnUTDtQl2MCcebcvgl4f/B/I1XeiRKz82vwDC7kF121JxR8B5gq64Sjb2iWSYQVEHKb7DVJGwnOI1ym9HKKZxYMdU4vfjtqTOF1cjhLdkgKlJXsBTw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Sun, 22 May
 2022 21:30:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%5]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 21:30:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>, <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <trix@redhat.com>,
        <Conor.Dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <system@metrotek.ru>
Subject: Re: [PATCH v12 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Topic: [PATCH v12 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Thread-Index: AQHYZumHhAxSnSBaW0m4mKdPhaAF7a0rKtUAgAA6yICAABL9gA==
Date:   Sun, 22 May 2022 21:30:54 +0000
Message-ID: <6d476989-81f9-4cf4-2423-8c5739eb8a7f@microchip.com>
References: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
 <20220513162755.16201-3-i.bornyakov@metrotek.ru>
 <20220522165232.GB90764@yilunxu-OptiPlex-7050>
 <20220522202255.f6a2x4owvg7nfzks@x260>
In-Reply-To: <20220522202255.f6a2x4owvg7nfzks@x260>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d69407f-77c1-4385-0661-08da3c3a5a0d
x-ms-traffictypediagnostic: PH0PR11MB4824:EE_
x-microsoft-antispam-prvs: <PH0PR11MB48240096CD032081A7606EE998D59@PH0PR11MB4824.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nv58OUMy+JSJ6Xac3tMrmlNbnvcPe5t6T5N5rCQufd7+U1227VAvRcVVKZAOAXO3Zt//Fn55W2fBQy73OR+D6ua8joF2gyo8U7+KRMD7t6F8ymkGly0WAXnxKJEsxe7z+Ew9pS38VUHh55QvmMxmERKhtzUJhYIQO1d1xDZMnCugGDvmqFX8eFiOkZokqy9PmE5ctMn+RWKl3vCboVqW6hH/O1LbIM42CJSsn7Nn+CkaX0143V2kwzdq+5CpCCUEVPtEoXqhqoUKNlgqzHCz9WrMTNAOkGpAJ/6MEG6KDY2pBB3NiWGuAMXLH8X7//90a8ApPAJvMEz6jrexLRUNtZ8QWjDN/dksiB1A6SLJIgcxfT/JrdIDTmkd0uKRwvA/OnI3LcyZ3v0ct15IrzhWP/FJl98q+1z9wYcoXp8ANk5yl3EKDH2JwtObH/r7nbhXjTI3MWClsN6r2GMgIVhfek5Wmzfud+QEOVHw/41wM5Q9HS29ew5tzJKAKsh5/Ydv84HNuAR96CdUkNpK1cyRvnOS8VepHQHRu1mcqDpsujvbN1nQhnYV8jKq61umAxn1Gtp8gi0suTKa15M83ALhD0nCnrCcyi9rlfq7CjnedXS+xmg3d6agOfWk0Y+aOYOxY4d1C4WBGSLWOz0+oUnPRVL1f0/N/M80XToKOB664OE4y/HuVz7UuGpgkiiU78Kl4+BlBOiqz145Fvp05Xx6mbhFDHRd+nat9Vip/37EbGUh0fQ0JMd4xdiD3BTTfLCcfdGt+2wXLx674coQ5yevNSGPgyBGSw6Fc755pGDnDznRTgMCnMgS7tbVIrJLCULCyczunbcCA/zUurGXZXBArBzk7XQtiCruZ04FbxcxvSpM9dCD0tAyy9rb14QsLQktPjtoOvrt00+HPXgoEiA0lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(8676002)(66556008)(66476007)(2906002)(66446008)(64756008)(6486002)(110136005)(54906003)(4326008)(38100700002)(8936002)(91956017)(7416002)(5660300002)(86362001)(76116006)(66946007)(316002)(31696002)(2616005)(83380400001)(186003)(36756003)(53546011)(38070700005)(71200400001)(122000001)(508600001)(6512007)(6506007)(26005)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vjh4SzhNMkZURkw3MVBra2oyZEdkL2VocStiR1NOd3dqZkFpY0piWXU5YUxD?=
 =?utf-8?B?UFZ5ckYxZHJGVk1YQUl5a2tDNk9XT21vKzFHek1aMEVkQU5RaE1mTmlWNW1i?=
 =?utf-8?B?WjA2YkJjOW4wT0NsVEpQVVlMMVVjdmxXald3ZWtOci85dGh3VGJlZFIrL3dM?=
 =?utf-8?B?SW9uTnp5K1QvdnZpT1NXa2tLWUMxR2wvYkxWaFR2dWVQOWFxaFRXUUoycmVn?=
 =?utf-8?B?NVkwTjdGOEp0YzI4S3pkUFl5d3BRRG1QOVNvVVZLV1NuaVBwYWF2eGRiV0JD?=
 =?utf-8?B?eFBQMkJySFFtdGVLTGE4cnpEM1ZLemdaR0JIcmtSanJtK2UzVi9SZ3grZXJi?=
 =?utf-8?B?U2ZhdHNkMUMwTmFZUy9jNFBUenpLa2dFdTgvbnFXMTNSM1FNOUlxRnkzR1lq?=
 =?utf-8?B?RkwySXo1WVpZK3VpcWR0RnRDeVdzMmRyWHZtWFlNbDhmcURFTmZMbjB2OUhv?=
 =?utf-8?B?RmVRaTJXa1BDV0wvYXBUUm1XODhNWC92d3laaEZ0U1ZTUDFFTVFhYWJYODNz?=
 =?utf-8?B?ZGVRc1NacEs3ZnVFRXNwS3NNUHd0L1lhcmdQeFdZV3o3RHdEOCs2cGRiVkN0?=
 =?utf-8?B?YzMxVlhpZzF4VmtXYU40ZWRhNVluL1VxbTAxQmtTT1pqMmFaMDltL3EwaGsz?=
 =?utf-8?B?bXdhMUpHUi82TFcySVdPbDhsSWozUnJyN3RYaWk3TWFGeDBjUlo4QVh3bUlx?=
 =?utf-8?B?enY0cWNDdE8wMEFSQWJhVDZUYlFIVEtPMStOSVZDTG83ZllqbmlIMkVMaTZ6?=
 =?utf-8?B?bjBpNnNqSFAydTMrZ3VnUmpFbmhvNXJUV0xJQmJPZVVVd2kzVjhubXUzTnRD?=
 =?utf-8?B?dGRVNS9oMUZqUUcxNHlaUHpUN0tTUUNSeUYxNkJjYnJjTGxJdHlMWHlhWGkr?=
 =?utf-8?B?emx1d1hCV1QyVkVidWdrMkhlWCt1MjhzcUMvamlQMUZBRkpoN2RuUXgzZFMx?=
 =?utf-8?B?dEdFbnZ5VzJDQyt0VC9IRWtYUVYweXB4WU5tRndpRWYxeWJjRWdNQjVjVi9x?=
 =?utf-8?B?U25vejNWbzI4VCt0dDlMN285bkx4MWVxRU52ZktmMitsNllaeTE4M0lNSTl5?=
 =?utf-8?B?L1AzN0FrZXVTOHppZUdFTWg3OFJFcERhZVBKMTBoWjhFbzF2eTdvYlV4djB2?=
 =?utf-8?B?UU1FUUx0OTQ4WlRXbG9XeXBlZ1c0Y21JTCs1VVFlOEp2Z1FnWmtWbC9JdUIv?=
 =?utf-8?B?OXAxNlpLODZqVEVoaEhZUkM3REFuWVoyMVYycWtuMzIveFdUdWpsWCs0Vkxy?=
 =?utf-8?B?QmJzK0hPOWZRMFZ1UjNqWmYrNTRKM3RPMHlVdGlhQ284YXdqek10MVNkajFR?=
 =?utf-8?B?NFlDNHlXL3E3d0VVbjlsbDNuZkg5ZUNvd1doYy8wTXhtMDJhS3VMRERTTys1?=
 =?utf-8?B?U0hOYU5HQVVjTG5xU01VdG43aUEwdXp4V1RYV0IvSmRyczRwNTl3d0lsWS9H?=
 =?utf-8?B?ZmJPZUtjeTF4MVJKWkFZTDc5elBOSnFqOTZFRVk0T2l1N2hDVzlLRDZ6VVJD?=
 =?utf-8?B?ek9mYStUaGIyZXZjU0hKUVZDNzA1aXlpZDA2TUZ1cmo4bnhTMkFkSkR5MGpD?=
 =?utf-8?B?Y2JOSUJDbFFkdlJpUUFVeGZaakljRHRxNDMvRGVqMlM3Y3krczZTUG1ZcCtW?=
 =?utf-8?B?NlNORG8vZFhZcFl4clFDWUd3b2tBemJwYk12dWIzUUJybGxZT1NRbVBCcHVs?=
 =?utf-8?B?TEdWNGlWejkreTF5NzdDY0h5amhrS3p6SXN5eFFRc2FoNDZuZWxvWDIwZzNV?=
 =?utf-8?B?bE9Ca05WdXpvYzZ1MmJRYkxnV0lnajJveE1wUytNWHdxWUY1NkJGSzdubkFU?=
 =?utf-8?B?N2VNbFMxYVBvUXF0SmpuWDZ2MHlHd1dSaE93VXFJQUN2Z0tOc0RMVmxVZTYx?=
 =?utf-8?B?V0xNbHhFVEVIUW5qZ2VJcjdjVlNUTi9oRFJrSUJiNStyQzBwWk9kOG1Ra092?=
 =?utf-8?B?U093THZYakRTQWZpME1XTSt5NktZVVQvTGNtdTZXWHBVeHpsdzltRGtPdEVT?=
 =?utf-8?B?bXh2OHZ3WERIQlUwU0oxY01MbDBWWUpwMVBjbzZkaFAvTzJZc2dQNGZEZEQ3?=
 =?utf-8?B?TE9vMU5aR3FIeXFNSjg2dFNHWmFOclN1bVNUNlZ2YWM1NnRXT04xdE9UQWxC?=
 =?utf-8?B?YTI1MnlBWTYxWFJ5cFRrbFUzMGdOUXgvd0hrMkIvSTg0a2xzRDN5bGsxSXZ2?=
 =?utf-8?B?YXJPc3F5V0t5NHNtZGJtdmhGMnUwa2M2c0x0Y0lwNU05amNReUc1djdPOFR3?=
 =?utf-8?B?YzhLaHFjdnlPR2k0VHRxMFJZazBwbW52Z0dnMDRhTUlpRlUxa3JwQjB5TzZp?=
 =?utf-8?B?S2pycUtiank1RDMrR2MzWVVqUFAyL0dKSlgvY1hUdlgzMkhvU1hYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF4138D4B18CB44C8DAEDC901DED9A0D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d69407f-77c1-4385-0661-08da3c3a5a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2022 21:30:54.2450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4gOHlye9saDYSZiz0AXyU4It9wV5Qiqe/+MGWFADhxzCTs/MmwDI4Lsk1AXHQVyi6pSDEm2pbzw1XH2V5/kudZMfpXPEosvfc9M3t5wA/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

T24gMjIvMDUvMjAyMiAyMToyMiwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6DQo+IE9uIE1vbiwgTWF5
IDIzLCAyMDIyIGF0IDEyOjUyOjMyQU0gKzA4MDAsIFh1IFlpbHVuIHdyb3RlOg0KPj4gT24gRnJp
LCBNYXkgMTMsIDIwMjIgYXQgMDc6Mjc6NTRQTSArMDMwMCwgSXZhbiBCb3JueWFrb3Ygd3JvdGU6
DQo+Pj4gQWRkIHN1cHBvcnQgdG8gdGhlIEZQR0EgbWFuYWdlciBmb3IgcHJvZ3JhbW1pbmcgTWlj
cm9jaGlwIFBvbGFyZmlyZQ0KPj4+IEZQR0FzIG92ZXIgc2xhdmUgU1BJIGludGVyZmFjZSB3aXRo
IC5kYXQgZm9ybWF0dGVkIGJpdHNyZWFtIGltYWdlLg0KDQotLS04PC0tLQ0KDQo+Pj4gK3N0YXRp
YyBpbnQgbXBmX3JlYWRfc3RhdHVzKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+Pj4gK3sNCj4+
PiArCXU4IHN0YXR1cyA9IDAsIHN0YXR1c19jb21tYW5kID0gTVBGX1NQSV9SRUFEX1NUQVRVUzsN
Cj4+PiArCXN0cnVjdCBzcGlfdHJhbnNmZXIgeGZlcnNbXSA9IHsNCj4+PiArCQlbMCAuLi4gMV0g
PSB7DQo+Pj4gKwkJCS50eF9idWYgPSAmc3RhdHVzX2NvbW1hbmQsDQo+Pj4gKwkJCS5yeF9idWYg
PSAmc3RhdHVzLA0KPj4+ICsJCQkubGVuID0gMSwNCj4+PiArCQkJLmNzX2NoYW5nZSA9IDEsDQo+
Pj4gKwkJfQ0KPj4+ICsJfTsNCj4+PiArCWludCByZXQgPSBzcGlfc3luY190cmFuc2ZlcihzcGks
IHhmZXJzLCAyKTsNCj4+DQo+PiBJIHJlbWVtYmVyIGl0IGlzIHNwaV93OHI4IGZvciB0aGUgZmly
c3QgdGltZSwgd2h5IHdlIGNoYW5nZSB0bw0KPj4gc3BpX3N5bmNfdHJhbnNmZXI/IFRoZXkgYmVo
YXZpb3IgZGlmZmVyZW50bHkgb24gc3BpIGJ1cy4NCj4gDQo+IE9uIHY4IENvbm9yIHJlcG9ydGVk
IHRoYXQgc3BpX3c4cjggd2FzIG5vdCBjb3JyZWN0IHdheSB0byByZWFkIHRoZSBzdGF0dXMsDQo+
IGRlc3BpdGUgdGhhdCBteSBIVyB3YXMgZ2l2aW5nIHJlYXNvbmFibGUgcmVzdWx0Lg0KPiANCj4g
U2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZwZ2EvN2ZjZGU5YWEtYzA4Ni0zM2Ux
LTE2MTktMDQ2NjNiZmVmZjg1QG1pY3JvY2hpcC5jb20vI3QNCg0KRm9yIHNvbWUgY29udGV4dCwg
dGhlIHNwaSBzbGF2ZSBwcm9ncmFtbWluZyB3YXMgaW1wbGVtZW50ZWQgdG8gbWF0Y2ggdGhlDQpq
dGFnIHByb2dyYW1taW5nIHByb2Nlc3MuIFRoZSBzdGF0dXMgY2FuJ3QgYmUgcmVhZCB3aXRoIHc4
cjgoKSBiZWNhdXNlIGl0DQpjb21lcyBkaXJlY3RseSBmcm9tIHRoZSBoYXJkd2FyZSBiZXR3ZWVu
IHRoZSBwaW5zIG9uIHRoZSBGUEdBIGFuZCB0aGUgc3BpDQpzbGF2ZSAmIHdpbGwgc3RhcnQgY2xv
Y2tpbmcgaXQgb3V0IG9udG8gTUlTTyBhcyBzb29uIGFzIGl0IGhhcyBhIGNsb2NrDQphbmQgaXRz
IHNlbGVjdCBpcyBhY3RpdmUuDQpJIGFtIG5vdCByZWFsbHkgc3VyZSBob3cgaXQgd29ya2VkIHRo
YXQgd2F5IGZvciB5b3UuDQoNCj4gDQo+Pg0KPj4gQW5kIHdoeSB3ZSBuZWVkIHRvIHhmZXIgdGhl
IHNhbWUgbWVzc2FnZSB0d2ljZT8gSWYgaXQgcmVsYXRlcyB0bw0KPj4gc29tZSBIVyBiZWhhdmlv
ciwgd2UnZCBiZXR0ZXIgYWRkIHNvbWUgY29tbWVudHMgaGVyZS4NCj4+DQo+IA0KPiBPbiB2MTEg
Q29ub3IgcmVwb3J0ZWQgdGhhdCBoZSBvYnNlcnZlZCBpbmFkZXF1YXRlIHN0YXR1cyByZWFkaW5n
cywgYW5kDQo+IGRvdWJsZSBzdGF0dXMgcmVhZHMgZml4ZWQgdGhhdC4gVGhlcmUgaXMgYWxzbyBh
IGhpbnQgaW4gTWljcm9jaGlwJ3MNCj4gIlNQSS1EaXJlY3RDIFVzZXIgR3VpZGUiIHRoYXQgc3Rh
dHVzIHNob3VsZCBiZSByZWFkIHR3byB0aW1lcywgYnV0IG5vdCBhDQo+IGNsZWFyIHN0YXRlbWVu
dC4NCj4gDQo+IFNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mcGdhLzRiNzUyMTQ3
LTFhMDktYTRhZi1iYzVkLTNiMTMyYjg0ZWY0OUBjb25jaHVvZC5pZS8jdA0KPiANCj4gQW55d2F5
LCBJJ2xsIGFkZCBzb21lIHdvcmRzLg0KDQpJJ2xsIGJlIGhvbmVzdCBhbmQgc2F5IHRoYXQgdGhl
IERpcmVjdEMgdXNlciBndWlkZSBpcyBub3QgZ3JlYXQsIEkgaGFkDQphIGxvb2sgZm9yIHRoYXQg
ImhpbnQiIGJ1dCBpdCBkaWRuJ3Qgc3RhbmQgb3V0IHRvIG1lLg0KVW5sZXNzIHRoYXQgaXMgeW91
IG1lYW50IHR3byBzY3JlZW5zaG90cyBvZiAiY2hlY2tpbmcgaGFyZHdhcmUgc3RhdHVzIg0KYXQg
dGhpcyBVUkwgaW4gc2VjdGlvbiAxMCdzIHN1YnNlY3Rpb25zPw0KaHR0cHM6Ly9vbmxpbmVkb2Nz
Lm1pY3JvY2hpcC5jb20vcHIvR1VJRC04MzU5MTdBRi1FNTIxLTQwNDYtQUQ1OS1EQ0I0NThFQjg0
NjYtZW4tVVMtMS9pbmRleC5odG1sDQoNCklmIHRoYXQgaXMgdGhlIGNhc2UsIHRoYXQgc2VlbXMg
dmVyeSBpbnN1ZmZpY2llbnQgdG8gbWUuIEkgd2lsbCB0cnkgdG8NCmdldCBjbGFyaWZpY2F0aW9u
ICYgc3VnZ2VzdCB0aGF0IHRoZSBkb2N1bWVudGF0aW9uIGJlIGltcHJvdmVkIGlmIHNvLg0KDQot
LS04PC0tLQ0KDQo+Pj4gKw0KPj4+ICtzdGF0aWMgaW50IG1wZl9vcHNfd3JpdGUoc3RydWN0IGZw
Z2FfbWFuYWdlciAqbWdyLCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkNCj4+PiArew0K
Pj4+ICsJdTggdG1wX2J1ZltNUEZfU1BJX0ZSQU1FX1NJWkUgKyAxXSA9IHsgTVBGX1NQSV9GUkFN
RSwgfTsNCj4+PiArCXN0cnVjdCBtcGZfcHJpdiAqcHJpdiA9IG1nci0+cHJpdjsNCj4+PiArCXN0
cnVjdCBkZXZpY2UgKmRldiA9ICZtZ3ItPmRldjsNCj4+PiArCXN0cnVjdCBzcGlfZGV2aWNlICpz
cGk7DQo+Pj4gKwlpbnQgcmV0LCBpOw0KPj4+ICsNCj4+PiArCWlmIChjb3VudCAlIE1QRl9TUElf
RlJBTUVfU0laRSkgew0KPj4+ICsJCWRldl9lcnIoZGV2LCAiQml0c3RyZWFtIHNpemUgaXMgbm90
IGEgbXVsdGlwbGUgb2YgJWRcbiIsDQo+Pj4gKwkJCU1QRl9TUElfRlJBTUVfU0laRSk7DQo+Pj4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJc3BpID0gcHJpdi0+c3Bp
Ow0KPj4+ICsNCj4+PiArCWZvciAoaSA9IDA7IGkgPCBjb3VudCAvIE1QRl9TUElfRlJBTUVfU0la
RTsgaSsrKSB7DQo+Pj4gKwkJbWVtY3B5KHRtcF9idWYgKyAxLCBidWYgKyBpICogTVBGX1NQSV9G
UkFNRV9TSVpFLA0KPj4+ICsJCSAgICAgICBNUEZfU1BJX0ZSQU1FX1NJWkUpOw0KPj4+ICsNCj4+
PiArCQlyZXQgPSBtcGZfc3BpX3dyaXRlKHNwaSwgdG1wX2J1Ziwgc2l6ZW9mKHRtcF9idWYpKTsN
Cj4+DQo+PiBBcyBJIG1lbnRpb25lZCBiZWZvcmUsIGlzIGl0IHBvc3NpYmxlIHdlIHVzZSBzcGlf
c3luY190cmFuc2ZlciB0byBhdm9pZA0KPj4gbWVtY3B5IHRoZSB3aG9sZSBiaXRzdHJlYW0/DQo+
IA0KPiBVbmZvcnR1bmF0ZWx5LCBJIGRpZG4ndCBzdWNjZWVkIHdpdGggc3BpX3N1bmNfdHJhbnNm
ZXIgaGVyZS4gTWF5IGJlDQo+IENvbm9yIG9yIG90aGVyIGZvbGtzIHdpdGggbW9yZSBpbnNpZ2h0
IG9uIE1pY3JvY2hpcCdzIEhXIHdvdWxkIGJlIGFibGUNCj4gdG8gZWxpbWluYXRlIHRoaXMgbWVt
Y3B5Li4uDQoNClN1cmUsIEknbGwgdGFrZSBhIGxvb2suIElmIEkgY2FuJ3QgYW5zd2VyIEknbGwg
dHJ5IHRvIGZpbmQgb3V0Lg0KDQpJJ3ZlIGJlZW4gcmVhbGx5IGJ1c3kgdGhlIGxhc3Qgd2VlayAo
YW5kIHdpbGwgYmUgdGhpcyBjb21pbmcgd2VlayB0b28pIHNvDQp3aGlsZSBJIGRpZCB1c2UgdjEy
LCBJIGhhdmUgbm90IGJlZW4gYWJsZSB0byBwcm9wZXJseSBzaXQgZG93biBhbmQgbG9vaw0KYXQg
aXQgcHJvcGVybHkgeWV0LCBzbyBhcG9sb2dpZXMgZm9yIHRoZSByYWRpbyBzaWxlbmNlIGZyb20g
bWUuIEhvcGVmdWxseQ0KSSB3aWxsIGdldCBhIGNoYW5jZSB0aGlzIHdlZWsgJiBjYW4gZ2l2ZSBl
aXRoZXIgYSByZXZpZXcgb3IgYWNrIGV0Yy4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+Pj4g
KwkJaWYgKHJldCkgew0KPj4+ICsJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byB3cml0ZSBiaXRz
dHJlYW0gZnJhbWUgJWQvJXpkXG4iLA0KPj4NCj4+ICV6dSBmb3Igc2l6ZV90DQo+Pg0KPj4+ICsJ
CQkJaSwgY291bnQgLyBNUEZfU1BJX0ZSQU1FX1NJWkUpOw0KPj4+ICsJCQlyZXR1cm4gcmV0Ow0K
Pj4+ICsJCX0NCj4+PiArCX0NCj4+PiArDQo+Pj4gKwlyZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsN
Cj4+PiArc3RhdGljIGludCBtcGZfb3BzX3dyaXRlX2NvbXBsZXRlKHN0cnVjdCBmcGdhX21hbmFn
ZXIgKm1nciwNCj4+PiArCQkJCSAgc3RydWN0IGZwZ2FfaW1hZ2VfaW5mbyAqaW5mbykNCj4+PiAr
ew0KPj4+ICsJY29uc3QgdTggaXNjX2Rpc19jb21tYW5kW10gPSB7IE1QRl9TUElfSVNDX0RJU0FC
TEUgfTsNCj4+PiArCWNvbnN0IHU4IHJlbGVhc2VfY29tbWFuZFtdID0geyBNUEZfU1BJX1JFTEVB
U0UgfTsNCj4+PiArCXN0cnVjdCBtcGZfcHJpdiAqcHJpdiA9IG1nci0+cHJpdjsNCj4+PiArCXN0
cnVjdCBkZXZpY2UgKmRldiA9ICZtZ3ItPmRldjsNCj4+PiArCXN0cnVjdCBzcGlfZGV2aWNlICpz
cGk7DQo+Pj4gKwlpbnQgcmV0Ow0KPj4+ICsNCj4+PiArCXNwaSA9IHByaXYtPnNwaTsNCj4+PiAr
DQo+Pj4gKwlyZXQgPSBtcGZfc3BpX3dyaXRlKHNwaSwgaXNjX2Rpc19jb21tYW5kLCBzaXplb2Yo
aXNjX2Rpc19jb21tYW5kKSk7DQo+Pj4gKwlpZiAocmV0KSB7DQo+Pj4gKwkJZGV2X2VycihkZXYs
ICJGYWlsZWQgdG8gZGlzYWJsZSBJU0M6ICVkXG4iLCByZXQpOw0KPj4+ICsJCXJldHVybiByZXQ7
DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJdXNsZWVwX3JhbmdlKDEwMDAsIDIwMDApOw0KPj4+ICsN
Cj4+PiArCXJldCA9IG1wZl9zcGlfd3JpdGUoc3BpLCByZWxlYXNlX2NvbW1hbmQsIHNpemVvZihy
ZWxlYXNlX2NvbW1hbmQpKTsNCj4+PiArCWlmIChyZXQpIHsNCj4+PiArCQlkZXZfZXJyKGRldiwg
IkZhaWxlZCB0byBleGl0IHByb2dyYW0gbW9kZTogJWRcbiIsIHJldCk7DQo+Pj4gKwkJcmV0dXJu
IHJldDsNCj4+PiArCX0NCj4+PiArDQo+Pj4gKwlwcml2LT5wcm9ncmFtX21vZGUgPSBmYWxzZTsN
Cj4+PiArDQo+Pj4gKwlyZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RhdGljIGNvbnN0
IHN0cnVjdCBmcGdhX21hbmFnZXJfb3BzIG1wZl9vcHMgPSB7DQo+Pj4gKwkuc3RhdGUgPSBtcGZf
b3BzX3N0YXRlLA0KPj4+ICsJLmluaXRpYWxfaGVhZGVyX3NpemUgPSA3MSwNCj4+PiArCS5wYXJz
ZV9oZWFkZXIgPSBtcGZfb3BzX3BhcnNlX2hlYWRlciwNCj4+PiArCS53cml0ZV9pbml0ID0gbXBm
X29wc193cml0ZV9pbml0LA0KPj4+ICsJLndyaXRlID0gbXBmX29wc193cml0ZSwNCj4+PiArCS53
cml0ZV9jb21wbGV0ZSA9IG1wZl9vcHNfd3JpdGVfY29tcGxldGUsDQo+Pj4gK307DQo+Pj4gKw0K
Pj4+ICtzdGF0aWMgaW50IG1wZl9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPj4+ICt7
DQo+Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmc3BpLT5kZXY7DQo+Pj4gKwlzdHJ1Y3QgZnBn
YV9tYW5hZ2VyICptZ3I7DQo+Pj4gKwlzdHJ1Y3QgbXBmX3ByaXYgKnByaXY7DQo+Pj4gKw0KPj4+
ICsJcHJpdiA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0K
Pj4+ICsJaWYgKCFwcml2KQ0KPj4+ICsJCXJldHVybiAtRU5PTUVNOw0KPj4+ICsNCj4+PiArCXBy
aXYtPnNwaSA9IHNwaTsNCj4+PiArDQo+Pj4gKwltZ3IgPSBkZXZtX2ZwZ2FfbWdyX3JlZ2lzdGVy
KGRldiwgIk1pY3JvY2hpcCBQb2xhcmZpcmUgU1BJIEZQR0EgTWFuYWdlciIsDQo+Pj4gKwkJCQkg
ICAgICZtcGZfb3BzLCBwcml2KTsNCj4+PiArDQo+Pj4gKwlyZXR1cm4gUFRSX0VSUl9PUl9aRVJP
KG1ncik7DQo+Pj4gK30NCj4+PiArDQo+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX2Rldmlj
ZV9pZCBtcGZfc3BpX2lkc1tdID0gew0KPj4+ICsJeyAubmFtZSA9ICJtcGYtc3BpLWZwZ2EtbWdy
IiwgfSwNCj4+PiArCXt9LA0KPj4+ICt9Ow0KPj4+ICtNT0RVTEVfREVWSUNFX1RBQkxFKHNwaSwg
bXBmX3NwaV9pZHMpOw0KPj4+ICsNCj4+PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX09GKQ0KPj4+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtcGZfb2ZfaWRzW10gPSB7DQo+Pj4g
Kwl7IC5jb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGYtc3BpLWZwZ2EtbWdyIiB9LA0KPj4+ICsJ
e30sDQo+Pj4gK307DQo+Pj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG1wZl9vZl9pZHMpOw0K
Pj4+ICsjZW5kaWYgLyogSVNfRU5BQkxFRChDT05GSUdfT0YpICovDQo+Pj4gKw0KPj4+ICtzdGF0
aWMgc3RydWN0IHNwaV9kcml2ZXIgbXBmX2RyaXZlciA9IHsNCj4+PiArCS5wcm9iZSA9IG1wZl9w
cm9iZSwNCj4+PiArCS5pZF90YWJsZSA9IG1wZl9zcGlfaWRzLA0KPj4+ICsJLmRyaXZlciA9IHsN
Cj4+PiArCQkubmFtZSA9ICJtaWNyb2NoaXBfbXBmX3NwaV9mcGdhX21nciIsDQo+Pj4gKwkJLm9m
X21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKG1wZl9vZl9pZHMpLA0KPj4+ICsJfSwNCj4+PiAr
fTsNCj4+PiArDQo+Pj4gK21vZHVsZV9zcGlfZHJpdmVyKG1wZl9kcml2ZXIpOw0KPj4+ICsNCj4+
PiArTU9EVUxFX0RFU0NSSVBUSU9OKCJNaWNyb2NoaXAgUG9sYXJmaXJlIFNQSSBGUEdBIE1hbmFn
ZXIiKTsNCj4+PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPj4+IC0tIA0KPj4+IDIuMzUuMQ0K
Pj4+DQo+IA0K
