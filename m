Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2383B4C83E1
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiCAGVX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiCAGVW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:21:22 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2294475A
        for <linux-fpga@vger.kernel.org>; Mon, 28 Feb 2022 22:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115642; x=1677651642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nt5hj+s8Iu2BkGjslX3SLKVD2fkRse/3uHoFrI8Xm5U=;
  b=UPgSaCMWo1+R4p1WbUdc9GE+LWCQnnXzbrm2QhenTGH6BevsZMFLemm5
   ictfoBQMc8IKsJlPSqFZwOY6AtNaVvcM7uZ0uKd/IDD/MLUMhs0LHmwol
   ftPC4j1IVIYnGZXY87KEcc+o0LFKuHp0iD0yxjj4vv9hPuZAldW9mVAOE
   NMYhbXDmdvQtKUUsf8J9qqaXkS6djEdkIO0H0UWo9kDyKqr499tfVcf0a
   k6BqvVJkY1BYpAvNuHzrgO01dvrToQPffmnyb6VFI+7iQAg649slseGxl
   1Jx2z8JbuwsHRUK1o7/vu4R3xOarpy+BCD/+2baIGqaFgOJA5yWWWtNdg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="233685374"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="233685374"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:20:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="534772950"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 22:20:41 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:20:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:20:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 22:20:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 22:20:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu4hoSYsyouoPKue+P76WSCMy/YkfqII4BxhS5Y221Yu1+aCvAYsb8MU5ULTwtB6V5ZBFBLlGozUnoExfwqLT0Bs5l6SSjvO0ZfNe+JbC5Hi1xPrHdotwc8ZOxLfsleJJldaFQ/Bifx+H5qoY/68Opwcfs3sf1pVRpDC6uNIF6ArMCiFaDN7XwXXXfMe5GzRT0AzWInPig3iGGT9TPST2q9ApGRmvcyBWoFJ7XHfzs1XOKmzeneBr7tWPZfuUOgf5aNbFLWRhmzNYTZ8KnQFuiJ6bQZut6Uj5NwW1KfToXiUXAry+JS0JXypaASyVURXe7RsejxU4v2wjIg+frCdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxJJV51bslHA1RseFIO5m21Q1JPUrCfl4pmBEL9I3oY=;
 b=cByhTv2PNmncEjejtke9FdOed8HqI7aKq/mUnxJcO0ZS7PODUUYqVJAFEAiFmO7qkpkoj/kMLNKw76lVkRdgeBuoYUM7Z4riRMITOg28yG0bjmBA4pq5Ukwif9qVIdbWMUt7DwIgySZ8KceZkWwPThk+xx82wKqE72C8HQqRi7bqxEc30RwrGKcOsDNwuiz+vItSwtFMqTf2DYsFFVlbRkjVCbylqxX2dhlDq5j5xkYDMmOGe8BtlBy1C8gB4j+vTfGv7NA/jiTV+DHQVaxRMXOKhRkqiwqmqRxxZuZqG9EiZl3wEwDBgy06gHDEPaEru0ryCjEQmga3/lnpeBCPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by BY5PR11MB4402.namprd11.prod.outlook.com (2603:10b6:a03:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 06:20:37 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:20:37 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [bug report] fpga: dfl: fme: align PR buffer size per PR
 datawidth
Thread-Topic: [bug report] fpga: dfl: fme: align PR buffer size per PR
 datawidth
Thread-Index: AQHYJ8kPhxOMjMO8xkGMKccWSGC3z6yqF/gQ
Date:   Tue, 1 Mar 2022 06:20:37 +0000
Message-ID: <DM6PR11MB3819E15FC4D4EF35A23BC1CC85029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220222084851.GA14540@kili>
In-Reply-To: <20220222084851.GA14540@kili>
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
x-ms-office365-filtering-correlation-id: 2d850d6f-b4c8-4f03-8576-08d9fb4b9a19
x-ms-traffictypediagnostic: BY5PR11MB4402:EE_
x-microsoft-antispam-prvs: <BY5PR11MB440205B32371825BD737C4C485029@BY5PR11MB4402.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TI+Xga/h+8YC2K4TtA/jn9vsD4d89pBqzT1+0Alu5pxa3RLVVYguggNpgsKLut2dM9iOY6+8gBuglPxUGM1vWBiAfeZLOqyUqQxK0uS0gJt9WrqNrOlC4zJh0u7uL6jRURnc+3EnUu8LmSifTQlHi1JcEQSAALXZBdYlpupEGF/jg4RKle026PskHyHAg37fCwtDXyuGRfhr3p9+AFhVkzeL1MANUhfEBK0+Nbd4zzcidjoHZIz367VfY38RfeM9HdihN/qaf9FIoFelloDGgMqqKyEtA1+x/2HIxbK8LqOtqd3faIttv4MgkVVL9PUH1gSk7EjxCxhR1GSXoWP1g/6LmaW3pqsCc8/mhf4NaosTkZTv7ASisWTvXWYn7qx4Mhup5fJalqukSbg/nlSLCL2G3YFfdmUm0K6cLd94sgP8991TsC1OKnutHU95wVG4ek2Vwv2NQdj2oddzZxkqPKlJ+PjLmbEbh1z67ClNJPypd/f+ERmGuxBtyWriH7r7HYrEU3lI88mY6+Qp4ZjDGCjw9OcyikxWQGrcKpVf9Wef1BMxvqHAIDDAc84Ur3Ry1U2TFkiFHX3DmhCtHt2KwuxQ3kw5T3qKUnLUD25jSm981uEkZaxayu6YPdBOdoNt7k+sNfM96dufhwVzR+hD7TLQNuQCfL0nT49AHz0R+7mx/RJPl8vaVtWD0kwXpGgTL3GDND5WsFVZtYnSGpbn7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(33656002)(52536014)(55016003)(316002)(5660300002)(8936002)(4326008)(66446008)(66476007)(8676002)(66946007)(76116006)(66556008)(38070700005)(122000001)(2906002)(86362001)(38100700002)(82960400001)(64756008)(186003)(83380400001)(71200400001)(6506007)(9686003)(7696005)(26005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4gz+n+erYodbUooF8qP5yXVVbf9C8gzB2Ooa32LmDWg60ZHZA22essOoBHz?=
 =?us-ascii?Q?EQ8PRfC73iUfSzkGyRKdXroUXX3l1+Xjy7btnKPUOFHJTQDxNE0ZEAngnAHY?=
 =?us-ascii?Q?0rdjY9eU4tX/qAl8e8VOxNp13mZHNOsskZcECPoKAI3XI2P2lBG7AxDogFmX?=
 =?us-ascii?Q?vr1lXV/me60RMoosHypaCeF5yS4Yy+sqbnT28FiwB3/wiilic0bFZmJ1s/6K?=
 =?us-ascii?Q?yJuQbEXFRrHXBn7Xd7DYrfjo77T5NlJmy1ECu0TGcUxmX8/jibIot7AbgrfP?=
 =?us-ascii?Q?6hxvysotGvk9A6kYUiho4ojj5V6F207HXVJKzrtUQUgj1R+Jh3P97xE7m+QJ?=
 =?us-ascii?Q?YJyv4royTHFdvrR+oxDY6taXorRPi7R3WVXr6b1qr9DOjmc1rrBtXnNMlYFf?=
 =?us-ascii?Q?UA7PdJT39mCz/mPMy/JxCLbrGMwifSX0sVFUIFN50CxnTXqK0xorAmEhawK2?=
 =?us-ascii?Q?yHXKhnMmzMikMK82yMp0K+hcb9AKhqDYS3A0veNkj6TrdkQdVGOCodQN1qL9?=
 =?us-ascii?Q?wckW49DvKRk3II9iw37pEtFsgySv7pJIBnXDvwU2uw6W3A80eNLRjptqAD4M?=
 =?us-ascii?Q?GSavT2hSo0WuayCe9qXksx+D/Bsj5tY37IZMF+hn/Yl5BIqgoIiw9ggGjMyI?=
 =?us-ascii?Q?8Flv/YXl4xPGZX1H8BbwBvVQJSHoByoCXbuF7hbQgxXdXOKPqwI+oo4Ul4aK?=
 =?us-ascii?Q?clXdo4DZg7fFc33WnjIhAlNqLa46lDShpEcUQtqVEqRy8plrEXc/GVGH5CSr?=
 =?us-ascii?Q?flh2OVuNahnJL0Ki/8U/1YiBSMem/UaCAlSgR9X0MtOo7QPwC+sNVgNa6WOZ?=
 =?us-ascii?Q?aKJUcmpJQ8MYJLetrzxOvN6anRfYWidFgSs4rr0Rgv56L+ZhlD1cMH84dXCZ?=
 =?us-ascii?Q?vkfs06qB5cf+SnHCEt0+G93QovR9ES60NdMFcNtmIPoZEzssOYS6O9dabjrA?=
 =?us-ascii?Q?H04eok584DOuhQPCNL+CuVLypE/l2ogsZMnFxgYN1TG5O30zebZwqMe3aLYy?=
 =?us-ascii?Q?gfkXMcRdsy+zQ6z8aHuZbrSzlkWTYvrxia00iJe5FhL9vN5zqEqbbj72dynQ?=
 =?us-ascii?Q?E1V0zi3lxdOPYtg1mHUW0as51B1buOsD44/29ncwXfcS7zNBb9ssGb5BODfm?=
 =?us-ascii?Q?rjMvAUEymRIRGRN25mX5QW9Jf7zSBxVOOeNINEzFmQ4OcHh8dRE/UiUbpUFm?=
 =?us-ascii?Q?Q2wAVYZgn2hoAhD6aVNNMkY4b1GPXxLbUq6s4TZGe9u5mnJztASnkZ1x/CLu?=
 =?us-ascii?Q?JjyzoyS7rafgXNkv6my9cPJefmyrreiHFhi1m9KlLckoq6FKDwW4v8fpcLbQ?=
 =?us-ascii?Q?Jg8f8V4RD/yU5yRPq+Oq3hmwMqy5Vsd+Y3cALvAhJZ/nY2yw9vTkzxvuZzQK?=
 =?us-ascii?Q?8GYqW70Bd/DbJjQLF3ekecqrrD5XaO/gjK5779IKMbwE+UxGcsVQ2qglKcbC?=
 =?us-ascii?Q?3k8VRAYqMqDtIqFAxiv2l+d3vEKK7jI3qU0BZqS0vAv7XUFQ9/hEI0Ud9JXk?=
 =?us-ascii?Q?Omg7nvYtFxrkyuxMiPt6ajdKyCk2R/zLu0Wj4YIJE+enCojbQK7DvhgCFjxd?=
 =?us-ascii?Q?BeeIdmPgVKcSsTqy1MaavgCOWEtK2Oroy/ge1LjIzhoxf9Rq1k10CP2ds4VQ?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d850d6f-b4c8-4f03-8576-08d9fb4b9a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 06:20:37.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+P84JelUA7SoEqqk8ZCuzu8YVuUbOgZOmF0kv5+JAYSg3zXWTzkATvAhgrFe8l/COTQjYk0orH/6HQncbbwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4402
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

> Subject: [bug report] fpga: dfl: fme: align PR buffer size per PR datawid=
th
>=20
> Hello Wu Hao,
>=20
> The patch 69416739ee36: "fpga: dfl: fme: align PR buffer size per PR
> datawidth" from Jun 27, 2019, leads to the following Smatch static
> checker warning:
>=20
> 	drivers/fpga/dfl-fme-pr.c:104 fme_pr()
> 	warn: potential integer overflow from user '((port_pr.buffer_size)) + ((=
(4))
> - 1)' [local copy]
>=20

Thanks for reporting this, will add checking for it.

Hao

> drivers/fpga/dfl-fme-pr.c
>     66 static int fme_pr(struct platform_device *pdev, unsigned long arg)
>     67 {
>     68         struct dfl_feature_platform_data *pdata =3D dev_get_platda=
ta(&pdev-
> >dev);
>     69         void __user *argp =3D (void __user *)arg;
>     70         struct dfl_fpga_fme_port_pr port_pr;
>     71         struct fpga_image_info *info;
>     72         struct fpga_region *region;
>     73         void __iomem *fme_hdr;
>     74         struct dfl_fme *fme;
>     75         unsigned long minsz;
>     76         void *buf =3D NULL;
>     77         size_t length;
>     78         int ret =3D 0;
>     79         u64 v;
>     80
>     81         minsz =3D offsetofend(struct dfl_fpga_fme_port_pr, buffer_=
address);
>     82
>     83         if (copy_from_user(&port_pr, argp, minsz))
>     84                 return -EFAULT;
>     85
>     86         if (port_pr.argsz < minsz || port_pr.flags)
>     87                 return -EINVAL;
>     88
>     89         /* get fme header region */
>     90         fme_hdr =3D dfl_get_feature_ioaddr_by_id(&pdev->dev,
>     91                                                FME_FEATURE_ID_HEAD=
ER);
>     92
>     93         /* check port id */
>     94         v =3D readq(fme_hdr + FME_HDR_CAP);
>     95         if (port_pr.port_id >=3D FIELD_GET(FME_CAP_NUM_PORTS, v)) =
{
>     96                 dev_dbg(&pdev->dev, "port number more than maximum=
\n");
>     97                 return -EINVAL;
>     98         }
>     99
>     100         /*
>     101          * align PR buffer per PR bandwidth, as HW ignores the ex=
tra padding
>     102          * data automatically.
>     103          */
> --> 104         length =3D ALIGN(port_pr.buffer_size, 4);
>=20
> The ALIGN() macro can wrap to zero if it's >=3D UINT_MAX - 3.
>=20
>     105
>     106         buf =3D vmalloc(length);
>=20
> It's sort of harmless-ish because vmalloc() will WARN_ON_ONCE() if you
> pass it a zero and return NULL.  But we could try to prevent the stack
> trace.
>=20
>     107         if (!buf)
>     108                 return -ENOMEM;
>     109
>     110         if (copy_from_user(buf,
>     111                            (void __user *)(unsigned long)port_pr.=
buffer_address,
>     112                            port_pr.buffer_size)) {
>=20
> This doesn't zero out the padding, so it might be flagged as an info
> leak depending on who is reviewing.
>=20
>     113                 ret =3D -EFAULT;
>     114                 goto free_exit;
>     115         }
>     116
>     117         /* prepare fpga_image_info for PR */
>     118         info =3D fpga_image_info_alloc(&pdev->dev);
>     119         if (!info) {
>     120                 ret =3D -ENOMEM;
>     121                 goto free_exit;
>     122         }
>     123
>     124         info->flags |=3D FPGA_MGR_PARTIAL_RECONFIG;
>     125
>     126         mutex_lock(&pdata->lock);
>     127         fme =3D dfl_fpga_pdata_get_private(pdata);
>     128         /* fme device has been unregistered. */
>     129         if (!fme) {
>     130                 ret =3D -EINVAL;
>     131                 goto unlock_exit;
>     132         }
>     133
>     134         region =3D dfl_fme_region_find(fme, port_pr.port_id);
>     135         if (!region) {
>     136                 ret =3D -EINVAL;
>     137                 goto unlock_exit;
>     138         }
>     139
>     140         fpga_image_info_free(region->info);
>     141
>     142         info->buf =3D buf;
>     143         info->count =3D length;
>     144         info->region_id =3D port_pr.port_id;
>     145         region->info =3D info;
>     146
>     147         ret =3D fpga_region_program_fpga(region);
>     148
>     149         /*
>     150          * it allows userspace to reset the PR region's logic by =
disabling and
>     151          * reenabling the bridge to clear things out between acce=
leration runs.
>     152          * so no need to hold the bridges after partial reconfigu=
ration.
>     153          */
>     154         if (region->get_bridges)
>     155                 fpga_bridges_put(&region->bridge_list);
>     156
>     157         put_device(&region->dev);
>     158 unlock_exit:
>     159         mutex_unlock(&pdata->lock);
>     160 free_exit:
>     161         vfree(buf);
>     162         return ret;
>     163 }
>=20
> regards,
> dan carpenter
