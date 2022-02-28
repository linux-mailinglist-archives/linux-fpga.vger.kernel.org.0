Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A664C6941
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Feb 2022 12:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiB1K71 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 05:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiB1K7S (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 05:59:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DFB86A;
        Mon, 28 Feb 2022 02:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646045869; x=1677581869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zRpMEIG3eRURv/mYYREkI9KyA58l45KNNdREasR7pk=;
  b=e9dmQwwHe6foFgOnyCHJp+P5nlCwkwORTeAVzjeXCfsqgOg4S9jTP5Ny
   zKR1mmSGhmDAbVzNoPW86DJA+SJ0cBeW2US22bcUcH5sDg/mJZ9xKyrwQ
   K8rywOECerpqmyyV9s1UanYtLU54fl0OKtbDhq1hC0P0zOglDGJmLRsul
   MOk0gOMUH7WJQM+DBuSlt5dtPxuBsMoVMbpuC8t9dVd3q12gxhg8n4JSl
   OB9ADhVxqt6hy7BMcPLugSmzp+Siv89JyaVM8+dOCeH3pN4Z3AOFPgByH
   QE06Yv9TaIQXOc+yFz/3oF6NSQWHj0xMxnLMemzrf+BsCJ7X8RFSDZJhb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="339293973"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="339293973"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 02:57:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="708605203"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 02:57:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 02:57:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 02:57:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 02:57:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 02:57:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC2i/l/R2Kn5ZYqqtqCUpdAD7b7NjdqDQ4/7l56EYWDmV1y1/OPkg6ut7jH7dnZXgQMr6Nh6kA0BrFYgLE8fUbTLUoEZLECiZcoa+b/TaRy6v5pb+iuSvqU4TnIDf/QSMtkVqWmOdvvrULZBy/c7A3Wz9RWjG4ciFD5yz9c7y+zPW8trfIiYnSRkXqjU/VzGNrsIP8pQ9zfX7LzTPcZL8VZmu7YM6e5zb0pAO1JObvhWIUkl1Qqj+zg3gMZmpd+6alqzCwg5xxIx2fRxye/1eP3Z4rji/zkF/jlZHn9a9Dc1VUxa0bx0+TqZCOvT9690d5Wv0ee/7QcgpPgba6mdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zRpMEIG3eRURv/mYYREkI9KyA58l45KNNdREasR7pk=;
 b=FUq52xnz0887CAwvNuf+C4ZDi5izOVHUbGI1EpHXkMUZJ99B60Dfu4m1y7vXaR3yR5XrWJ3dP3carHOka9nzL8I3rXDsPo/DL3Ne+fBsFbNhUmTL6EA5SfU1ctUqGzY8p4il+bPW8dF1Zxiof4CzmU5Rx68pDD4H56IYqavI0GGx/4jqVT7XIvxCMKNJ248b0wTbHn56fU6SeHI0RsHTOah4jQvU3C9IFvey9e/cqKeCUN1CsODaTIUMcXtMGGbLGVw5/EFgVdg2GB+2x4kWpz1F2uRCxzfLLBj++G79uoAHmFlCxCX/8NVQ+6TX4U3u4cIg2l3SoypdV8FtNfZhMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Mon, 28 Feb
 2022 10:57:45 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 10:57:45 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Tom Rix" <trix@redhat.com>
CC:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Grier, Aaron J" <aaron.j.grier@intel.com>
Subject: RE: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Thread-Topic: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Thread-Index: AQHYKaeVOPmbG/7a10yxBqZVPNMIu6yoxmCA
Date:   Mon, 28 Feb 2022 10:57:45 +0000
Message-ID: <DM6PR11MB38194BD59EBFE97F125A37B685019@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-8-tianfei.zhang@intel.com>
 <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
 <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com>
 <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1>
 <e5580849-c137-fb61-0599-198c341bf688@redhat.com>
 <BN9PR11MB54835A454A34ECE13349B555E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <d6cf0f48-e90a-6441-6096-5b87122a0bb6@redhat.com>
 <alpine.DEB.2.22.394.2202240932380.634457@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2202240932380.634457@rhweight-WRK1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3824a5f8-31d2-4464-cb03-08d9faa92696
x-ms-traffictypediagnostic: PH0PR11MB5904:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB59046C903D878EA32255F92285019@PH0PR11MB5904.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Huq/FeycwhvSdvwxp94yguA4LmGdt0jadJO5Dmmj1bgDzcEmHjs5Wc2RsGGRXWZklfpSLZm62eapPoDUVQCjN3GlIJgqH9GdME4RAoLFn43FzSjQVuqSzw3rZdUSNxILBz5qo/RJGfr4ZyEudPz7Uq7du7+fS58ibIWz0UwgRsf9YxK5Yx6Yq1ZrAOC8LGq9NU2F9Ts0FPEOpBrYPD6Q5AwrGNsCZYOV4wjpjr9FpxNILrM2/ujyu9rPSZxB1Gn5nP9e/NFEGUHXUuyKL7CFKvQ/bnt9EQutRDZQx09UzXwCRmPIRffGtBThZ+8gKK9Nysco1AinOetwl/oD0R7hydlImY1EGdlxyF54tEgBIIkNEsQK1NbrJe7Gv4zLrawnFQ88STVpE4LXHUHpPYEDvqDomUzYg3+gN1fGv7L9zclajYh+XpnGPPFmlPhLwGoQ9dbMTWSuqg+gYC7c9cQ+RB5Juw/HNO/p/CLTSkBKZZYICVTYJYsNDmx3K6crFjtIumBFiUCjbmjpN0sqZ5RHY44eLP6cstdSu4vnsfOuMecsegIpY6q+I8VMMu3qKGrvOUh82OXA6aqVFFMwiwwzynlX0xJisO7OGGAjnc0FGRBqkYxQGWu4q5mmT6ypD0e8C0bVxsb8rpT0yguKntvg7tNLEFQII3WCQBEkWMB2cV9xwVdTR52dJnh2AiWJJ4zc5wyuRoJWWRT1PxhNyvjrQ8rBJspCewsV3tAi6bN9YUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(122000001)(86362001)(38100700002)(7696005)(38070700005)(71200400001)(9686003)(6506007)(83380400001)(52536014)(2906002)(186003)(26005)(82960400001)(53546011)(66946007)(66476007)(5660300002)(8936002)(4326008)(8676002)(66556008)(316002)(66446008)(64756008)(54906003)(76116006)(110136005)(33656002)(55016003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejVwZFF4UXZyam5qSjh0Z0VTczUwMlZxS1FhNEMxc05USklVT2R5d3JML3ps?=
 =?utf-8?B?cmdERzVPaDhIalYxTDd0OS9NRC9jVnFsaUI0TjlVVWZWckJJZjJNR2Nxai9N?=
 =?utf-8?B?QUpMcDhIWlJOcnBEdmN0RzBiZVVZcEZwb2hhaHl0ankrdkQzNnZDMFBadjV2?=
 =?utf-8?B?R1VreW8wVG8yMS9wYXYxSnhOV3VzSjJFbU5jL3lCWVAvdCtidWpValRtYWRL?=
 =?utf-8?B?US80VFAyYkNxMVNWcUd3dEFTaWJEeGVxdUF2cWVnZ0M3eWRpdnNmZTVGdWJD?=
 =?utf-8?B?LzNkcmtxMkh0cUZ0WVJJZ0hCLzY5ZlhyOHl4anBETUZnTVhQZ2tweDcxZEV4?=
 =?utf-8?B?eTNFY1VBWEFwb3BnUHBHNXN3TUxGbjZ5c1l0WU9aTGQyeHhBNFl6dkI4V1BJ?=
 =?utf-8?B?bkZ0R0RCUXdIcUVJSmNIVzJQMlRiMXdXNTNrd044elZzYmlVUXhmT0ZrTGtJ?=
 =?utf-8?B?aUJadDlSSFNpazhZWVJhenFqdnVyUStKZUcrN1Njck9vSEdmc2JoNHZFSjcv?=
 =?utf-8?B?c1Z3dlJGNUVuVmVLTVhUSVVjaThrdi9CVS9ZTlFLdEZ6Z2NSUnJ1TnJ6bk9t?=
 =?utf-8?B?U2p2c25NK0xwL2pYVGxpdi8zdnN2b1RSb0FpUTREcXQ5SWJmV3B3OUZpMlJF?=
 =?utf-8?B?S2QrSmtMbkdaQW1aWXBpTVF5dU9HVi9LU2RiMXd2NVgzK1RZaC9SKzBZS014?=
 =?utf-8?B?QkJzc2Q4a2ZZNExsaUhJd2ZGRnkzZFcyTEt2LzhFNTh3eFF5TmUzVWx6L1Ny?=
 =?utf-8?B?VGNCa0wwVy9FZlFWWHZ4cjVDd3BQbVp1WVlnaXJHODZSSVV4ejlYUnBnMk9U?=
 =?utf-8?B?RHdBK2pUbVJZNE8wMmZlOFRKY3VzeDg1YTFpMVgvNGY5dUxPWlNRQnhieVZl?=
 =?utf-8?B?Y3RKOWJEMWdWZE9nakV5dEMvZ0Y2OGJYd0VwaVdDeXM5RGZqdzNaRFBjc2E5?=
 =?utf-8?B?bU5RNVdYRnI0YkhaalZKSCt4U2J3ZmwzV3gxZmJCY2J2ODVzL0FVeERXS0Jq?=
 =?utf-8?B?Z2g3N2dzcUJHVmg4UTdhMnI4NUpzcDRtMW9XK29aS2h3V1ZUckRCRk5WdkdH?=
 =?utf-8?B?cTd6QzRmS1FiTW1KVHhBVmVjb2poSjBpeXEzU0phaGZURWlqWHJpMHNnVHhT?=
 =?utf-8?B?THZ6dWEwVHpRTjVJbTZ6MndsYUFpaURITGQ5dG9KVmxnV1hoT1ovT205R0F5?=
 =?utf-8?B?SnJDeXRVT0JvOWV6TElDV1FLcTZRZndxZzJJTWczTGJnVW8zdXVMZ09VRkJG?=
 =?utf-8?B?aXhvZGgxb2U3czF2SHdrM1BMR2RLMGNMRGQrNGZYUzBMcU1Jb2FiVjlDbzNo?=
 =?utf-8?B?ZGcxYWNRa3dGYWk4MmtWclNaNHV2dC8yYmNDcEliSE4rRFRueW5UekZ1Qkx1?=
 =?utf-8?B?Ujdqb0FVelVHelVFZEVFSGsvakF5TUk5WVhub01jcmFMVEhTK0Z5MURiQXFx?=
 =?utf-8?B?TmZBK1FHQzVYeGl2TXVlNDR5UXlkdExDMktzQ2wvUmxOdEtjelkrSVU0Umdo?=
 =?utf-8?B?V2ZBY0RPYUl6N2J3QkhtWUhDQ0c5U2RQSFhIVUh6TWgzZzJQVDAyb05QYi8z?=
 =?utf-8?B?aklFa2gxanRpRW0vcnlub1NwT0NBbDVrd0hyeVlNSzFmRm9ua0JaZHBnMFNT?=
 =?utf-8?B?cUxLTkhQTnVkZG5PbzlMdGhJM291UmRSRFRlRjRXR0tuSmk0aEVGVGhscUJa?=
 =?utf-8?B?di9LblJUS1VETk1uVnVRZzVlZDVWZWt2R0pUb3VhSmxIcGMrZ0hwYi9SOWdO?=
 =?utf-8?B?bXVrTmlSUCsvNW5PZi81UFh4aFFRR3JUTlBuQ1ZJQkhiZ3M3MlJJWXEya3Q2?=
 =?utf-8?B?ZVFybXVqY28zbjFFbE9pdGFVVEprTnBZdHZ1YXQ0aENTNGlsbTJQUjF4cUk0?=
 =?utf-8?B?aTNablZ3VUpXNFprTW5ZbzNkaU5pWnZ0WnUzQzE2L2N1TmxKdldRaG96YVcx?=
 =?utf-8?B?ZmNIbHJFZ3Zua3puWFFWVnJCTUxWNmY2OUJjQUlVTjQ3QUwxdk1iUDlvYkpB?=
 =?utf-8?B?Sk01blJyZWJCZk9KRTJIaGxsc2ZiNDBPOHY4amdReXN5ZkI1S3NBUWhGQzNB?=
 =?utf-8?B?ZkVlZGtGT0hCd3g1ak15cGtuTThQSmtRUldwWVNlUjZuRTRGTnRSN1grNlNs?=
 =?utf-8?B?RFpiL25JQ0NzS2s5eEdZYzFraERmQWlxREpmZ05OV1A2bjV2Y2pVTTVVank2?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3824a5f8-31d2-4464-cb03-08d9faa92696
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 10:57:45.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cDIylahmUGL9DGMJWKWczAmyI0jILhyBCvU2P2v8hNa4EMH+fIKNsuyAumCwSSeYpGr1cL0tBrx3J8nk3rRCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+DQo+ID4gT24gMi8yMS8yMiA3OjExIFBNLCBaaGFuZywgVGlhbmZlaSB3cm90ZToNCj4gPj4N
Cj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBUb20gUml4IDx0
cml4QHJlZGhhdC5jb20+DQo+ID4+PiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyMiwgMjAyMiAy
OjEwIEFNDQo+ID4+PiBUbzogbWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbQ0KPiA+Pj4g
Q2M6IFpoYW5nLCBUaWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IFd1LCBIYW8NCj4g
PGhhby53dUBpbnRlbC5jb20+Ow0KPiA+Pj4gbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWls
dW4ueHVAaW50ZWwuY29tPjsNCj4gPj4+IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOw0KPiA+
Pj4gbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgY29yYmV0QGx3bi5uZXQNCj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgNy83XSBmcGdh
OiBkZmw6IHBjaTogQWRkIGdlbmVyaWMgT0ZTIFBDSSBQSUQNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4g
T24gMi8yMS8yMiA5OjUwIEFNLCBtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tIHdyb3Rl
Og0KPiA+Pj4+DQo+ID4+Pj4gT24gRnJpLCAxOCBGZWIgMjAyMiwgVG9tIFJpeCB3cm90ZToNCj4g
Pj4+Pg0KPiA+Pj4+PiBPbiAyLzE4LzIyIDE6MDMgQU0sIFpoYW5nLCBUaWFuZmVpIHdyb3RlOg0K
PiA+Pj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4+Pj4gRnJvbTogVG9t
IFJpeCA8dHJpeEByZWRoYXQuY29tPg0KPiA+Pj4+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVh
cnkgMTYsIDIwMjIgMTI6MTYgQU0NCj4gPj4+Pj4+PiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5m
ZWkuemhhbmdAaW50ZWwuY29tPjsgV3UsIEhhbw0KPiA+Pj4+Pj4+IDxoYW8ud3VAaW50ZWwuY29t
PjsgbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsNCj4gPj4+
Pj4+PiBsaW51eC1mcGdhQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9y
ZzsNCj4gPj4+Pj4+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+Pj4+Pj4gQ2M6
IGNvcmJldEBsd24ubmV0OyBNYXR0aGV3IEdlcmxhY2gNCj4gPj4+Pj4+PiA8bWF0dGhldy5nZXJs
YWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDcv
N10gZnBnYTogZGZsOiBwY2k6IEFkZCBnZW5lcmljIE9GUyBQQ0kgUElEDQo+ID4+Pj4+Pj4NCj4g
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+IE9uIDIvMTQvMjIgMzoyNiBBTSwgVGlhbmZlaSB6aGFuZyB3cm90
ZToNCj4gPj4+Pj4+Pj4gRnJvbTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGlu
dXguaW50ZWwuY29tPg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBBZGQgdGhlIFBDSSBwcm9kdWN0
IGlkIGZvciBhbiBPcGVuIEZQR0EgU3RhY2sgUENJIGNhcmQuDQo+ID4+Pj4+Pj4gSXMgdGhlcmUg
YSBVUkwgdG8gdGhlIGNhcmQgPw0KPiA+Pj4+Pj4gVGhpcyBQQ0llIERldmljZSBJRHMgaGF2ZSBy
ZWdpc3RlcmVkIGJ5IEludGVsLg0KPiA+Pj4+PiBBIFVSTCBpcyB1c2VmdWwgdG8gaW50cm9kdWNl
IHRoZSBib2FyZCwgSXMgdGhlcmUgb25lID8NCj4gPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTWF0
dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+Pj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBUaWFuZmVpIFpoYW5nIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT4N
Cj4gPj4+Pj4+Pj4gLS0tDQo+ID4+Pj4+Pj4+ICDCoMKgIGRyaXZlcnMvZnBnYS9kZmwtcGNpLmMg
fCA0ICsrKysNCj4gPj4+Pj4+Pj4gIMKgwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQ0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1w
Y2kuYyBiL2RyaXZlcnMvZnBnYS9kZmwtcGNpLmMgaW5kZXgNCj4gPj4+Pj4+Pj4gODNiNjA0ZDZk
YmU2Li5jYjJmYmYzZWI5MTggMTAwNjQ0DQo+ID4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZnBnYS9k
ZmwtcGNpLmMNCj4gPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC1wY2kuYw0KPiA+Pj4+
Pj4+PiBAQCAtNzYsMTIgKzc2LDE0IEBAIHN0YXRpYyB2b2lkIGNjaV9wY2lfZnJlZV9pcnEoc3Ry
dWN0IHBjaV9kZXYNCj4gPj4+Pj4+Pj4gKnBjaWRldikNCj4gPj4+Pj4+Pj4gIMKgwqAgI2RlZmlu
ZSBQQ0lFX0RFVklDRV9JRF9JTlRFTF9QQUNfRDUwMDXCoMKgwqDCoMKgwqDCoCAweDBCMkINCj4g
Pj4+Pj4+Pj4gIMKgwqAgI2RlZmluZSBQQ0lFX0RFVklDRV9JRF9TSUxJQ09NX1BBQ19ONTAxMMKg
wqDCoCAweDEwMDANCj4gPj4+Pj4+Pj4gIMKgwqAgI2RlZmluZSBQQ0lFX0RFVklDRV9JRF9TSUxJ
Q09NX1BBQ19ONTAxMcKgwqDCoCAweDEwMDENCj4gPj4+Pj4+Pj4gKyNkZWZpbmUgUENJRV9ERVZJ
Q0VfSURfSU5URUxfT0ZTwqDCoMKgwqDCoMKgwqAgMHhiY2NlDQo+ID4+Pj4+Pj4gSU5URUxfT0ZT
IGlzIGEgZ2VuZXJpYyBuYW1lLCBwY2kgaWQncyBtYXAgdG8gc3BlY2lmaWMgY2FyZHMNCj4gPj4+
Pj4+Pg0KPiA+Pj4+Pj4+IElzIHRoZXJlIGEgbW9yZSBzcGVjaWZpYyBuYW1lIGZvciB0aGlzIGNh
cmQgPw0KPiA+Pj4+Pj4gSSB0aGluayB1c2luZyBJTlRFTF9PRlMgaXMgYmV0dGVyLCBiZWNhdXNl
IElOVEVMX09GUyBpcyB0aGUgR2VuZXJpYw0KPiA+Pj4+Pj4gZGV2ZWxvcG1lbnQgcGxhdGZvcm0g
Y2FuIHN1cHBvcnQgbXVsdGlwbGUgY2FyZHMgd2hpY2ggdXNpbmcgT0ZTDQo+ID4+Pj4+PiBzcGVj
aWZpY2F0aW9uLCBsaWtlIEludGVsIFBBQyBONjAwMCBjYXJkLg0KPiA+Pj4+PiBJIHdvdWxkIHBy
ZWZlciBzb21ldGhpbmcgbGlrZSBQQ0lFX0RFVklDRV9JRF9JTlRFTF9QQUNfTjYwMDANCj4gYmVj
YXVzZQ0KPiA+Pj4+PiBpdCBmb2xsb3dzIGFuIGV4aXN0aW5nIHBhdHRlcm4uwqAgTWFrZSBpdCBl
YXN5IG9uIGEgZGV2ZWxvcGVyLCB0aGV5DQo+ID4+Pj4+IHdpbGwgbG9vayBhdCB0aGVpciBib2Fy
ZCBvciBib3gsIHNlZSBYIGFuZCB0cnkgdG8gZmluZCBzb21ldGhpbmcNCj4gPj4+Pj4gc2ltaWxh
ciBpbiB0aGUgZHJpdmVyIHNvdXJjZS4NCj4gPj4+Pj4NCj4gPj4+Pj4gVG8gdXNlIE9TRl8gKiB0
aGUgbmFtZSBuZWVkcyBhIHN1ZmZpeCB0byBkaWZmZXJlbnRpYXRlIGl0IGZyb20gZnV0dXJlDQo+
ID4+Pj4+IGNhcmRzIHRoYXQgd2lsbCBhbHNvIHVzZSBvZnMuDQo+ID4+Pj4+DQo+ID4+Pj4+IElm
IHRoaXMgcmVhbGx5IGlzIGEgZ2VuZXJpYyBpZCBwbGVhc2UgZXhwbGFpbiBpbiB0aGUgZG9jIHBh
dGNoIGhvdw0KPiA+Pj4+PiBldmVyeSBmdXR1cmUgYm9hcmQgd2l0aCB1c2UgdGhpcyBzaW5nbGUg
aWQgYW5kIGhvdyBhIGRyaXZlciBjb3VsZA0KPiA+Pj4+PiB3b3JrIGFyb3VuZCBhIGh3IHByb2Js
ZW0gaW4gYSBzcGVjaWZpYyBib2FyZCB3aXRoIGEgcGNpIGlkIGNvdmVyaW5nDQo+ID4+Pj4+IG11
bHRpcGxlIGJvYXJkcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gVG9tDQo+ID4+Pj4gSGkgVG9tLA0KPiA+
Pj4+DQo+ID4+Pj4gVGhlIGludGVudCBpcyB0byBoYXZlIGEgZ2VuZXJpYyBkZXZpY2UgaWQgdGhh
dCBjYW4gYmUgdXNlZCB3aXRoIG1hbnkNCj4gPj4+PiBkaWZmZXJlbnQgYm9hcmRzLsKgIEN1cnJl
bnRseSwgd2UgaGF2ZSBGUEdBIGltcGxlbWVudGF0aW9ucyBmb3IgMw0KPiA+Pj4+IGRpZmZlcmVu
dCBib2FyZHMgdXNpbmcgdGhpcyBnZW5lcmljIGlkLsKgIFdlIG1heSBuZWVkIGEgYmV0dGVyIG5h
bWUgZm9yDQo+ID4+Pj4gZGV2aWNlIGlkIHRoYW4gT0ZTLsKgIE1vcmUgcHJlY2lzZWx5IHRoaXMg
Z2VuZXJpYyBkZXZpY2UgaWQgbWVhbnMgYSBQQ0kNCj4gPj4+PiBmdW5jdGlvbiB0aGF0IGlzIGRl
c2NyaWJlZCBieSBhIERldmljZSBGZWF0dXJlIExpc3QgKERGTCkuwqAgSG93IGFib3V0DQo+ID4+
Pj4gUENJRV9ERVZJQ0VfSURfSU5URUxfREZMPw0KPiA+Pj4+DQo+ID4+Pj4gV2l0aCBhIERGTCBk
ZXZpY2UgaWQsIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHRoZSBQRi9WRiBpcyBkZXRlcm1pbmVkIGJ5
DQo+ID4+Pj4gdGhlIGNvbnRlbnRzIG9mIHRoZSBERkwuwqAgRWFjaCBEZXZpY2UgRmVhdHVyZSBI
ZWFkZXIgKERGSCkgaW4gdGhlIERGTA0KPiA+Pj4+IGhhcyBhIHJldmlzaW9uIGZpZWxkIHRoYXQg
Y2FuIGJlIHVzZWQgaWRlbnRpZnkgImJyb2tlbiIgaHcsIG9yIG5ldw0KPiA+Pj4+IGZ1bmN0aW9u
YWxpdHkgYWRkZWQgdG8gYSBmZWF0dXJlLsKgIEFkZGl0aW9uYWxseSwgc2luY2UgdGhlIERGTCBp
cw0KPiA+Pj4+IHR5cGljYWxseSB1c2VkIGluIGEgRlBHQSwgdGhlIGJyb2tlbiBoYXJkd2FyZSwg
Y2FuIGFuZCBzaG91bGQgYmUgZml4ZWQNCj4gPj4+PiBpbiBtb3N0IGNhc2VzLg0KPiA+Pj4gSG93
IGlzIGxzcGNpIHN1cHBvc2VkIHRvIHdvcmsgPw0KPiA+PiBUaGVyZSBpcyBhbiBleGFtcGxlIGZv
ciBvbmUgY2FyZCB1c2luZyBJT0ZTIGFuZCBERkwuDQo+ID4+DQo+ID4+ICMgbHNwY2kgfCBncmVw
IGFjYw0KPiA+PiBiMTowMC4wIFByb2Nlc3NpbmcgYWNjZWxlcmF0b3JzOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBEZXZpY2UgYmNjZSAocmV2IDAxKQ0KPiA+PiBiMTowMC4xIFByb2Nlc3NpbmcgYWNjZWxl
cmF0b3JzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgYmNjZQ0KPiA+PiBiMTowMC4yIFByb2Nl
c3NpbmcgYWNjZWxlcmF0b3JzOiBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgYmNjZQ0KPiA+PiBi
MTowMC4zIFByb2Nlc3NpbmcgYWNjZWxlcmF0b3JzOiBSZWQgSGF0LCBJbmMuIFZpcnRpbyBuZXR3
b3JrIGRldmljZQ0KPiA+PiBiMTowMC40IFByb2Nlc3NpbmcgYWNjZWxlcmF0b3JzOiBJbnRlbCBD
b3Jwb3JhdGlvbiBEZXZpY2UgYmNjZQ0KPiA+Pg0KPiA+PiBOb3RlOiBUaGVyZSA1IFBGcyBpbiB0
aGlzIGNhcmQsIGl0IGV4cG9ydHMgdGhlIG1hbmFnZW1lbnQgZnVuY3Rpb25zIHZpYQ0KPiA+PiBQ
RjAoYjE6MDAuMCksDQo+ID4+IE90aGVyIFBGcyBsaWtlIGIxOjAwLjEsIGIxOjAwLjIsIGIxOjAw
LjQsIGFyZSB1c2luZyBmb3IgdGVzdGluZywgd2hpY2gNCj4gPj4gZGVwZW5kcyBvbiBSVEwgZGVz
aWduZXINCj4gPj4gb3IgcHJvamVjdCByZXF1aXJlbWVudC4gVGhlIFBGMyBpbnN0YW5jZSBhIFZp
cnRJTyBuZXQgZGV2aWNlIGZvciBleGFtcGxlLA0KPiA+PiB3aWxsIGJpbmQgd2l0aCB2aXJ0aW8t
bmV0IGRyaXZlcg0KPiA+PiBwcmVzZW50aW5nIGl0c2VsZiBhcyBhIG5ldHdvcmsgaW50ZXJmYWNl
IHRvIHRoZSBPUy4NCj4gDQo+IEhpIFRvbSwNCj4gDQo+IFRoZXNlIGFyZSB2ZXJ5IGdvb2QgcXVl
c3Rpb25zLCBhbmQgdGhlIGFuc3dlcnMgd2lsbCBiZSBhZGRyZXNzZWQgaW4gdGhlDQo+IGRvY3Vt
ZW50YXRpb24gYXNzb2NpYXRlZCB3aXRoIGEgdjIgc3VibWlzc2lvbiBvZiB0aGlzIHBhdGNoLg0K
PiANCj4gPg0KPiA+IFdoYXQgSSBtZWFuIHRoZXJlIGlzIGhldGVyb2dlbmVvdXMgc2V0IG9mIGNh
cmRzIGluIG9uZSBtYWNoaW5lLCBob3cgZG8geW91DQo+ID4gdGVsbCB3aGljaCBjYXJkIGlzIHdo
aWNoID8NCj4gDQo+IElmIHRoZSBQQ0kgUElEL1ZJRCBpcyBnZW5lcmljLCBpbmRpY2F0aW5nIG9u
bHkgdGhhdCB0aGVyZSBpcyBvbmUgb3IgbW9yZQ0KPiBERkwsIHRoZW4gc29tZSBvdGhlciBtZWNo
YW5pc20gbXVzdCBiZSB1c2VkIHRvIGRpZmZlcmVudGlhdGUgdGhlIGNhcmRzLg0KPiBPbmUgY291
bGQgdXNlIHVuaXF1ZSBQQ0kgc3ViLVBJRC9zdWItVklEcyB0byBkaWZmZXJlbnRpYXRlIHNwZWNp
ZmljDQo+IGltcGxlbWVudGF0aW9ucy4gIE9uZSBjb3VsZCBhbHNvIHVzZSBzb21lIHJlZ2lzdGVy
IGluIEJBUiBzcGFjZSB0byBoZWxwDQo+IGlkZW50aWZ5IHRoZSBjYXJkLCBvciBvbmUgY291bGQg
dXNlIFBDSSBWaXRhbCBQcm9kdWN0IERhdGEgKFZQRCkgdG8NCj4gcHJvdmlkZSBkZXRhaWxlZCBp
bmZvcm1hdGlvbiBhYm91dCB0aGUgcnVubmluZyBGUEdBIGRlc2lnbiBvbiB0aGUgY2FyZC4NCg0K
SWRlYWxseSBERkwgaGFzIGRpZmZlcmVudCBzY29wZSB0aGFuIFBDSS4gREZMIGlzIGEgaGlnaGVy
IGxheWVyIGNvbmNlcHQgdGhhbg0KUENJLCBhcyBERkwgY2FuIGJlIGFwcGxpZWQgdG8gUENJIGRl
dmljZSwgcGxhdGZvcm0gZGV2aWNlIG9yIGV2ZW4gb3RoZXIgZGV2aWNlcy4NCklmIHNvbWUgUENJ
IGxldmVsIHF1aXJrcyBuZWVkIHRvIGJlIGFwcGxpZWQgYmVmb3JlIGFjY2Vzc2luZyBCQVIgZm9y
IG9uZSBjYXJkLA0KdGhlbiBERkwgbWF5IG5vdCBiZSBhYmxlIHRvIGhlbHAgYXQgYWxsLiBVc2Ug
UENJIGxldmVsIHNvbHV0aW9uIHNob3VsZCBiZSBiZXR0ZXIsDQphbmQgZGlmZmVyZW50IFZJRC9E
SUQgbWF5IGJlIHRoZSBlYXNpZXN0IHNvbHV0aW9uLg0KDQpIYW8NCg0KPiANCj4gPg0KPiA+IE9y
IGluIGEgZGF0YWNlbnRlciB3aGVyZSB0aGUgbWFjaGluZXMgYXJlIGFsbCByZW1vdGUgYW5kIGFk
bWluIGhhcyB0byBmbGFzaA0KPiA+IGp1c3QgdGhlIG42MDAwJ3MgPw0KPiANCj4gVGhpcyBwcm9i
bGVtIGV4aXN0cyB3aXRoIHRoZSBOMzAwMCBjYXJkcy4gIERlcGVuZGluZyBvbiB0aGUgRlBHQQ0K
PiBjb25maWd1cmF0aW9uLCB0aGUgbGluZSBzaWRlIG9mIHRoZSBjYXJkIGNvdWxkIGJlIHZlcnkg
ZGlmZmVyZW50IChlLmcuDQo+IDR4MTBHYiBvciAyeDJ4MjVHYikuICBUaGUgbmV0d29yayBvcGVy
YXRvciBtdXN0IG1ha2Ugc3VyZSB0byB1cGRhdGUgYQ0KPiBwYXJ0aWN1bGFyIE4zMDAwIGNhcmQg
d2l0aCB0aGUgY29ycmVjdCBGUEdBIGltYWdlIHR5cGUuICBJbiB0aGUgY2FzZSBvZg0KPiB0aGUg
TjMwMDAgdGhlcmUgaXMgYSByZWdpc3RlciBleHBvc2VkIHRocm91Z2ggc3lzZnMgY29udGFpbmlu
ZyB0aGUNCj4gIkJpdHN0cmVhbSBJRCIgd2hpY2ggY29udGFpbnMgdGhlIGxpbmUgc2lkZSBjb25m
aWd1cmF0aW9uIG9mIHRoZSBGUEdBLg0KPiANCj4gPg0KPiA+IEhvdyBjb3VsZCBzaGUgZmluZCBq
dXN0IHRoZSBuNjAwMCdzIHdpdGggbHNwY2kgPw0KPiANCj4gSWYgeW91IG9ubHkgd2FudGVkIHRv
IHVzZSBsc3BjaSB0byBkZXRlcm1pbmUgdGhlIGNhcmQsIHRoZW4NCj4gZGlmZmVyZW50aWF0aW5n
IFBDSSBzdWItVklEL3N1Yi1QSUQgY291bGQgYmUgdXNlZCBvciBWUEQgY291bGQgYmUgdXNlZC4N
Cj4gDQo+ID4NCj4gPiBIb3cgd291bGQgdGhlIGRyaXZlciBrbm93ID8NCj4gDQo+IFRoZSBkZmwt
cGNpIGRyaXZlciBpcyBmYWlybHkgZ2VuZXJpYyBpbiB0aGF0IGl0IGRvZXNuJ3QgcmVhbGx5IGNh
cmUgYWJvdXQNCj4gdGhlIFBDSSBQSUQvVklEIGJlY2F1c2UgYWxsIGl0IHJlYWxseSBkb2VzIGVu
dW1lcmF0ZSB0aGUgREZMcy4gIEl0IGlzIHRoZQ0KPiBpbmRpdmlkdWFsIGRmbCBkcml2ZXJzIHRo
YXQgbWF5IG5lZWQgdG8ga25vdyBodyBkaWZmZXJlbmNlcy9idWdzIGZvciB0aGF0DQo+IGNvbXBv
bmVudCBJUC4NCj4gDQo+ID4NCj4gPiBUb20NCj4gPg0KPiA+Pg0KPiA+Pj4gQSBkZmwgc2V0IGNh
biBjaGFuZ2Ugd2l0aCBmdyB1cGRhdGVzIGFuZCBpbiB0aGVvcnkgZGlmZmVyZW50IGJvYXJkcyBj
b3VsZA0KPiA+Pj4gaGF2ZQ0KPiA+Pj4gdGhlIHNhbWUgc2V0Lg0KPiA+Pj4NCj4gPj4+IFRvbQ0K
PiA+Pj4NCj4gPj4+PiBNYXR0aGV3DQo+ID4+Pj4+Pj4gVG9tDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4gIMKgwqAgLyogVkYgRGV2aWNlICovDQo+ID4+Pj4+Pj4+ICDCoMKgICNkZWZpbmUgUENJRV9E
RVZJQ0VfSURfVkZfSU5UXzVfWMKgwqDCoMKgwqDCoMKgIDB4QkNCRg0KPiA+Pj4+Pj4+PiAgwqDC
oCAjZGVmaW5lIFBDSUVfREVWSUNFX0lEX1ZGX0lOVF82X1jCoMKgwqDCoMKgwqDCoCAweEJDQzEN
Cj4gPj4+Pj4+Pj4gIMKgwqAgI2RlZmluZSBQQ0lFX0RFVklDRV9JRF9WRl9EU0NfMV9YwqDCoMKg
wqDCoMKgwqAgMHgwOUM1DQo+ID4+Pj4+Pj4+ICDCoMKgICNkZWZpbmUgUENJRV9ERVZJQ0VfSURf
SU5URUxfUEFDX0Q1MDA1X1ZGwqDCoMKgIDB4MEIyQw0KPiA+Pj4+Pj4+PiArI2RlZmluZSBQQ0lF
X0RFVklDRV9JRF9JTlRFTF9PRlNfVkbCoMKgwqDCoMKgwqDCoCAweGJjY2YNCj4gPj4+Pj4+Pj4N
Cj4gPj4+Pj4+Pj4gIMKgwqAgc3RhdGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGNjaV9wY2llX2lk
X3RibFtdID0gew0KPiA+Pj4+Pj4+PiAgwqDCoMKgwqDCoMKgIHtQQ0lfREVWSUNFKFBDSV9WRU5E
T1JfSURfSU5URUwsDQo+ID4+Pj4+Pj4+IFBDSUVfREVWSUNFX0lEX1BGX0lOVF81X1gpLH0sDQo+
ID4+Pj4+Pj4gQEANCj4gPj4+Pj4+Pj4gLTk1LDYgKzk3LDggQEAgc3RhdGljIHN0cnVjdCBwY2lf
ZGV2aWNlX2lkIGNjaV9wY2llX2lkX3RibFtdID0gew0KPiA+Pj4+Pj4+PiAgwqDCoMKgwqDCoMKg
IHtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsDQo+ID4+Pj4+Pj4gUENJRV9ERVZJQ0Vf
SURfSU5URUxfUEFDX0Q1MDA1X1ZGKSx9LA0KPiA+Pj4+Pj4+PiB7UENJX0RFVklDRShQQ0lfVkVO
RE9SX0lEX1NJTElDT01fREVOTUFSSywNCj4gPj4+Pj4+PiBQQ0lFX0RFVklDRV9JRF9TSUxJQ09N
X1BBQ19ONTAxMCksfSwNCj4gPj4+Pj4+Pj4ge1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9TSUxJ
Q09NX0RFTk1BUkssDQo+ID4+Pj4+Pj4+IFBDSUVfREVWSUNFX0lEX1NJTElDT01fUEFDX041MDEx
KSx9LA0KPiA+Pj4+Pj4+PiArwqDCoMKgIHtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUws
DQo+IFBDSUVfREVWSUNFX0lEX0lOVEVMX09GUyksfSwNCj4gPj4+Pj4+Pj4gK8KgwqDCoCB7UENJ
X0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLA0KPiA+Pj4+Pj4+IFBDSUVfREVWSUNFX0lEX0lO
VEVMX09GU19WRiksfSwNCj4gPj4+Pj4+Pj4gIMKgwqDCoMKgwqDCoCB7MCx9DQo+ID4+Pj4+Pj4+
ICDCoMKgIH07DQo+ID4+Pj4+Pj4+ICDCoMKgIE1PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBjY2lf
cGNpZV9pZF90YmwpOw0KPiA+Pj4+Pg0KPiA+DQo+ID4NCg==
