Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14BA4D5B7B
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Mar 2022 07:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiCKGQI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Mar 2022 01:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiCKGQH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Mar 2022 01:16:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71218A791
        for <linux-fpga@vger.kernel.org>; Thu, 10 Mar 2022 22:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646979302; x=1678515302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KtPiNV1+O5Op1QYXHQYLndoRXMUqaRzDZ75FCY8q7CA=;
  b=Alx49uvtAnbGa+y/wjFwXV2dXRl4oxPaXPUpUErgR9k5a8GSpmEHMVTt
   NUpjvyb2KwkT+nhEzuPlpo7O9Kj6f8B8snKOyCiXDRN/s5LWEvwVbIBfg
   2ntzp2zDOI98yrDMr6dEc9nZC1qEXsmK/dwKsoSoHGhVpAC+LgnhwjTQm
   Ez+RHc9gbeeie7DKHQ5MqnT79ATGkilsNEbzDdJx+S/4fk2pJkdaJLjOV
   /IYSvo4lf9Qlvb5Slbv+bE+PZ4P3Ha5HZp/cWqc4cQUQn7vpnuFq+gpkz
   +kRJwvRA3AqMk5ODhyun7KzyZNdMql7cwZH7AyXwH7aM0T4TxS1yUGeUa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255458684"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="255458684"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 22:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="644832635"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2022 22:15:02 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 22:15:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 22:15:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 22:15:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcRxS+bcnwzr7f9aJwzb7WYB5Qp+wTd8Mm1v6QJ3dtzoP3v4poiMfewiyT2vEww/bgjleuBcv11Ai3XDpJGY5vQMfZyhi4kwzR1uYkWKT/CCLrU06p3YLW01HyUL8T/LBtgyb0UCGk0lEuJlVRO8IVVJmik0HqZNV4vDb79Gn7P7+PhHcbdxLR6B+EQG3XWK2Jn9B62rdBTDd96qJoStTnnETMNc92HmpRlLTqnDT5+tORU3hJyvS2uBsFdQbpfKS+wTbOxTQSTRVob7rQFrA1ZV/or0j20q1fK1IdQHkG4ncWhMSXQwe4xp6ovo0Ykh20eaHrIDSYD0KKowEAejgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtPiNV1+O5Op1QYXHQYLndoRXMUqaRzDZ75FCY8q7CA=;
 b=G+YaVUj0MbP8BdTzqrfslLOIDtetJwFAzJTSWEL9OQ712bfYPc4oyQ4FrUYiXvRZigUC3ajCTII1pveeiahyrh/DeOV8gKMub1+5OnI9FygnZfhfMZdYmRQdRnOH7lEwu78+GQhGuzddYYgIJx+KQFnPqwhv63l5R7N+YseWpS+gkT0XqS1hfBqO2oVcqKvykDv2r+6LvLWacLYcleK20CLntPkXAKAHRjtOfVi0DooCG31Z6xfZue/2WYkFtJzoD3zvrdtIsm1+uXBiGmnFeL8Epkc/odgSYr5k1JcbBSDOduJo+bNXs8YrRvNI2NTBi7K3c3ZqXjgAfF3r9RYPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN8PR11MB3635.namprd11.prod.outlook.com (2603:10b6:408:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 06:14:52 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 06:14:52 +0000
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
Thread-Index: AQHYMrhKml+FZWGpG0uUYk5qH7zFV6y5BeCAgAB5IgCAADjzYA==
Date:   Fri, 11 Mar 2022 06:14:52 +0000
Message-ID: <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 759cce9a-cbd0-494a-fc86-08da03267477
x-ms-traffictypediagnostic: BN8PR11MB3635:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB36356468BFE4F4D605425351E30C9@BN8PR11MB3635.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plr+YJ6VI+fDUtcq0QGJNnJVB9h5oRIsO4jeiQIGSvVv5Lw8xXV8R8hEkcHgAO0dOuOC41mO5FDDTN+i/ZmFYA555M2pX2dFTdkt62QG3zRudc68k4/QrvR2gWduMv2LTKv8ktoOUj07VMR1kpgf96ZQ2BepSvnrMnoDctrDEB6hoLoSFnrBuHGRZmZkch9L4sGCaYM/Vgd02povNt6xoFK5ws6pa63vHFgMoelTBs5sOzCF6Tj5Yfj1wUC491I/ugeJI7u4A9ctOzeHpbuwF/ZnsbWBkeFO6fqd02dH7W159d7gEj7dcKl1nS4a7/8jtBN5h7EzjrvieURFMCmjamrCBXCv9/mZ+x83V6NKPFY5zfihCFkZaj7RSvAcAsSZwUL4BfWWg0BM5ELCLrxznqnOqKkiVkdR+hvGj/Bmbk6IIvhKw8TVQaN0AF3h5w9GsrHF/wGlTML6tnBziBZHNBzCUaVsOzXhjvo0pmTSXZFc5SyQTb2CZ+sB/MP/DNthZRl2cye/VUjdD2Enw6TWuahoXS54d2uWNWU0D4r6cFviJZLZbu3bxBXzHEpXG4DjHKFt64G4x7OQ+LSWRwsHaRlMJZebOt1VswUcZfFJDQX9z2yFCMaITntz2f3cs8iZUkWfmyHQjb7j4ABA+1izKQTmfL3UsBVx3+Uy5IIVGBhW2UB5ydLXzhpqdCBGtV33GeotIORoptp7c8DOc8P1NdPxA8o1Q7U59Aj6aFuLEIaS0+w5o2f/zEtecOyIYCpWr6UWWPdtn3annVSYrf/2LiJ9phhG8Py5bYhWHzaTeZ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38070700005)(82960400001)(966005)(33656002)(4326008)(9686003)(186003)(508600001)(122000001)(54906003)(8676002)(110136005)(38100700002)(66946007)(76116006)(66446008)(66556008)(64756008)(66476007)(53546011)(8936002)(86362001)(5660300002)(7696005)(6506007)(71200400001)(2906002)(83380400001)(55016003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3VTTlk3dUlUUmZabkRoT2NLY25oMVNyVzRTYWpmZHBpOWhpRmJKL3ZuSHMy?=
 =?utf-8?B?ejM2MEVMMEhpb3djanZtY1BGaWdwRFRSVVRxODVWeWlBdXpTVHExd21CRllT?=
 =?utf-8?B?Z09PWHByakhEYktySWtSaWpzMlFoYmVheVJ1cE5TZDhRay95RytrRXhWMlh1?=
 =?utf-8?B?RzdHY1VBOGpjaTdVR2ZEYTVhNXd2UnBnUWVnUExnSFVZRHMyNERYRWkvWGtw?=
 =?utf-8?B?OHFycDdvdldEVXZ0VTZLdUVDZEhpRStxalBOd0ZSdVRWN1I2aUpUNUlzejcx?=
 =?utf-8?B?aEtUaE9Ua1IrUjUrc3JMNmFreXZtV2NkbXFyV3BCdkhjVVJ4ekxIWlFXMFBw?=
 =?utf-8?B?a0c0Nk43Szg0dVFYK3FFYlI1b2NvazZnOFI1RjZ4QVRQSW12azVOQVhtNTZv?=
 =?utf-8?B?aG96QnEwZDJEZG1Zc0NSTE01YjBWNTZOd0dFSC9YbFFYVFJ5YkpzQVV2UlVW?=
 =?utf-8?B?RTBKQ25UVE0zOGRvQ3VmZ0dXUmNCaTJ3aVpCV3RNRVFxRGxzTXI2MEZqQ0Vn?=
 =?utf-8?B?TllZVWFLalU4Y05CSXV4NlcvQ25iTDMza2hETHBwL21tTVZyb2YzY256ZDZ6?=
 =?utf-8?B?RE1XdTVONU9CMDlzT0k0Y1pHaTdBam8wTXYxNFJMVDhoV2g2WmlWcWVxOEFI?=
 =?utf-8?B?VjFZVTZVMTlrKzMrWVRwUjZZV0Z1UXZzTDdodm43Q0NURzJ2Nzc0UElHWnVE?=
 =?utf-8?B?cVpSMGcxRzlwS0JzR2l0aGlGK1c4aFJZaWV6MGpHK2VnbmVVOWZBbjdFalVv?=
 =?utf-8?B?S2pZbHgxUDhrRi9LRHFXb1l1bGxxaXk2QXRjL3RoOG5xSi9VT2ZxMkdyK2Qw?=
 =?utf-8?B?RHppdkUrTWtZQ0RqQlJLYW9JUk9KcVpEL2NPbnhzeFVWdzl4VHh5a3p5SVVX?=
 =?utf-8?B?QTgzNTdySVY4R1ZqY3ZOTnd0VzB0K2lmWEdscElZcXYyUGZSY2xWbE9zMm5U?=
 =?utf-8?B?MXVEaEVnQ1BPSWJDbXRGTFZNQUtwb1FQcVoxS05hUDBNT044QkRqaUE4dlps?=
 =?utf-8?B?L1FHQ2x3RFFURHhXQTJKSmJGQ3gvWDhQeFZ4R3Bwd3RyL3dVS3VTeXlhTWdn?=
 =?utf-8?B?ZGxHUTUrR3RlQ2c4bWFGaXNKOTZCdG1NTUxHL2dVdFdxV2xpMmVibis0Tkg0?=
 =?utf-8?B?UWtZYms3NkVOQ1psY3ViZUpGWDhXSUtYT2dKR0w3RWQwcnpINGtTd294eXJG?=
 =?utf-8?B?RWlPMnVMS2pua0szaGZqTmFtRkI0OFNwWDFPWGp5dG8xUkdJNkN5MkhzbG9Z?=
 =?utf-8?B?Q0xKc0haNDAxbjc0U2puMENHMUNvaHZ0Q1QwRi9EWm1WSzNSamI2V2hUTkNq?=
 =?utf-8?B?cnk0cGgxRHNzbWRGK0VYdUpzVUxqQmkyUDY1ZFVKV2R6K1c0RmNqYVFNTXdI?=
 =?utf-8?B?RktRUWFReEVzTyt6RDBvQW1id1ByenpCdm9zc0RKVlQxT01ic3dCSTIyMit2?=
 =?utf-8?B?M3lZVHpsRFc1ZkRLTnU0SFBxaVpySDRCN21QM3FnZm5aVlRTd3YyOGc3RjZB?=
 =?utf-8?B?TDVseWhUT1N0VzhGNnhUcVNFVUdzR09jSUlMWkJlNzZvNm9TVFRmN1h6R1ps?=
 =?utf-8?B?MmgyNVB2U0k3OUZINGNINldzNXBVSmE5RjcvdVoyOG5FSExMc1RmaFRNWW90?=
 =?utf-8?B?TG8rZHIrT0Q4MGhYMkRVTnJNWE1JSjdOK1ZFc1BvSjV6T0lzNVlRcXB3WFV2?=
 =?utf-8?B?RGhvNnZ4QVNXeU5HVlE2emxQUXQvbmJKaXZjby96NU5yN2dFSW5oYkhKUGdy?=
 =?utf-8?B?QzdMMC9XMnRrc2lZTldxeEVCYW4yUDNvTFBsWXBlVThyWTZiRmU4Zy8wQlpy?=
 =?utf-8?B?aEl1K0U3eGxrbjluOGlvblZnTjNJTnJ1RjVER0FaMmZmT21IYUJQejZZL2hK?=
 =?utf-8?B?aXQ3M0FEUTRsZXlwc1pQcEZ5RnE0d0NCd3I2YmQxT1JpaVBRb2k0MFVtVVJF?=
 =?utf-8?B?a2o3M0I0bCtMQVFoWjUxVGZOa01TT21DVk11WC9kWEJ3YnlycUN3R2kzYk9m?=
 =?utf-8?B?MUhSSm9YNmxOaUdpdnhZVmRYTjRxaUtUNm8wQ3B3cWZvK1Z2WElOSStuNmVP?=
 =?utf-8?Q?XRz1BE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759cce9a-cbd0-494a-fc86-08da03267477
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 06:14:52.3070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAVEmAmn2khbB/7KEPiAjy0Z3rWLhbOgLKurnQS4c04kSewdGPa5DogSORF6F5ktdQ0Sd+p2ZsEriskkUlWrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3635
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxMSwgMjAyMiAxMDo0NyBBTQ0KPiBU
bzogV2VpZ2h0LCBSdXNzZWxsIEggPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsgWmhhbmcs
IFRpYW5mZWkNCj4gPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgdHJpeEByZWRoYXQuY29tOyBt
ZGZAa2VybmVsLm9yZzsgbGludXgtDQo+IGZwZ2FAdmdlci5rZXJuZWwub3JnOyBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZw0KPiBDYzogWHUsIFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+OyBN
YXR0aGV3IEdlcmxhY2gNCj4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjFdIHVpbzogZGZsOiBhZGQgSFNTSSBmZWF0dXJlIGlkDQo+IA0K
PiA+IE9uIDMvNy8yMiAyMjo0MywgVGlhbmZlaSBaaGFuZyB3cm90ZToNCj4gPiA+IEZyb206IE1h
dHRoZXcgR2VybGFjaCA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+DQo+
ID4gPiBBZGQgdGhlIGZlYXR1cmUgaWQgb2YgdGhlIE9GUyBIaWdoIFNwZWVkIFNlcmlhbCBJbnRl
cmZhY2Ugc3Vic3lzdGVtDQo+ID4gPiB0byB0YWJsZSBvZiBpZHMgc3VwcG9ydGVkIGJ5IHRoZSB1
aW9fZGZsIGRyaXZlci4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEdlcmxh
Y2ggPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBUaWFuZmVpIFpoYW5nIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFJldmll
d2VkLWJ5OiBSdXNzIFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL3Vpby91aW9fZGZsLmMgfCAyICsrDQo+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Vpby91aW9fZGZsLmMgYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMgaW5kZXgNCj4gPiA+IDg5YzBm
YzdiMGNiYy4uNjYwZTFkMGJmNmI5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy91aW8vdWlv
X2RmbC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMNCj4gPiA+IEBAIC00NSw5
ICs0NSwxMSBAQCBzdGF0aWMgaW50IHVpb19kZmxfcHJvYmUoc3RydWN0IGRmbF9kZXZpY2UgKmRk
ZXYpDQo+ID4gPiB9DQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgRk1FX0ZFQVRVUkVfSURfRVRIX0dS
T1VQCTB4MTANCj4gPiA+ICsjZGVmaW5lIEZNRV9GRUFUVVJFX0lEX09GU19IU1NJCQkweDE1DQo+
IA0KPiBXaGVyZSBpcyB0aGUgIk9GUyIgY29taW5nIGZyb20/IGlzIGl0IGZvciBhbGwgT0ZTIGRl
dmljZSBvciBhIHNwZWNpZmljIGNhcmQ/DQo+IEFueXdheSwgY291bGQgd2UgaGF2ZSBhIG1hdGNo
ZWQgbmFtZSBwZXIgcHVibGljIHRhYmxlPw0KPiBodHRwczovL2dpdGh1Yi5jb20vT1BBRS9saW51
eC1kZmwtZmVhdHVyZS1pZC9ibG9iL21hc3Rlci9kZmwtZmVhdHVyZS1pZHMucnN0DQoNClllcywg
SSB0aGluayBhIG1hdGNoZWQgbmFtZSBvZiBwdWJsaWMgdGFibGUgd2lsbCBiZSBiZXR0ZXIuIEhv
dyBhYm91dCB0aGUgIiBGTUVfRkVBVFVSRV9JRF9IU1NJIj8NCg0KPiANCj4gSGFvDQo+IA0KPiA+
ID4NCj4gPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRmbF9kZXZpY2VfaWQgdWlvX2RmbF9pZHNb
XSA9IHsNCj4gPiA+ICAJeyBGTUVfSUQsIEZNRV9GRUFUVVJFX0lEX0VUSF9HUk9VUCB9LA0KPiA+
ID4gKwl7IEZNRV9JRCwgRk1FX0ZFQVRVUkVfSURfT0ZTX0hTU0kgfSwNCj4gPiA+ICAJeyB9DQo+
ID4gPiAgfTsNCj4gPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKGRmbCwgdWlvX2RmbF9pZHMpOw0K
DQo=
