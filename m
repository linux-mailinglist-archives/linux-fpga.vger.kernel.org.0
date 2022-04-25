Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3EF50DEC5
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiDYLa1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiDYLa1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 07:30:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93867E0F3
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650886043; x=1682422043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RLQk+3yiLW6xOdYAzjKrVCfBWiti6nKVP138uQEhJ9w=;
  b=kU8rF6Yx9iNBoczU6kFDiw0+8Ccqwy92KTRaqvA5KkEiqBFc896eFztw
   JkFUpstU1inSiaEWEo2ZZvtEW4BpG+v5eFAaerCtVRqLskJE1YCL7OS08
   DVec7LD+niXvcVnn+K6McFAwVSxasUVpQ70llhyFv+2nye8+bDkshE6Sh
   4ADRsN/RCVOCLZM/w/pCd6npBLH9QBixcCwrHsEnd+FTrg7jL2HnPnfsm
   elRa7danw7c3k8liVuSbekjbQ8strYvrnKE+jqA1ck+x6WXRUZRhw7K4A
   l64mJ6Ha+26ilTONr+3AxDajuX/puhv2xBnzUB15NHDNxK46pNYONTKSH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="325708463"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="325708463"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="649657734"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2022 04:26:59 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 04:26:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 04:26:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 04:26:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 04:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6cD9PuHcsgnKRzkdX4hbZnfEqOTGngGDCj4cyVHcTQypkLB3iBmkJGaRlppqg0TNtJz0D63WJoNM13WMvtK52iX8KWCBN8cWVTdAzk21YLH6be/Sqw1n9/NvFheBZnltSVAl0s6XfaMEtei6e7zMFnngy3uk86SLllR6YTFrRWRsbyQ/prQtGH5rAh6i+0KeXobl2yL1CuxiM2oc75OGbQ0d8apQL5nbHPYpAI0Pept8+Fs+a47utmYrFt4WK/PSXlYA/iJ6HkxVxtuydGLcogTR9YGw8m69qIsPoP4+Ujgc641VTTmtu44sHQzzr+NCbxJ3xirTnFDifscBCdQJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQJaicZp2j4KpVTeUh+nsHC1+9gUrNCq2/V3Al5a0AI=;
 b=Yk85UcaNck36hzYXFL6D3+sz9FZBS3sF4qU6hHARTkxz2wMQ0V6SPICCm13T0tW1Yq18oO423xYP95hEkr9GWqzf19KS6qo/pKEE7bdq3XMWvZaVwFOWJKVzbqDsP578wJm0gBr0VK/VhMm9pR3pz+lAu+JKh0kQM4Ccqn4dYQKo7ynIOPWuV0mmLdzHYHxY/kFLnRKJUrXfE61KTj2ZzdZ1MW02eUqDK+TotixsKun6WafJIvMRh8Ps/veAfEzk48Q50cpionDnzJSMO9Fu1anlPk5qMjEDdq6Jqx2UJVGUanQI6RaOzy5WwYodaAfnZQr4BFXfoSjpr7I95V1rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN6PR11MB2035.namprd11.prod.outlook.com (2603:10b6:404:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:26:56 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:26:56 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Topic: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Thread-Index: AQHYU8LoHkY5keYwnkW64jIHxsMWF60AUwQAgAAz9FA=
Date:   Mon, 25 Apr 2022 11:26:56 +0000
Message-ID: <BN9PR11MB54836B6CBB3D0569D2776A8AE3F89@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220419075224.430824-1-tianfei.zhang@intel.com>
 <20220425082006.GD363795@yilunxu-OptiPlex-7050>
In-Reply-To: <20220425082006.GD363795@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 19ce6a33-f458-4ab5-8bc5-08da26ae8194
x-ms-traffictypediagnostic: BN6PR11MB2035:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB20353BAD100D902C32A7941CE3F89@BN6PR11MB2035.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YeyOwF4xSJRaUWD8JbtVYBSZG2++e7eaqejn1BKYUw3ByadmYo9gUMbkKzA7yhaaaID3+TyDGt89aO1nFDAekmBz9HQKAlRlIE9lZ0Y91Y77G8IqW+DBizF1r3uSErF+A7wgzqBBd53ZwVDMSD5ghy3JMMs6K8RbvUpfPBtXp6rG2Ue3o3RnXOBdcpq0yA56ghRqD/rad7c9rbzf/gUnzcdKVEfMC1pM+p5h9D88yvmSuE8IQRdi1d8zngYODHgDZrSNNCT+VpNy4vXZWF8qxMNwRtEQFslzW/0yPyrTRbz8FFckDfQ286RGoubZltVbYnG2Ojj7QZbUetfdCbP6YfYXSBBUWCv3gmtjVfr06xrk7N+j6oDpurDwI5JSWHC4QgyxONijrmD1RiNRCAUL6SsXSVNdz5M1pM0Bu9U5vwb/ndjOylHIcW7H72nElcaW923ybS8nezLrMEs3xlpyD5ae5B8VRJWVQM9ZXwIpenBNNuO3LWClj2gtjUArtD9QBp217bcNSgqvW4MchCihXuByBvUnHngIlEqKw3l+x1yJL50nsr0LXvIIIrs3zUzSnyeyP4usfx12VVzbtD6RgGSyP4E0e1vTqHy+h61WgKom4Q9I0dKVYtRltdIbPid6bCx66U7rbvZSkR3AkTNeV4nmw0pgtTJEWoO2y4BTlzb/ib/IVdcoUBvusXCHBE+OlCITyGsUVjWTD4Gvtp78nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(508600001)(186003)(76116006)(66946007)(66476007)(8676002)(6862004)(66446008)(66556008)(64756008)(54906003)(122000001)(71200400001)(53546011)(6506007)(7696005)(26005)(33656002)(316002)(55016003)(9686003)(6636002)(82960400001)(2906002)(86362001)(8936002)(38100700002)(38070700005)(52536014)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FSjX02LV4GKHirF2hbA1MsDYoVOjYXZaAq6QAlj2kHxfzyqdRNibiLTKkTAP?=
 =?us-ascii?Q?PIZgMbpmfLVd+Tgpv7JU3/GzYoQL3Vf5kczFfVOlE7JZ3CZQssmqonQuxsbe?=
 =?us-ascii?Q?mWw/FSyxmokZDicquHE10ZS0UA2WqThl9wFTOPnKBVwgtLY33QsVZm13sgNd?=
 =?us-ascii?Q?Pmyh6eDsh302UpzEqwoF+qr32slD7CZ6JaoDXqKZDuNM24pIrSIc7DOClRaw?=
 =?us-ascii?Q?hhmEGDeUU79p99Adf6kgNrPkt7ACwuBRS0C4VvgrT7tZ2kDj2o5SwD9Rs5Xx?=
 =?us-ascii?Q?bFQ4JYOBNoo3zrl7GLqKFU0BnDO1URxfetX4lHsrerNysAfzLtZm7OjKpM0O?=
 =?us-ascii?Q?PKjjRs0LVpoNi4PFUdoF5RJaxRWveGjFkmkCHcw7GbIMq9BRrpxoYm/WtoIn?=
 =?us-ascii?Q?sIsf5Nrx24Mig73BfUFNFFa5lpchLODPFp4xAZPfBrZ4Kl2gbInxLsu0Mxjs?=
 =?us-ascii?Q?+mC5V3/TJqgCa3jbnmh4TO5Limnahi4AIoEUKephhtepujPw8+sMO+2RDvmT?=
 =?us-ascii?Q?Qumq1cKELQ4ioGFJEaqWerjOGlyckUxhC7nlH/rB9GthTO8i09kBOLoMv40G?=
 =?us-ascii?Q?N0npHHAkJZQa19CFfcp39bgE2KEWOsp1gX34zufz2n1MV2NVl1esgny6QEpC?=
 =?us-ascii?Q?EbAmI6yNhMLyJSdK0IF0VYLlleH1q2oiYrjT93fRwPNrNOWKg1GkOCEmW+6O?=
 =?us-ascii?Q?/tSvmGnxAG32d+vh1tX9fpdMsB6QOwLNClTKfGcnrsiU15qwjn8PefczV21E?=
 =?us-ascii?Q?0dROKlVxDOZgGXzKOwDU4uCeRcxI45VzZjrr9UR1qWmdhQj5y4HB8HHhsQ05?=
 =?us-ascii?Q?v44jIHq5DJ40vbhzgb/V3jA28LI2sMmBdJzOAb05phcaF94vjwPVlV6L729R?=
 =?us-ascii?Q?Q71Y+W7EkPOKHXMQjjjI2dLp8ZY6weeAzlrJySaFN6lUKkic5ZATP9GOAWKL?=
 =?us-ascii?Q?RJ1xJUwnpPg/TDbERWdhQMGp5D8fW0lCcVBMTJrfcsZM5jeXxXIsheoDaMzc?=
 =?us-ascii?Q?cSG51ZwB4UTcrS8w/kpZki8LyWfO3IXzs9QK1Ds6SnDug7OryI9fYsQPYvTX?=
 =?us-ascii?Q?nDaS/kSj7S7zINkVjuO+XdCwMwZazGi8N2sytWQ0Ar2RJtqNrv1NrXzWgjbj?=
 =?us-ascii?Q?X+Vl65GSaB9lIMaJ5aY08dpQe4f7RnP80n0OTa3gImi7NK6s5XrIPTMThrmr?=
 =?us-ascii?Q?tCM8t1IWYvbKKt0/PAYm5p8WfXv0/OHoxMo37z6PZcCxjohv9A9NZmT2uWbS?=
 =?us-ascii?Q?5Kea+OLkFWPIHCDlbTGHJNmgi78ISGo29gk68WkFbqMXISGMaizt3z5JAfYO?=
 =?us-ascii?Q?eE+qtKUDIqiXEISfcGdWrkisMgPg0z88IEy1F7Xkz4SrSw8iLF+wJxdhtQuN?=
 =?us-ascii?Q?DFy3kDyuDjpyhphh1IbK9fwImZA/dVFxBsXbvEgOfZxB9InvBgxp03+Mjx3P?=
 =?us-ascii?Q?tivAG1WreMU2Q1AvIQvn3qOhBfhoY3EvY+aVuTTnM6eoDugqBAzTBGlFAPpL?=
 =?us-ascii?Q?sjLLSTZ1+p6mxtKwliGCP6nAMVVdeysiuaN+Su/np8ZCMrvt0eySqSrrof7i?=
 =?us-ascii?Q?b/hfUaFhOb5uMRcVUDh/5mPkpp8iu4DmE67tLarI9+WSJKB5rTal0RZv3vcS?=
 =?us-ascii?Q?ghE9oz7LJMW9auJL/uE5eT5pNEbX3bXpaPmSd5LnKy+OkffuVhn94sFP94Yx?=
 =?us-ascii?Q?ktoJBYc2anT1aVgxBxY4lXlptYdhPEEBkVOPcFvQGggzIPjdu6lXmNkTp3pg?=
 =?us-ascii?Q?r3bznreszg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ce6a33-f458-4ab5-8bc5-08da26ae8194
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 11:26:56.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGvjtgIiix+Ui3xjrjHvpfZCrzjy6TsnkpQGnJGINBttf3XT3njTyRWNZypozMNY/ZhZK400wShryr5IxM8aFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2035
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Monday, April 25, 2022 4:20 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; linux-
> fpga@vger.kernel.org; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
>=20
> On Tue, Apr 19, 2022 at 03:52:24AM -0400, Tianfei Zhang wrote:
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are
> > not connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack
> > device), PORT DFLs are connected to FME DFL directly, so we don't need
> > to search PORT DFLs via PORTn_OFFSET again. If BAR value of
> > PORTn_OFFSET is 0x7
> > (FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for
> > that port. If BAR value is invalid, return -EINVAL.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> > v2: return -EINVAL if bar number invalid.
> > ---
> >  drivers/fpga/dfl-pci.c | 11 +++++++++++
> >  drivers/fpga/dfl.h     |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > 86ed9e4223d3..5bd6ef231ccc 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -263,6 +263,17 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar =3D=3D FME_PORT_OFST_BAR_SKIP) {
> > +				dev_dbg(&pcidev->dev, "skipping search DFL
> for port %d on BAR %d\n",
> > +					i, bar);
>=20
> I suggest we remove the dev_dbg, it's a normal case in DFL walking.

I agree.

>=20
> > +				continue;
> > +			} else if (bar >=3D PCI_STD_NUM_BARS) {
> > +				dev_err(&pcidev->dev, "bad BAR %d for port
> %d\n",
> > +					bar, i);
> > +				ret =3D -EINVAL;
> > +				break;
>=20
> The code is workable, but I suggest we use goto instead of break for erro=
r out.
Ok, use goto is fine, I will change for next patch.
>=20
> Thanks,
> Yilun
>=20
> > +			}
> > +
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > 53572c7aced0..e0f0abfbeb8c 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -91,6 +91,7 @@
> >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> >  #define FME_HDR_BITSTREAM_ID	0x60
> >  #define FME_HDR_BITSTREAM_MD	0x68
> > +#define FME_PORT_OFST_BAR_SKIP	7
> >
> >  /* FME Fab Capability Register Bitfield */
> >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> version ID */
> > --
> > 2.26.2
