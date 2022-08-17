Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB3596CF7
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Aug 2022 12:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiHQKpU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 06:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiHQKpT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 06:45:19 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AEF65671;
        Wed, 17 Aug 2022 03:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcKggzlglFvJvVIdjlZYj77L/wQrVN6TrbF828PY9tPCNRjIL6qOyCQSsuM6nv5WeFO6j6pVZ+kDgXvhFYV63c+xHyg2hEMdtZw+tyc2YWdlcdTJfCE8BrxW/XxhFYdl+LppALa6ahXtr3jxfEKFsxGAtvxfdkF/TMPPkjBldPAUn3bLHUnBFn+uyuATtQXGuFW/F11odOVpSsbSOHggKlOOgH8I2VycWFrYNI0H9Pr4KTeAQftmZyr3+LzFYU6xd/xx+XRdF6ZH2TjvRBO2R5yKzMa6C27DyO9OaBbaFUGH+32efAVELOBRahQn35DecVlpSM7aq/W7vkUhMjG4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJSZYzStm4s4mvk3/6nayQz+D+d7UBgGnsX+q0ZmSOE=;
 b=gzbcVRdW7B4xdepZpQdceJGmt1YlqOGMUmlSF6Mom6jKetewlYNcED7MzZSmlJZK2O9P7Hycv9jT4x2rv4XAGufU7QFlfByxJrvWO9EPQUCc8T2r31gIEpDKhXd3FiCi7AITuuEZ0d+qHSpxeknyJKN3V7hT5f5z+GVefr8NGrj2HesGQdBNfjdei29BH4xQ4EDHLUklILjShKWPTRkQOPr7CIokSaDPaDwpzH76iy5X93dLJO1Mk4Y8qHdHXQoqOiVikYYuxHuBFyxBs4nUjfeSAN/9s58iE+MfzoY65h2HZhyJ9+tdB6ELPjZUVqOjIlnK5S5qWCDldJjqqsAeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJSZYzStm4s4mvk3/6nayQz+D+d7UBgGnsX+q0ZmSOE=;
 b=GTAy3dCv/MYtqRPmkzuNzTqEp4dyuviYrsmF+vWwhrGgQA/Rj7KM9SyvWNgFhFtbNV2D1uIodEL2o+NEH7BuEuM/fivS6jbzW1Ns4EQXkT4xyzeD/H+YWb5gGVUOmMaWXwRtGF/rQkGb5yvclSmB8/DhaiUhEHHVCj7jIqNIM9g=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 10:45:15 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 10:45:14 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Xu Yilun <yilun.xu@intel.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "abhyuday.godhasara@xilinx.com" <abhyuday.godhasara@xilinx.com>,
        "piyush.mehta@xilinx.com" <piyush.mehta@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH v2 3/3] fpga: zynqmp-fpga: Adds status interface
Thread-Topic: [PATCH v2 3/3] fpga: zynqmp-fpga: Adds status interface
Thread-Index: AQHYhVFwpTOzhNAppEePIKhgjmp+4K1kisgAgE63IDA=
Date:   Wed, 17 Aug 2022 10:45:14 +0000
Message-ID: <DM6PR12MB3993D53B5E6DBB56D44F37CACD6A9@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
 <20220621092833.1057408-4-nava.manne@xilinx.com>
 <20220628084024.GB2442728@yilunxu-OptiPlex-7050>
In-Reply-To: <20220628084024.GB2442728@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39b4c64a-97ec-40ac-91a8-08da803d917a
x-ms-traffictypediagnostic: MW3PR12MB4521:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9HK8QxZk2EF5ZvvbHBPeSrwpRqa4TCoqmPAkw4PSe8PWzfD5skmVgbpjH+Qh8++8s3MGIEkep7enlwyKIGx0gFuydRrHhrms4yKmKPVzTJNzjKbqNpkzRgPKcYozHWPqcuQSOCadf1r4nV3DeIxUJrJpRlbaZSYHa4Q/YmeDBs/A9wiXJgC0qlZADWqa4pUSdz6u5jFyUtunozJNGRZOKLjChMvTpMhVCsFhHcVEaKAYt9GkLCgm4Z8OTuuwv6GhAUZaR8GlnJcSvs7clbgOtg0+RglUxwi0BPXsJfVRStlinT1kwAQy05ngmPf78UeUyo2nHBWlQdYKvRx5k6t+FbKHhwAN5/GUAZmikLRviESoEK4/Jz+OPxsQqh2aZ6hykHtAYhjUy7Ksn4wLgPKrfHtsL+icrc/Rn923J8XHIlAAhXKzkMVltTwpMf6AHN55dFDJW5bDSmelve35bsP3g08NiEE8xnoc+qL8TSopm6mVvHurBwAdHct6DruCJXKcTuwpUIDxmZklBDFxkpVs+pmp/L+k5sDtIOlszxzMHR+1T9wYmEhXPtWco7oFcv0DTe1FA438X+Q+JQvQqRv80ZsRb1Jxrcoz5AGIjN/HIFvGwHyFoeDiFMquTeqtu1i4GhaOhNYe4RaPuZM1rW9QhETSbAEXbOJ9Uaa6zJVaE5BETrq2N9jp0ag5o6vTaHpLh3cPYpuNPENQAUju+AYha7utVMWylJ2OdOwftXGtQl9oCImlJIaQ2pe+pT8hQfhQyPcOH+3/+UzgMkfRgl2EWVeGDum3YZOg2SE4pA7LLblKJDgD1lcp3u38zfps2z0L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(38100700002)(53546011)(64756008)(4326008)(316002)(107886003)(66556008)(8676002)(83380400001)(478600001)(66946007)(66446008)(54906003)(76116006)(110136005)(86362001)(26005)(55016003)(33656002)(7696005)(5660300002)(8936002)(2906002)(52536014)(9686003)(6506007)(122000001)(71200400001)(41300700001)(66476007)(38070700005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?joNWKxH95bNmK4O1vZljGL9WuysQFtv41u4ToNk5CNwTXfNFxQ/nApA7NmI8?=
 =?us-ascii?Q?Vn8yE64uEQ8ZNt/6DkYU3efx0ajj5FRcrc9Y2gnMWG1k79r4Swz1mA2wB63O?=
 =?us-ascii?Q?V3j9+5z58eUABsZXaLFMUp1jYzfBXg8NijuIJaXx9IUF+S3esfubOM1y0t8i?=
 =?us-ascii?Q?OyWHAO4+mnYilZgk6HXlwYp6i/eFIU6JiK4lW++COHbPKjF6WGxMuBloFDVu?=
 =?us-ascii?Q?FPtDQ2MEqWUfaZwt8Y4zmaJrU2Km60klQtbPR5OGoEZLm+nJLPQ1PVQeVNyL?=
 =?us-ascii?Q?JXOFMlc+7Lh87xHzitea9coVQwNj34XrlY9uahc+IQDqoN+6zc4ixuq0nXsX?=
 =?us-ascii?Q?vZYCsQAi71dKlkY3XHMyQN+/E4lVpB/UnmO8YHCsLGzUsI/G7zjkqXoXoCne?=
 =?us-ascii?Q?kJ30xDuX8J8rn4qZtLYh5ScIsN9FYtvx+MZz8AUYILkbI/IkOy/asD4kfEJ2?=
 =?us-ascii?Q?hbf8K/kikwyGDaQ0BK051FFXuYkuXLTJLqhmZccfWeR0MlnYa6MhOuCiPDvd?=
 =?us-ascii?Q?hz89CbiG3tP2vHvs7KtzXSvP4KntbnRZkfkzbjwmMBHgNTAwFfrE5P4VSLRX?=
 =?us-ascii?Q?RYHDsOLJpqPiJrDgcJdaevHmRm49ydXuwTz0VWM7btQJ2DlxVu1MRtxPV2K+?=
 =?us-ascii?Q?DY3qSLZ/qSPcH/fKhq7guByxl9saoUHfyoqFJC255IuMBzq0n94aC32ty4VV?=
 =?us-ascii?Q?9PmrvSMVazWnn3524GMLL9gUe2uP8V4ZV1pt//au/t1oKW6Z1kdSxFsZTB+6?=
 =?us-ascii?Q?ShXW94UdwqbChzlW92HWMkvmKQ0TgDBN1UlLLXnqIs+AqKQ3oszpTqETOAwN?=
 =?us-ascii?Q?mutm+l6Sl68/GbJ+obaDfArDi8hYSWT+rJRypi/7C9Jo+iWpLBj32Qfjfjmz?=
 =?us-ascii?Q?kZ/4sPb9p/4rCbqLto5uyf1+wLVXOco/e5p7YZZTU23sIm1HkrKYpqzf2XZx?=
 =?us-ascii?Q?Umpmg8CsUiSko3A87yssI3LWcRAlGg8nNVuJnR1S/n8vEyCGbt0bdbCc36DV?=
 =?us-ascii?Q?iAhZQCXXm0rHA8ygwSAM7WxVU7DVAcmLW4VTQfi0L1XUS3nAe0jt3tougz7t?=
 =?us-ascii?Q?ID1wqnQR8TcT0OglhdXS7Nf4sizUo7cmXHdByRw3FWoTVPojXmBr1PVHhGET?=
 =?us-ascii?Q?G6zIhyH1y6IldSzI4rnHLg/cAAEbyF8lTRP91kp3q1vTSN5vJVK0OhOkclFi?=
 =?us-ascii?Q?Vs3z6/Jco03vwBTpcgGo+ZFZmF6xHCI/eRBpZJHgRAtKHH8rYQAQZXmVYLVs?=
 =?us-ascii?Q?kpk2TrOTBWEHt642FAt8X9hZGwlsxCCBLg7CmmS6qwkC3DBiG9beyD2Swkq3?=
 =?us-ascii?Q?Q1BIXCsgh759WpuICYeYRF3kd8LcT4IWZrVSNalJGojAMzZNfyGnTOh/MvDb?=
 =?us-ascii?Q?38exjpPJaOKiOq9DPvFx6LnJjjKA8V1vicOgkyDmannjF3+UUepiMeaxqFtf?=
 =?us-ascii?Q?Hi1d7Xb5m5/U4QSoLNg/nUOiycLO+Plxd2FTc1lpsPzGY3WYMvp6cFV1avKe?=
 =?us-ascii?Q?KKt5rA/046JWSMZhiSlAfbOqd8+ymv0HviSjhNjxV9IfRRVSweaXRQQBQXKA?=
 =?us-ascii?Q?E6op2mXN1YEHn22KItI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b4c64a-97ec-40ac-91a8-08da803d917a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 10:45:14.7967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmoPIxgx9HFOxP2mSZjsd5efZ4T72PDDKrIsrT46Rg3JcCFFYbgx5e6PnDntaBRM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Tuesday, June 28, 2022 2:10 PM
> To: Nava kishore Manne <nava.manne@xilinx.com>
> Cc: michal.simek@xilinx.com; hao.wu@intel.com; trix@redhat.com;
> mdf@kernel.org; gregkh@linuxfoundation.org; ronak.jain@xilinx.com;
> rajan.vaja@xilinx.com; abhyuday.godhasara@xilinx.com;
> piyush.mehta@xilinx.com; harsha.harsha@xilinx.com;
> lakshmi.sai.krishna.potthuri@xilinx.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> fpga@vger.kernel.org; git@xilinx.com
> Subject: Re: [PATCH v2 3/3] fpga: zynqmp-fpga: Adds status interface
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On Tue, Jun 21, 2022 at 02:58:33PM +0530, Nava kishore Manne wrote:
> > Adds status interface for zynqmp-fpga, It's a read only interface
> > which allows the user to get the PL status.
> >
> > Usage:
> > To read the PL configuration status
> >         cat /sys/class/fpga_manager/<fpga>/status
> >
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v2:
> >               - Updated status messages handling logic as suggested by =
Xu Yilun.
> >
> >  drivers/fpga/zynqmp-fpga.c | 53
> > ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index c60f20949c47..e194bba91d3f 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -14,6 +14,19 @@
> >
> >  /* Constant Definitions */
> >  #define IXR_FPGA_DONE_MASK   BIT(3)
> > +#define READ_DMA_SIZE                256U
> > +
> > +/* Error Register */
> > +#define IXR_FPGA_ERR_CRC_ERR         BIT(0)
> > +#define IXR_FPGA_ERR_SECURITY_ERR    BIT(16)
> > +
> > +/* Signal Status Register. For details refer ug570 */
> > +#define IXR_FPGA_END_OF_STARTUP              BIT(4)
> > +#define IXR_FPGA_GST_CFG_B           BIT(5)
> > +#define IXR_FPGA_INIT_B_INTERNAL     BIT(11)
> > +#define IXR_FPGA_DONE_INTERNAL_SIGNAL        BIT(13)
> > +
> > +#define IXR_FPGA_CONFIG_STAT_OFFSET  7U
> >
> >  /**
> >   * struct zynqmp_fpga_priv - Private data structure @@ -77,8 +90,48
> > @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct
> fpga_manager *mgr)
> >       return FPGA_MGR_STATE_UNKNOWN;
> >  }
> >
> > +static ssize_t zynqmp_fpga_ops_status(struct fpga_manager *mgr, char
> > +*buf) {
> > +     unsigned int *kbuf, reg_val;
> > +     dma_addr_t dma_addr;
> > +     ssize_t len =3D 0;
> > +     int ret;
> > +
> > +     kbuf =3D dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
> > +                               &dma_addr, GFP_KERNEL);
> > +     if (!kbuf)
> > +             return -ENOMEM;
> > +
> > +     ret =3D zynqmp_pm_fpga_read(IXR_FPGA_CONFIG_STAT_OFFSET,
> dma_addr,
> > +                               PM_FPGA_READ_CONFIG_REG, &reg_val);
> > +     if (ret) {
> > +             len +=3D sprintf(buf + len, "firmware error\n");
> > +             goto free_dmabuf;
> > +     }
> > +
> > +     if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> > +             len +=3D sprintf(buf + len, "reconfig CRC error\n");
> > +     if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> > +             len +=3D sprintf(buf + len, "reconfig security error\n");
> > +     if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> > +             len +=3D sprintf(buf + len, "Device Initialization error\=
n");
> > +     if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> > +             len +=3D sprintf(buf + len, "Device internal signal error=
\n");
> > +     if (!(reg_val & IXR_FPGA_GST_CFG_B))
> > +             len +=3D sprintf(buf + len,
> > +                            "All I/Os are placed in High-Z state\n");
> > +     if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> > +             len +=3D sprintf(buf + len, "Device sequence error\n");
>=20
> Expressing multiple lines of data is discouraged, one value or an array o=
f
> values is OK. For more details, see Documentation/filesystems/sysfs.rst
>=20
Will fix.

Regards,
Navakishore.
