Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BFF4D97B6
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Mar 2022 10:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiCOJd0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Mar 2022 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbiCOJdZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Mar 2022 05:33:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371234EF4C
        for <linux-fpga@vger.kernel.org>; Tue, 15 Mar 2022 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647336729; x=1678872729;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Uij5sT+vYlCUh2fMK+lUc1qGGGTk4sE8ww0FB+wDbE=;
  b=kedYuymiltOFo1Vgjuj6hHcu30vJ1J9xNb4iWvjYneHt906pwVEgpJ+q
   KJIJs2kSse7p1bNfkCxm74EJJHPzF9sfXKbxNcTVwEFgKMGuZRgtRIk1Y
   Xq3dqtcZuum/VO4rAkX0KPRQxw48uXJbMxIgfA0hr71YMqe96sNtK0JI5
   bjCtpOU1c3VVnXMXqpsbgnX6yYj+VucNcrZgixvpGKIzzTv3+00E9OD9O
   1xDIVsTn1qF38Edcsj9IAgLHfWQ8EBfif/fw9jSrNVOWKMMYpizEnvU7/
   Jo9wkROPgN7df9HYAnKLgE8Z5bqypioAY4UthhdDA0a3nx8khHHazgssO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253816297"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="253816297"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 02:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="819668678"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 15 Mar 2022 02:32:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 02:32:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 02:32:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 02:32:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 02:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNpLGP4OcRMxVNh8TSXPuitX0Bvldg3661DJ8tNlt+vfC/7R7AveFPPyVIPfoYX/UjxJhjdQe8TzP+MaAG1B14VU12c8kLnAL2+ZdZ4ggrLODcvc8Z1VBHBrlYddw7bGGyO2A7U9DNIGgIRmaZcZN1CMi9S/n75SPQDrEa3rtYrUQPXLvFWjEUH7YuST+6/XezDNMD1grvs+4fVx/R9jkjLyA28GtQngFOKlyG5KMEORwofv+AycXbDxeoU6vqVjaXE3IspTV9fXPmSi7Ka+ASY3AyyX8FavT/zAyUJADcT23uO2ZQJASqsHhVKj4gBBSVNo/lUaKoE8zT7pK9X0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Uij5sT+vYlCUh2fMK+lUc1qGGGTk4sE8ww0FB+wDbE=;
 b=oL7inE5hMM5rXk/AhKA7Z9IqHeqyZwHTtnF+zdaFdmDPOqqqDwVmVl7zMvGvDdFLTEdOhnNpleqGIzJ1Lm5gFt3UmnZFgZV2/c5lBzSjjNV0eCrORPCXnCcIGTruGggbJqJrUOZUchu63olbCVWuDjuWJmFKENhqO2nNHy6QfVZnmkbOKOB3WXKlCqZEi6Uih7IOebr6PWIbLvwgu9/VmbN9iIn0JKDcxVjenlL2oOS5hPcFMK7BseSGR+T5zwluP3uvnUATuMHzNJmZrez8iI1toXvIMVcDcUga5NGmI7esaIycECFgIw2kdYScKQdaRk+77CjGegDAeqjaYaPVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 09:32:03 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 09:32:03 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Index: AQHYNLWszaqWHWDC/E+0/e+KE1p1U6y5ZyLggABOFgCABIET0IAAcMGAgAGJxtA=
Date:   Tue, 15 Mar 2022 09:32:02 +0000
Message-ID: <DM6PR11MB3819F9A80C12E0253ED1594B85109@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483A25DF3AEF87F83AA4A9DE30F9@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483A25DF3AEF87F83AA4A9DE30F9@BN9PR11MB5483.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ee7480d7-b1c7-4fdf-da3b-08da0666a9c9
x-ms-traffictypediagnostic: CO1PR11MB5044:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB5044640DEB1B57E1AE20974785109@CO1PR11MB5044.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T99pW+iECvLb+oyV/awU07TY5QDnr4KnhawpGmh7XuIpfg7k5rkq9n4DUBsxvJTo75SxWSmAHauFu9xjG6Ydg+j5ds1lta2hpL8xv4kjhpuGU/HgjhuGGP9rNAh99+ALam7l/YGS3Lzh+hOlC9hRciNVnhDnP/nZJQLiTXev8uuOrr/y0mp6C6onwBIMjR6nqzZx95tdJ+OjY9rrPVF5QdD+aUPwfqqNhysq8U6Mm/OcTY1VxHMzeU+WiwcBy8aH0zrh5mNMRMjnrmlG67AlAemvF+LgW6vMGjROV2BVUIDyEoafnNZzqNQPOYX5J8WedM1pcLGcktLFuDAte0HilKRRJVV5VcQzPK0w4W4Of3TmMMFO7C+yjuWA1iMNFykpgTY7rvghrNicgiT5W3ZvC3Ca8FgZfvirW9+kxw0LamNZ31c9rcVn88sEuB3SsayQziu9BNIqe+gatRtx99roNxaycycH4N0YCgR9Lp2eFmtyi9NYvdIl0Q67O+UkRMGpRjDNUiMJmfaUwMgVugagdPVrmKbnX4CfYyxLOGcma68H/vEwTvR50z4nDLlbE64oWGCjTJLqsgawXgewVrheSfAPzrTxDtdPbQ2dCFwlVY0qmVeuKxU2ZAf47W+IvlTtLvQ9eI169U2/KDSXs0Lwm6cWt09Zew1c8ffbsRrSyUIFocycssZAO9IkC0PZV7SL46UUV2L8YuxiltkoZIOT85gNCC1+ekwrRFDnw+5JNOJH9GJiYejBw/7/QpNIz9Tkxb0sj6joNvYsBuTu/RL++votuDh3WQaCcNdUitQ/v2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(54906003)(55016003)(316002)(66946007)(66556008)(66476007)(66446008)(76116006)(83380400001)(38070700005)(86362001)(508600001)(110136005)(966005)(71200400001)(7696005)(9686003)(6506007)(82960400001)(64756008)(38100700002)(122000001)(53546011)(8936002)(2906002)(52536014)(4326008)(5660300002)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cERDd2FsQWc0QzN2Qm5nKzFXTFMyYllFNmRwOGVtS3hYNUdMa3c4Tk5hY25D?=
 =?utf-8?B?OHFhVzkxNHN4R1dGdGZTOEZJcDh3dHpHOEVlZ2YvS2lZZXlINS9acDRJb2Va?=
 =?utf-8?B?MHVsR2IvUFg2Zm1INXBYTUdSNTVxaGNocWNnSlB5emFIcG1pRUZnRzJWb0Nw?=
 =?utf-8?B?bkdnRElmSTZwYzBVUW42UTR2MHRvV3hpN0kzUFRESlBGWmxFVVVWKzR2aGpY?=
 =?utf-8?B?ME9aR29NUDRzM1F4TlVNcW0wUFVLUGdIOVdDVHFTalpUajJjTXRlSWp3NW56?=
 =?utf-8?B?VzNpY1Vua3gwTzBveUNDVXd4U25BckY4ZXZmVkNlWG1zNitqK3dndGpUS0dk?=
 =?utf-8?B?RlR2OHcyOEV5RUF2enZCeEV4NjhWSFRJQ0pqKy9pQ0ZXbG1SdG1YS0NsV1JV?=
 =?utf-8?B?bHpuaHhjVXRZV2p5RXhiY1VJSWZORlFUUGZsem9seG9DSXRISDZXM1Bscm43?=
 =?utf-8?B?bmNpaDF5MWtEenhKZkNya01ZNU8wK2Zhc3Q0M3NnMDlCR1ZldmRrdXFlZ0w4?=
 =?utf-8?B?enVXNFBGSXhjQ1loenB6K3lBOUlZYWphQzdkMytySHJFOHZxK1lORlpkWFRm?=
 =?utf-8?B?ZlgxV0Z5VDhsbXJISTRLR20yeHpoSHdyL0tEM0IwWDlVVVRZTEJkRU8xOE4x?=
 =?utf-8?B?eUcwY0wzZ09CdnFHNHBjS09FWi9EMlZYQ1lvS2JBS25Ka2U0bTdML2FRc2FZ?=
 =?utf-8?B?eVZiNEltOU51ZExzc2MxanpmdXVYWFpwZzRPZ2lNb0FDR3BJSnl3cEx1WEZH?=
 =?utf-8?B?VUVHMmtkWG9GRC9wOGw4NDF3b2M2UEQ3RDIzMW5BT3BYekZxbmtKb0Q5WHNr?=
 =?utf-8?B?SldvWlg2b3o2RlF5UkNaaXg3VUtoZzNKb096MWJrNzZ2SWVnUm5nN3pBdllR?=
 =?utf-8?B?cTNNSkp4Vjg2NVBHUjAvZTBOc0ZheEY1WmlrWUdUMmNGRkEybVkwc1pjUFVQ?=
 =?utf-8?B?SmNFWUlpQ1pndmxXRS9wenVuWFdwVG1tcGdXMVIxUjkwN1NtLzZhSHltMDln?=
 =?utf-8?B?UmExdkJ1aUt0ajRxWnlyUHlQdmlKM2s1eFlnRnY4SkRPMEpaYW5tM1JTWkFn?=
 =?utf-8?B?V0tjTndjSUxQNzdHWmRCd3ZHSDN2OTVnOEdiWVZEWmxzcWxRbmMzKzhoRVZD?=
 =?utf-8?B?SkFjTXcvbnVFblE3T3RlblN2WnBIb3F5Y0V0UWFsa1J2UWJmL1YvdmQvMmlB?=
 =?utf-8?B?Wmg0QUh5Uk5OV0g2eURGUnMwbWlCSk5Wc0cwaUlRQ251RmNhRGQzdGozdC96?=
 =?utf-8?B?MERpdlUxQlZBcUlqOTdwS2UzYXJMUmFOcW5MYjlqRitEYWhOSVBiK1V2WlU5?=
 =?utf-8?B?S1pOUHA3dFhBWVpVL2RiSU5pbHpRRmVVWTFyV00wYVcyQTNHMU1DOXZ4dEo4?=
 =?utf-8?B?QTU3MkpFTHQ5NmtpbTZDanM2eVhrVFFqMFI1WXlTeTROUkdZTGZoeUdHQk94?=
 =?utf-8?B?Z3oxU01aeXB4YU1odGJxejBwZXJ6NjhoS0xkdjJkSTZMaXpTV3ZIYnlmVHpZ?=
 =?utf-8?B?L0FBVnFBVi85UEtENGc3eGhkNjJhK0d2d0dPbjRRRXcyUng1aERsY3VHaGJx?=
 =?utf-8?B?elRMaTJMWUIwbkRWblFmUFgxZmt0elNSWjUwNk9PMGorYnBLbTR5c3JXK1Fa?=
 =?utf-8?B?RGg5K29IdVNEQ0tTZzViM1p2TGc2THdHTDJRK0YzdjhIWXBkZmQvUVN1VjAv?=
 =?utf-8?B?WW92SWxScTN0eUNKa01DK2ZtVVlPTnJ0cWxna0FIYzFVUUNuMzd3d1hYUEdC?=
 =?utf-8?B?eHFZdkJqOFVCTkc3VGthcmdaZ2wza1RMWkVWakkxeEJMZ2Q4MzhXTFA1eVVr?=
 =?utf-8?B?bXNkM0ZlQjNZOTM1NW1TU1p4RWVEVGFQbnRUdDZXT1Q1RlZqRFRTVStuR0Ju?=
 =?utf-8?B?WDZEa1hpelp2RDIvMDl3U0QrcXpRQnF0cEJTOHQyY3JEclVYODZtNnJ1U0xC?=
 =?utf-8?Q?0pnXS0v88HE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7480d7-b1c7-4fdf-da3b-08da0666a9c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 09:32:02.9949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNnlwGCJ4ZjOOvLsPz65cQ6+9f34rMRmcu1GjFPFfc+g8M5/TWaCRFVTteufDmInn49QmNYZRLmT031US5FhPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIE1hcmNoIDE0LCAyMDIyIDExOjA5IEFNDQo+
ID4gVG86IFpoYW5nLCBUaWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IFdlaWdodCwg
UnVzc2VsbCBIDQo+ID4gPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsgdHJpeEByZWRoYXQu
Y29tOyBtZGZAa2VybmVsLm9yZzsgbGludXgtDQo+ID4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gQ2M6IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50
ZWwuY29tPjsgTWF0dGhldyBHZXJsYWNoDQo+ID4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRl
bC5jb20+DQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZl
YXR1cmUgaWQNCj4gPg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiBGcm9tOiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPg0KPiA+ID4gPiBTZW50OiBGcmlkYXks
IE1hcmNoIDExLCAyMDIyIDEwOjQ3IEFNDQo+ID4gPiA+IFRvOiBXZWlnaHQsIFJ1c3NlbGwgSCA8
cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+OyBaaGFuZywgVGlhbmZlaQ0KPiA+ID4gPiA8dGlh
bmZlaS56aGFuZ0BpbnRlbC5jb20+OyB0cml4QHJlZGhhdC5jb207IG1kZkBrZXJuZWwub3JnOyBs
aW51eC0NCj4gPiA+ID4gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnDQo+ID4gPiA+IENjOiBYdSwgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT47IE1hdHRo
ZXcgR2VybGFjaA0KPiA+ID4gPiA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4g
PiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZlYXR1cmUg
aWQNCj4gPiA+ID4NCj4gPiA+ID4gPiBPbiAzLzcvMjIgMjI6NDMsIFRpYW5mZWkgWmhhbmcgd3Jv
dGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRoZXcuZ2VybGFjaEBs
aW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQWRkIHRoZSBmZWF0dXJl
IGlkIG9mIHRoZSBPRlMgSGlnaCBTcGVlZCBTZXJpYWwgSW50ZXJmYWNlDQo+ID4gPiA+ID4gPiBz
dWJzeXN0ZW0gdG8gdGFibGUgb2YgaWRzIHN1cHBvcnRlZCBieSB0aGUgdWlvX2RmbCBkcml2ZXIu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBHZXJsYWNo
IDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogVGlhbmZlaSBaaGFuZyA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogUnVzcyBXZWlnaHQgPHJ1c3NlbGwuaC53ZWlnaHRAaW50
ZWwuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy91aW8vdWlvX2Rm
bC5jIHwgMiArKw0KPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykN
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvX2Rm
bC5jIGIvZHJpdmVycy91aW8vdWlvX2RmbC5jIGluZGV4DQo+ID4gPiA+ID4gPiA4OWMwZmM3YjBj
YmMuLjY2MGUxZDBiZjZiOSAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdWlvL3Vp
b19kZmwuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91aW8vdWlvX2RmbC5jDQo+ID4gPiA+
ID4gPiBAQCAtNDUsOSArNDUsMTEgQEAgc3RhdGljIGludCB1aW9fZGZsX3Byb2JlKHN0cnVjdCBk
ZmxfZGV2aWNlDQo+ID4gPiA+ID4gPiAqZGRldikgfQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ICAjZGVmaW5lIEZNRV9GRUFUVVJFX0lEX0VUSF9HUk9VUAkweDEwDQo+ID4gPiA+ID4gPiArI2Rl
ZmluZSBGTUVfRkVBVFVSRV9JRF9PRlNfSFNTSQkJMHgxNQ0KPiA+ID4gPg0KPiA+ID4gPiBXaGVy
ZSBpcyB0aGUgIk9GUyIgY29taW5nIGZyb20/IGlzIGl0IGZvciBhbGwgT0ZTIGRldmljZSBvciBh
IHNwZWNpZmljIGNhcmQ/DQo+ID4gPiA+IEFueXdheSwgY291bGQgd2UgaGF2ZSBhIG1hdGNoZWQg
bmFtZSBwZXIgcHVibGljIHRhYmxlPw0KPiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vT1BBRS9s
aW51eC1kZmwtZmVhdHVyZS1pZC9ibG9iL21hc3Rlci9kZmwtZmVhdHVyZQ0KPiA+ID4gPiAtaWRz
LnJzdA0KPiA+ID4NCj4gPiA+IFllcywgSSB0aGluayBhIG1hdGNoZWQgbmFtZSBvZiBwdWJsaWMg
dGFibGUgd2lsbCBiZSBiZXR0ZXIuIEhvdyBhYm91dCB0aGUgIg0KPiA+ID4gRk1FX0ZFQVRVUkVf
SURfSFNTSSI/DQo+ID4NCj4gPiBOby4gV2UgYWxyZWFkeSBoYXZlIHRoZSBzYW1lIG5hbWUgZm9y
IGlkIDB4NiBkZWZpbmVkIGluIGRyaXZlcnMvZnBnYS9kZmwuaA0KPiA+ICNkZWZpbmUgRk1FX0ZF
QVRVUkVfSURfSFNTSQkJMHg2DQo+IA0KPiBJcyBpdCBwb3NzaWJsZSBjaGFuZ2UgdGhlICJGTUVf
RkVBVFVSRV9JRF9IU1NJIiB0byAiDQo+IEZNRV9GRUFUVVJFX0lEX0xFR0FDWV9IU1NJIiwgYW5k
IHRoZSBuZXcgb25lIGlzICINCj4gRk1FX0ZFQVRVUkVfSURfSFNTSSI/DQoNCkkgYW0gbm90IHN1
cmUgd2hvIG93bnMgdGhlIElEIGFsbG9jYXRpb24gdGFibGUsIGFuZCB3aHkNCjB4NiBpcyBjaGFu
Z2VkIHRvICJMZWdhY3kiIEhTU0kgYnV0IEkgZmVlbCBpdCdzIGJldHRlciB0bw0KaGF2ZSBhIHNw
ZWNpZmljIHByZWZpeCBmb3IgdGhpcyBIU1NJIGluc3RlYWQsIEkgaG9wZSB3ZSBkb24ndA0KaGF2
ZSB0byBjaGFuZ2UgdGhpcyAweDE1IEhTU0kgdG8gYW5vdGhlciBsZWdhY3kgb25lIHdoZW4NCnNv
bWVvbmUgYWRkcyBhIG5ldyBIU1NJLiBUaGlzIGlzIGZvciBGUEdBLCBldmVyeWJvZHkNCmNvdWxk
IGltcGxlbWVudCBoaXMgb3duIEhTU0ksIGdlbmVyaWMgbmFtZSBzaG91bGQgDQpiZSBhdm9pZCB3
aGVuIHBvc3NpYmxlLCBhbmQgYSBiZXR0ZXIgcnVsZSB3aGVuIG1hbmFnaW5nDQp0aGUgZmVhdHVy
ZSBJRHMuDQoNCj4gDQoNCg==
