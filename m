Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC7596D6F
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Aug 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiHQLQY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHQLQW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 07:16:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C717696F;
        Wed, 17 Aug 2022 04:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjHGTWcleOo4l5aql8JegaQUhCJ/Qt+KLMNAKRsGlZWD6cL8ae6oPEyOo+IJlgKmq427JMuKCoUH7BlFH0Yzdl6k/J9c9DWOjamGlldRKIHD43mj5mqapXA7UPlphIuVEDV1LYOvV67jpp+bsCLp3VunFHEnuipTfZYQB4aISAiKmpOhBCJPwmKYiCsi1pAVFRv/wPyNSPZLecw0jJJeh5vdxqVxwWY+aVAfo8EZED2XcyI/7iBs9M1W4c05UhXpvg9KVsRt2eagzlayv0G4Uaw5vPBRfgTfHeY3SFTZRmoNryWvEueIaXQd+ftSDLNwK008CfZm1twSoV1AI/+O5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LbNgjYrkxLU+9JCGrcDWkx+CCupQL+IpohLSwv0hYo=;
 b=dSRnA76IHRiJl8JgesF3z6r4Q9rkMXwF+H4PkMwbvEWivbb6ZIWcAs5fEmF8tEMKijE0XEiybFs29vGjpQGcJA3SDHXPxxlNWsmau8D7ZF+MVcj0RBmyJ8D6WvnhahOP7EDPt5vhkbgfhJtZ2iMK8AEw58Qrm3wWvSaWS8pE55YA73OQKqNjoq+9mfBRZeHL5H1TQKJc/mluc0ZwSWPVvDCl5dqxRrcOaFt3aOJa1k8pMXfOEY2XMN1QGCGkzRGSSEak+IDX06ZTMOXFh7XBx3nrTLTGFfqvec+tJkL80VtWRNAqmXc1sATQKHw5aOj+EZbFAz0mKhjZqqlVO/17XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LbNgjYrkxLU+9JCGrcDWkx+CCupQL+IpohLSwv0hYo=;
 b=qK+C1t07u7YjrThNNWE1KuvEYZgsw6k3sb2LD3/B7grBsEkWPKgHApoVoEfWohMw8b55yQrOY6q8By8+DRK5VfdHbam4LMZMK0YR1sddr9m7kTpruIPvbzunxwU+W778RJ+OwbclhhqQzdZiTG7luuIIXcxfOBtjdZQ+eDnvH90=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by MW2PR12MB2473.namprd12.prod.outlook.com (2603:10b6:907:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 17 Aug
 2022 11:16:14 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::bd8d:b963:62ed:65c5%7]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 11:16:14 +0000
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
Subject: RE: [PATCH v2 1/3] fpga: manager: change status api prototype, don't
 use older
Thread-Topic: [PATCH v2 1/3] fpga: manager: change status api prototype, don't
 use older
Thread-Index: AQHYhVFh0nFKgVNbE0Gr+XpBPxtCy61kiGwAgE66L9A=
Date:   Wed, 17 Aug 2022 11:16:14 +0000
Message-ID: <DM6PR12MB39934EC6FB92A46CEA8645E5CD6A9@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
 <20220621092833.1057408-2-nava.manne@xilinx.com>
 <20220628083158.GA2442728@yilunxu-OptiPlex-7050>
In-Reply-To: <20220628083158.GA2442728@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b04506c7-eba6-4024-cb80-08da8041e5ee
x-ms-traffictypediagnostic: MW2PR12MB2473:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DkGLXnr/WN2Y68N+2+82fWyIjYemGv0QDOhtkjH/VjuVTiQaFSQyE0NWCvoKYOBu5jc/YiGwrwagyyljEhNQ02iaYDK0mrymLSmehi/0gA3HY7snK1/orbViV0iJ++RtVZaSln2ruRsd1USrqetZZL/1QJZoPnNaBYuxKXBSOUjJblYWoeIso2tPLT2lLaj2ECHn8wXthWvFqw1LMj0GqJ5OLxn5yfZBaBWHnXBEuTNzzJrwH3OocCRwLxWOWauoqVJ9D7Dsl0GeqSGPKfjzY2R6tEdxUQlm+oPbEtzNd6jfsbFJINUTNLDPmz8xuD37+depJybjeSuZxm24Vsua36NAf7T2cw9YvfrxHK9GyN8OLm6olvo7tBL6Qsctk2ipKP2jCQ7Frok+wnGCIL4qmfp6RXkiGYWyFOuxwVG7FXxuSCW8GiXpIgsxXXQ0L3tnNLtHXAWG7QELnHc9uLwDAj5v59h9mIn+QoimnIrRT7K3QZV5qm4Sc/va/EZybjxx3dPZCNDDU5NkBnr/aTbbwXI3cZ7zdp0agu8uhsHDpimmC8cBa8gKFOjDf6Qm5JjHCQ7pi/Cfl8ys2A9URbj4dicKScCzX8h2cF4g2kXh0wYxS8cL6PrUJ9vvYE+IeJkxx1PK5QBWNLTVaNqokJGCmJlYrWhCRCzxaXGEg1y/1o7q0NIM5SS7+J8iKwA/QPSfVzCS8Y++2L/r2L/uZkGnkSusl+JVFUHhqOY4RMJrvLPOL2WNuh3+pwW6qnlQkxwkHYG2T9fHEP8dTcAVT3l6+lxYnukKWrvYgntKf8rx4/k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(122000001)(38070700005)(86362001)(38100700002)(8676002)(76116006)(64756008)(66476007)(66946007)(66556008)(66446008)(110136005)(54906003)(316002)(4326008)(2906002)(5660300002)(8936002)(52536014)(186003)(53546011)(9686003)(83380400001)(107886003)(7696005)(55016003)(478600001)(71200400001)(6506007)(26005)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DwoyFhS5lvFrQ9XBxfd6o8kplCRqHmGUxmVsDvLn8FuudKe4DK5MM61R3Iea?=
 =?us-ascii?Q?EIKuDEDoRfwmYFGmIfGzVA09CxOS5bGSjpUSHVGBxUuFWD6/jb0T6hE/YurC?=
 =?us-ascii?Q?eIz6Zr4fd7oVLEjEsbuwe1z01aGnOxFFDUBxSyUaT8O7Pkxq12KUQ1+nOW8N?=
 =?us-ascii?Q?duaFgVgcZDOefxrFypMNe23clDTcIegv8wfMx+Iwet1AKbx+B4ZazvW222lo?=
 =?us-ascii?Q?tyKEOY4shJCs+be4O+AYtD8EjzjlqgWbpkqNFV7F7nhN5PEbLJcGYraBg90o?=
 =?us-ascii?Q?a2KjTTb88d82XvB7dZ/x1UCAA1Hwss79JhAf2X9sxdG4kuFJpFqxLMsNO6YZ?=
 =?us-ascii?Q?gms4n3nwUgYQ6Lh/D6U/zKO/BaPtprczs5bLr3X16DLR1qDbFRz3GbqZXDMX?=
 =?us-ascii?Q?AStKmpUI+ZmxJ/0o/f64GlG3iL+fIpBM298y2fhNz2Pqui1R8LKM52qu5DkA?=
 =?us-ascii?Q?C65s2KQpwOQUHvhNSpSIi6rlcHl7OnYBGkpkZqiGrMMZqq0AEh6MVPpxC3Rs?=
 =?us-ascii?Q?akJPZipIXJYsBx4uzLHRKhvuabV59bIIT+5PsYITRSXq2LM8PM+LScM/HKNZ?=
 =?us-ascii?Q?dOPBTY/DLoSNIdiTxxBNCpkttd4EFI615cZ98hz6oMjm29kxazQlzFGFnNZ1?=
 =?us-ascii?Q?wtS++AgUaLrtIwK0lurW/AQ12nYorh20uywQ1/76vLz7HdRqW+bNTYMYJufl?=
 =?us-ascii?Q?e41UhhKyqpkVvL+oFpr5AyYudRLeDjR1MSaWejRbGCycxhn//vmGMo/Jc81h?=
 =?us-ascii?Q?hH3EKBFcYFwwPYnikm7MkSYG3/dD18O0FbOnHB6qd8n7InA+/d+OuFgOAiXN?=
 =?us-ascii?Q?9a44TakJ7asfNVyoZS5iTpk/sg/01/fJ4sOSsbGwdLONszxMAGmRRhkEQXT3?=
 =?us-ascii?Q?chaaiipdlnfiKkr3a8jcPHWIbD+fOEacxx7Mk5ZdRdD2NRDVlKn4WrMV3n1D?=
 =?us-ascii?Q?RbQgeBOgVyMW6lGREkGqV2PZKyB8k+OSksTgaIPAawkeKo7pMahPRgd3OVIO?=
 =?us-ascii?Q?90SPTPPRshMlL0YDAFolV4LAmlaRxRERQbnHWZw/LuLKIDGICFKK68/AooxW?=
 =?us-ascii?Q?iK7CgTxd5zn6xYmjNTUzF2pP3C+YmtSuSrPjHPrF0zirqFNLFoBdMFPEtQ+P?=
 =?us-ascii?Q?7Z5jziqLdFkwGANryqXwKQ2XZB6FUSS4NddVFtCGD2Aw2r29ZUk5Ut5Dufh1?=
 =?us-ascii?Q?SZtqWcTxfcM4BEhshLYEsDJEQJfnMivwoiUAfVL+WvRWqzY4/u0gtGvSIztp?=
 =?us-ascii?Q?7Y1CRoeHNFIwh+yzJ+02mXHFf6/lmMvXpX5Hgk6xnLSo6DgHX74G70hbCNYt?=
 =?us-ascii?Q?mcsSbnk/QfNrdXfLep5jDsgRhfGM7FWPLoFFtvE/R3HY0d2NsxAOCffiFLl2?=
 =?us-ascii?Q?IQUVSc3OhpqQIIMGkMu9ZB5jbyOVo+ptH23e4lPhbbM2XYAWH1Ct0zvwX15u?=
 =?us-ascii?Q?EoTEcXfvkoUhqdO9z6bs9z2kgSUUsPEAzK+pqnaivj+mTEQZImmHLGAahvoS?=
 =?us-ascii?Q?72c9V19llCGkjb+ny5KgXaBTjGBEgUftfuLXp3qYabr3nUhgvDQQdmCchJ59?=
 =?us-ascii?Q?2KIEU1yDCVEhdoFXDYA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04506c7-eba6-4024-cb80-08da8041e5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 11:16:14.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AizRJqusJc/bnpHDFGmq5F1g4BcMhuWY3RykjyoQwwK1kgQTesferCLB3xxO04DS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2473
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
> Sent: Tuesday, June 28, 2022 2:02 PM
> To: Nava kishore Manne <nava.manne@xilinx.com>
> Cc: michal.simek@xilinx.com; hao.wu@intel.com; trix@redhat.com;
> mdf@kernel.org; gregkh@linuxfoundation.org; ronak.jain@xilinx.com;
> rajan.vaja@xilinx.com; abhyuday.godhasara@xilinx.com;
> piyush.mehta@xilinx.com; harsha.harsha@xilinx.com;
> lakshmi.sai.krishna.potthuri@xilinx.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> fpga@vger.kernel.org; git@xilinx.com
> Subject: Re: [PATCH v2 1/3] fpga: manager: change status api prototype,
> don't use older
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On Tue, Jun 21, 2022 at 02:58:31PM +0530, Nava kishore Manne wrote:
> > Different vendors have different error sets defined by Hardware.
> > If we always define the new bits when we cannot find an exact 1:1
> > mapping in the core the 64 bits would soon be used out. Also, it's
> > hard to understand the mixture of different error sets.
> >
> > To address these issues updated the status interface to handle the
> > vendor-specific messages in a generic way. With the updated status
> > interface the vendor-specific driver files can independently handle
> > the error messages.
>=20
> I think we don't have to provide the vendor specific HW errors in a gener=
ic
> way, maybe the vendor specific drivers could handle them by its own devic=
e
> attributes.
>=20
> Since the output value set of the interface is specific to each driver, u=
sers
> should still interpret them in specific manners. So doesn't see much valu=
e for
> a class interface.
>

Agree,  vendor specific drivers could handle them by its own device attribu=
tes.
If it is the case, can we remove the existing status interface relevant cha=
nges from the core?

Regards,
Navakishore
