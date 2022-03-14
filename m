Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54444D7EF5
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Mar 2022 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiCNJqp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Mar 2022 05:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiCNJqo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Mar 2022 05:46:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279931914
        for <linux-fpga@vger.kernel.org>; Mon, 14 Mar 2022 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647251135; x=1678787135;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BK1K7phGMxWJP3zKFp//wuJ+tfY/D5VdP1DgY9hECk8=;
  b=HxZGKydJfZ7B+mWmdYtgRhSVZwE5wFuYuBvgaEzwt7C6SASuCH/cJj8f
   qbMePQl+mLeSdBOceTocj2ze/V975jgjGWR0ZM+dwtFIj39haxWOrldiG
   ogKd+6ES87eULqOgkVbrdTdku3PV3XNVM4NbhPSSxsmAU0Vw3D342xIa7
   /xXdHKYVYxdMBj9lJfjN3X9DyLm2C0d6TGgDmYbCTT1X+U9DHgZ+k03wl
   akditkBP0CkssEVoDObpXnDf7G46QPOlYvlmAwBVqCp6D8UmYkiLCWGPM
   drRfmdP1I25Ky/wOwyvkY5UrOFfd9FmluHuskdGPNu3Fy1o8ev57z8XDc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238152578"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="238152578"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 02:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="645731726"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 14 Mar 2022 02:45:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 02:45:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 02:45:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 14 Mar 2022 02:45:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 14 Mar 2022 02:45:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHjLXJOWmmf4RGeKLNPJZ1l1t92xiiV5+x37N3ABYAPGUopZQoqsJVahEm3Oxpxy7qF1ODAfM6V4HisU+Nly2J/Hl+PZuxBB/XaYLKNn4jbCrHhqSNSxE/AbkBiGm0V51gALa1AgR5aXXVMNzckAJ7WCAJc0buMf0eF9AGIjAygTVK0xyhDDuRn5i0uL83RNPTNFbChsRlJmDcryjSRFhs6vAP1PHDJdpdb+H1ICs1VckjwAHCUpap4XyteTuPRExON8wmwz3kEuOf0gmFLkd+X6qKewgNqZsN+IcTjpM8wlIOQ3EVeJQ7wlyhqfdz+mIait4CbAddX/IfZsVP/2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK1K7phGMxWJP3zKFp//wuJ+tfY/D5VdP1DgY9hECk8=;
 b=acl4d8h8+RsNwHOpFm29ib7LQjgaJNlpB747ZhfehuM76lsZ9sz3MYjGg/eUGyVJiDHpQGsyH1smtkTejFccYSN43RIcXGk9fkMvMytMsLFQdyWbyJgVil6F+BpT1hKIIdha3DYi487qJWDTgeat5SaBUAhKlDQUZq9JX6+f6bFVB5BsC5zamoJYSz+2+hMck//9NEgy9mryu3O45OPXhrPeB+4e5bzm1KDIUr9OqqOb3f1OgrtGTCB2ay0E8JcgknTO58pB157oJqjD2vELaFkGcclDbe4mnOfr70fXkFI5XrAQE27C4p/IYFr2+/JAJ/ZTxMjlutwmeLa4mkwY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SN6PR11MB3407.namprd11.prod.outlook.com (2603:10b6:805:bd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 09:45:28 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 09:45:27 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Index: AQHYMrhKml+FZWGpG0uUYk5qH7zFV6y5BeCAgAB5IgCAADjzYIAEhEiAgABuVrA=
Date:   Mon, 14 Mar 2022 09:45:27 +0000
Message-ID: <BN9PR11MB5483A25DF3AEF87F83AA4A9DE30F9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 418db7a4-5546-4f9f-43da-08da059f5f15
x-ms-traffictypediagnostic: SN6PR11MB3407:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB3407F2AD4171943FE2652A3AE30F9@SN6PR11MB3407.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14KWMlpBdfSzga9fz3jLchOEf4Wzh5id5AfJwwBtaIPv9mmFjMBc+Jx5hmolB6awBrVruUSkT9HBZbuGgYliIBWas9ce6ZLoKyoso+hjRePNB5VXcERVSR2/Mec8zPCMrUoEGfgW90wwRx5eXUOK2Ad6haBeladixx7Gf+hjdxS8gZBfpl/7TyJAlmlHwh++lMCPdAKS+R49sNEXZSXcglznRBUd+t2s3bjoHs51IFiOvqTYyzp/jK+kJxpmkPFO/bFAhzpN+gqo7DctYe7Pn4IG5XOVl5ZUXj+I0hKcRiK1+XH3/jif4cy7KKVHenY5pBpYohn8hzHgWqIFt6zyK5CFHr3Q96QaWmekMRDijGSnwvBRQz4Av+wVWIpJK8yV5Y5x7uthWfHq00JDLdGgi5eCZKdxY8ZkweJ4HJ2TrHVb+tXSmypbjKUO76IL/Jl/Q4UVCemZK5Zji/SCtDktjOT/qst53BmgWVasUQ0VUooBL3kDQ2L8RcWwFFfpPzTPKO/MdRDlmltqFlfJsmxTKEtX9DxMsnJbkEEvtzXRbLzrSn8l4GVxXZtd4eJA6TPj9GQ91WcDZKewtDhsunGQZL6r2zdTkodl/Asd0pLfRnrZOxyXzvU5zxtM8ZZui2AqgNN0jXugXiV4aytIX8Cu8QS0Xllv9Oz4de8jP23F0IgkQOm666y/eD9vq4R2Zz+JdskxuA+BMq19h1dwOyNABYyzg0ildDAJFNxe5MSmqqZR1GAXqSNmMvca9N/tKgfgbF/8tOzirDUtAS8KQofUfPcSZm8J2ijChb1Vi/Bil/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(66556008)(66476007)(76116006)(66446008)(64756008)(4326008)(8676002)(54906003)(33656002)(83380400001)(110136005)(316002)(8936002)(52536014)(55016003)(966005)(82960400001)(86362001)(71200400001)(186003)(122000001)(38070700005)(508600001)(53546011)(9686003)(6506007)(7696005)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzE2OTJBWEtrTU96QUE3NE5VMWE0U0xjMDFTdTVJVjFWNGkyWEhMQ2tYQ2di?=
 =?utf-8?B?Z2YwNDFXYlV3STlDK0VrQWNOelJqNGJrUFAxK3NUUzhzTVhUK1dFQk9VNThS?=
 =?utf-8?B?SEE0ZVJmRDRhTnRCWEN1VW1OZHRDcXYzSnAwRTQ1QU55NEEzcGg4WENaL0ht?=
 =?utf-8?B?YVk2dThwZld1b3JqaHZVSG13OEpLTm94cWk1T1ZVZWlyczhLSzQrdnJlZ1BP?=
 =?utf-8?B?WWFoV25uNnQ1cDBXUU5STm1IQVo2cEtDdVRHYXFqaUR6Yms5K0Nrd3lNaUd6?=
 =?utf-8?B?dVoxelpQbko1V1FJYTRwc2hqWGFoZ1hSZExGUUNUa2wzdWM2RVB6OTJUMnlP?=
 =?utf-8?B?KzBidFFpVytDKzlxYUxWa0pMUDFTaUdua0d4TXg2VjR6RWN2UzMzeWdYaEZ6?=
 =?utf-8?B?dWMraFJieGVRdzEvcDlQb3h2MzVSVUowWEplemVEdFNlRU5XOCtlWWFkanVl?=
 =?utf-8?B?L0lrRTJ5dFd1d1BmQ3Q1UTU4dGFlYVg4alNXRHNqVUJrK0M0Y3JnVU1lRld5?=
 =?utf-8?B?ZDZJdXhSOXo1YjNUUUJGaDgzOHpYd2lsaWpFczNZdWpVbi9WNkNWdEkwRThi?=
 =?utf-8?B?UXdCaTdnNzdZOUdEQ0VCTkg4ZUFPM2I5QUl3eWU4ZmRxU1Nxai9OdWhRd01y?=
 =?utf-8?B?QVRIN2dDSWpuVTJjZDMycXh6eE10a2U4MURHYitNZUtHU3NuQTJKQlh4NXVu?=
 =?utf-8?B?YS95YjJidEU4cVdhUHNGRStnNSswV2JuN01tNFVMVjZaSy9TcjV4STcyQ09H?=
 =?utf-8?B?WGpzTjJwOGgzWWJ1NmtrdlpaSFZRU25vdis0RjQ4OCtQQy9qVmgxYUl2M1Q4?=
 =?utf-8?B?QnVuZnNxRFlNdWhaeWRPN0N2USt6ZWt4OENZcDN0WFNyaGJVZTB2bGh1dDFI?=
 =?utf-8?B?REVyVUJ0b0N5M0VRNDMyMjlrb3lFMHFNeVZuU28wYWl6RDloVnFKZCtFSjh0?=
 =?utf-8?B?eDY4alRJbm1nRExYaEJJZDFOb1hDeDBGOHBrcGlnMHZrZkdvTjJVZUE0Rysy?=
 =?utf-8?B?eGFhY0xXNWVQRC90S1dXVndmemdOUTlnRWtNSi9SZXNkVjkvRDl4anl5UWxS?=
 =?utf-8?B?MzFQdFhnWlRseFU3THYxcmlkcUZyZ3dHTE9GdHlVelRtTm5UVEpvT0NoWmov?=
 =?utf-8?B?cEcrNTFXUFJTMDZwUE5POUs5NWIzWTZtWGFxc2g0NFZSS1ltUHh0MEY1UU92?=
 =?utf-8?B?VHRpRGZXMzJUN0d5a3V0VzlDVWNUOFpwRjVyek9TZVNkNXRFZlM4MDQzTDNm?=
 =?utf-8?B?a2Q3N1FablFhTHVCdTc4blcwZzVlUDI4Z24wNWJ6bzJTNG1mWCt4NWp0TVpD?=
 =?utf-8?B?Z29PRlBITzFCdXBFVUUvVVpQNGErTXZpR2VhYmgwdzNVVHlFUm1nWmRKWDE3?=
 =?utf-8?B?OGlveDVIMWcxUU54WlpaZkpESG5ITHZZTUxXNDhkSHcybzRhTDVHV09OQm9t?=
 =?utf-8?B?dzJOV3J4dU5qK3ZoTmdrWnNYWWNvdmp0d0NJTTlPdzU1TzVYT0p4NG90dGtx?=
 =?utf-8?B?U1oxTy9mWVdqWno2b0lydTVVaVI1bzBKYVhFT3M4OHVaN2JYaFBJUld1TG4x?=
 =?utf-8?B?TVZMc0ZhdFBsWXUrQUZHSFMwMG5ZcEJxK2gxMEpYcW5YZGdiQy9UY2NrV1J6?=
 =?utf-8?B?YlpoUE1rT2lKU2FRYXp4YVNST2FXWkx1aW1QSjFYb2kzTUJlMU5EUWxJSkFR?=
 =?utf-8?B?dnJLQ1A3SWY3Rk5jcXVMcEJNM25MVE4xYUNLQlhWa1l0MFBzV3JwWDR3cGg0?=
 =?utf-8?B?cHYrVnRtTkZtWlcxbHRJejdPY0N5aDJKeTNxUmRPUnYydXVzQnl6cS9WcCtl?=
 =?utf-8?B?NDgxQzNNQ0R1ell6MjJKVkRVczhhRG54MTJnY3BzNnZyV096MEx4ZFd4VHFu?=
 =?utf-8?B?YksxWXBNTDQyYlFTeEdneWRYdU5VSjNwRFZKa0ZJbVdaWmgvQnY5SGdXZDJp?=
 =?utf-8?B?SEcxaEJ1NVRoTGtZVDF3MHZJNkpVazdZc2FicDRmb0o4V0JxYW5sc0hBeGNU?=
 =?utf-8?B?U21lOURJc3RSSHRrL1VrV1VuemlOVFlaN3ZFeVQ0MkJFSkZXc2NFUmY2cjdE?=
 =?utf-8?B?VURlQTF5ejRIWlpaSm9uZ3JXZWNvMml2YUJBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418db7a4-5546-4f9f-43da-08da059f5f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 09:45:27.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqMrR5ZbjY3AXXCZ8Ro9RAcnr7uijCKgVkmlpNqlSrxQT5EKwIzq8CeBLNMkHBctCblY9RZ7XnVrFidWkaVeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNCwgMjAyMiAxMTowOSBBTQ0KPiBU
bzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgV2VpZ2h0LCBSdXNz
ZWxsIEgNCj4gPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsgdHJpeEByZWRoYXQuY29tOyBt
ZGZAa2VybmVsLm9yZzsgbGludXgtDQo+IGZwZ2FAdmdlci5rZXJuZWwub3JnOyBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZw0KPiBDYzogWHUsIFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+OyBN
YXR0aGV3IEdlcmxhY2gNCj4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjFdIHVpbzogZGZsOiBhZGQgSFNTSSBmZWF0dXJlIGlkDQo+IA0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFd1LCBIYW8gPGhh
by53dUBpbnRlbC5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIE1hcmNoIDExLCAyMDIyIDEwOjQ3
IEFNDQo+ID4gPiBUbzogV2VpZ2h0LCBSdXNzZWxsIEggPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwu
Y29tPjsgWmhhbmcsIFRpYW5mZWkNCj4gPiA+IDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IHRy
aXhAcmVkaGF0LmNvbTsgbWRmQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+ID4gZnBnYUB2Z2VyLmtl
cm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gPiBDYzogWHUsIFlpbHVu
IDx5aWx1bi54dUBpbnRlbC5jb20+OyBNYXR0aGV3IEdlcmxhY2gNCj4gPiA+IDxtYXR0aGV3Lmdl
cmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlv
OiBkZmw6IGFkZCBIU1NJIGZlYXR1cmUgaWQNCj4gPiA+DQo+ID4gPiA+IE9uIDMvNy8yMiAyMjo0
MywgVGlhbmZlaSBaaGFuZyB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBNYXR0aGV3IEdlcmxhY2gg
PG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBB
ZGQgdGhlIGZlYXR1cmUgaWQgb2YgdGhlIE9GUyBIaWdoIFNwZWVkIFNlcmlhbCBJbnRlcmZhY2UN
Cj4gPiA+ID4gPiBzdWJzeXN0ZW0gdG8gdGFibGUgb2YgaWRzIHN1cHBvcnRlZCBieSB0aGUgdWlv
X2RmbCBkcml2ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3
IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogVGlhbmZlaSBaaGFuZyA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
PiA+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBp
bnRlbC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvdWlvL3Vpb19kZmwu
YyB8IDIgKysNCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWlvL3Vpb19kZmwuYyBiL2Ry
aXZlcnMvdWlvL3Vpb19kZmwuYyBpbmRleA0KPiA+ID4gPiA+IDg5YzBmYzdiMGNiYy4uNjYwZTFk
MGJmNmI5IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdWlvL3Vpb19kZmwuYw0KPiA+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvdWlvL3Vpb19kZmwuYw0KPiA+ID4gPiA+IEBAIC00NSw5ICs0
NSwxMSBAQCBzdGF0aWMgaW50IHVpb19kZmxfcHJvYmUoc3RydWN0IGRmbF9kZXZpY2UNCj4gPiA+
ID4gPiAqZGRldikgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICNkZWZpbmUgRk1FX0ZFQVRVUkVf
SURfRVRIX0dST1VQCTB4MTANCj4gPiA+ID4gPiArI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9PRlNf
SFNTSQkJMHgxNQ0KPiA+ID4NCj4gPiA+IFdoZXJlIGlzIHRoZSAiT0ZTIiBjb21pbmcgZnJvbT8g
aXMgaXQgZm9yIGFsbCBPRlMgZGV2aWNlIG9yIGEgc3BlY2lmaWMgY2FyZD8NCj4gPiA+IEFueXdh
eSwgY291bGQgd2UgaGF2ZSBhIG1hdGNoZWQgbmFtZSBwZXIgcHVibGljIHRhYmxlPw0KPiA+ID4g
aHR0cHM6Ly9naXRodWIuY29tL09QQUUvbGludXgtZGZsLWZlYXR1cmUtaWQvYmxvYi9tYXN0ZXIv
ZGZsLWZlYXR1cmUNCj4gPiA+IC1pZHMucnN0DQo+ID4NCj4gPiBZZXMsIEkgdGhpbmsgYSBtYXRj
aGVkIG5hbWUgb2YgcHVibGljIHRhYmxlIHdpbGwgYmUgYmV0dGVyLiBIb3cgYWJvdXQgdGhlICIN
Cj4gPiBGTUVfRkVBVFVSRV9JRF9IU1NJIj8NCj4gDQo+IE5vLiBXZSBhbHJlYWR5IGhhdmUgdGhl
IHNhbWUgbmFtZSBmb3IgaWQgMHg2IGRlZmluZWQgaW4gZHJpdmVycy9mcGdhL2RmbC5oDQo+ICNk
ZWZpbmUgRk1FX0ZFQVRVUkVfSURfSFNTSQkJMHg2DQoNCklzIGl0IHBvc3NpYmxlIGNoYW5nZSB0
aGUgIkZNRV9GRUFUVVJFX0lEX0hTU0kiIHRvICIgRk1FX0ZFQVRVUkVfSURfTEVHQUNZX0hTU0ki
LCBhbmQgdGhlIG5ldyBvbmUgaXMgIiBGTUVfRkVBVFVSRV9JRF9IU1NJIj8NCg0KDQo=
