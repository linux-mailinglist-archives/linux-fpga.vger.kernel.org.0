Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A11522F30
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 11:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiEKJSK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbiEKJRj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 05:17:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C4986E2;
        Wed, 11 May 2022 02:17:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B7vE87023694;
        Wed, 11 May 2022 09:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=W1srcg2LoG2iAIMcH+hfXxz+AFFs+Yn7mBN/J6RzXxE=;
 b=dBKtO7J6wzcRv1MOOCRnwoHWCk08c6MTB4orqbPfCUk0g8yXSE1L+FyjteNepE9GK72a
 6j/nHKGX8GCVmYXnXs5jPFqQRii2VO5UFwYT0oW65igEohkfCHzbb77mcq4kketwCi2H
 gtdpB1qKb1/KHDjogDaL8NrsHyDcBNkR9y5Xvv5AcWhSLk0v75yU6VoIoPzmK0seNVMu
 SLoPncKXfvdWEg5tQdBdv+LR44mmN18m1ItA0A7AmJmmjMILAY7MM2zMtbzftBaUdl/g
 7vnWTgJshd+P5sE9GrOgCRiEzapZ6SUvnXV+UbCHVNAyfawTqDkCXYv/c7YlNfNOiHCl 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhath5ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:17:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B9GHDZ013654;
        Wed, 11 May 2022 09:17:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf743v2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 09:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isMxU7ELJF3AFAWYQmgdjzb4FiwJ2DZ3HlKMT7KEVnrUNioiqyRlx4fTmQjg8lBExi6x/jIm/fxFY4hy3qyd/dSlgZyEzAL0Ju8Dpo5a3ZcJRcE2sIBG9bgjdWWr6OZPLfOACYKiXP9q91+7FhehkRc6kPAvNtnTolnMxtyK9NTAx0IaZr/PZp/ZG4SUc0k/NTe1l3SSgUa+nGMxbQpwpG24nlX9nuf5mgFo9/XB6YoYeDrhBgrKV8WC3gIGl5aHS50nqbFZhi9UqPQji1SI9ZAP3ipTtj9YYSY6PlkpXjJvlmu71hqRCGikeo1oYtZXeH/mjwMiJe/INox5Ss7rIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1srcg2LoG2iAIMcH+hfXxz+AFFs+Yn7mBN/J6RzXxE=;
 b=hbhlQ9vrWevUTG07D+3bt3Fm1PQoxox/xmw8fFezf2uU1gbh7A1BTJPC9hUSxl/gnk7NDlLGIBtPlYuZlH5jzbRgEsCvp2300OifucAUfobHYAJE/MJ6aVhaQDWjrknQgkHcgp+jCuNiI40yM8iGPBLIqip+cA0pKq55uhC9pR6I9yr1e0WEPaoS2jUAyGGCX7Kdqz0vVMp8qF4p7gYAFWR3xhp5U4Z63b2+mL/VSMSyQdnL0O+Nh/cH3IvP346+lzxsQ9NTe2hClqdh27EyxNf6VZbqFHhaGBqf3jIvQNchu7UGXqfb8r3Ov4OWLnJkOFM8WdylsZNwP44fqgBc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1srcg2LoG2iAIMcH+hfXxz+AFFs+Yn7mBN/J6RzXxE=;
 b=O/uhORODDejSiclhZYoqYkGyt7hvn525DV9R0SFHtYA5bXIxm8/t0bONWxdEkByhgBhF1XHghA3RFAm7+chraffKhJtsPtLT2nKKdp6TEmSRdh/Q10YDBifVvt0ixooQuG5IYKjypnZjTl9M/qUkBXy71RfyUfq9eE3zbjDFXcE=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by SJ0PR10MB5520.namprd10.prod.outlook.com
 (2603:10b6:a03:3fe::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 09:17:28 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 09:17:28 +0000
Date:   Wed, 11 May 2022 12:17:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Wu Hao <hao.wu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <20220511091718.GQ4031@kadam>
References: <YnkE8AbimDa7sfN8@kili>
 <20220509170015.GC470015@yilunxu-OptiPlex-7050>
 <20220511083329.GN4031@kadam>
 <20220511084838.GA487393@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511084838.GA487393@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::36)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7697003c-0688-4aa0-e0f9-08da332f11d1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5520AB79DCF7C0A8083F33A28EC89@SJ0PR10MB5520.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sez2QyMvN/8xYvMjkF44xZHVC66/2HHLwpEXTOwOnjyArZ0Ph+rkRiH62WOu/UCjsP+LtLp3AmdR7Kw29R6Fe29KXRFsROml+Rv+x9O9Gu/XubqcRY8VN5RwgmYJBPyWYq/A7BQ7zUEARb4L7iNEpditWIy1ZbOQHa1kpQTOyxM6sRHXnhNJUa64uVMP37DAD272iaLbok+0Wyx5gDF23+T+Oe85ULs+foRHMO3i6dTSLeO/FC9SWeTUONqx9zJKhT5j67s8mBHow/oES8XhoqcuBusc8/2fsgE4XznDf5KW7NDgFsGILlS8UTPy2fEKc71IvjO4D9ZYdmUP+0uWy0Otj6QNcJ1qO0RB/vpEgEsD6ArJKJ3MHFX9JRqD3/f+5paXZ5FFtZFEOhBDJuJJ9jcCQsPDgRakC/nOvH8ribsOvIpQ9NbiTOu1XHq/xrIW/g1UtrxlioE8Ve4q0dI+7zYar1TW+JSk3tjl3hj6aehmtPZMpAGMVHdhxJ2ErEyvRMd0AYHBvFrcGSf0yfptU3MTi5yc6CVLN1xSENxXeyptE0uM04OyKGLg9kXqZ22JM9GYxa2JWVl4csgKPcA1YEGdPA4yn8tBgRcS3nC8eE+0NCTg+8TlTXEI8pVtJ2p+VeZGTrw9x1fVZUEQw5xKbO+h6/D/DRoEpNedjU1Jh0ye0Vt1WnelNQdHQpmJjWtg6iYqBt229sTiFJjrNFemDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(52116002)(6506007)(38350700002)(54906003)(6916009)(9686003)(5660300002)(6512007)(6666004)(26005)(8936002)(33716001)(186003)(2906002)(4744005)(44832011)(1076003)(508600001)(6486002)(33656002)(86362001)(4326008)(316002)(66946007)(8676002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4mHhVnbZOVecaY2Zu1UNQwYl6wlO1nfbF+vs+1+ZKJ/wS3Vwk1I3JnS+F1wK?=
 =?us-ascii?Q?eVKH0QpzI4J9cwStIFGI2/TizD7IIki5GYKPvuAQVmoXq3z9+BFeU6O6j4R4?=
 =?us-ascii?Q?95maTiWsmylz7Crq9wCJMlt6HKtVpvT24+9B5sZ74XYTSdd4+5OlhomBjH2X?=
 =?us-ascii?Q?lFrfXcl9Bm1aY4itPf7PCONVMVSe0bO+4v27haczYE5ICBLkZ93di50DYe/0?=
 =?us-ascii?Q?xQ+QEj3eKLWahzbf9Bhe8QmP8Tp1QNfmXm4pq8GRJaWoTA6+oPYID7GtlKL5?=
 =?us-ascii?Q?WYiOrF3xYjdtrc69pyVnvTYP4djX3qogyJ99RGcE1w7Fl8Ugr/wz2rfcqhj1?=
 =?us-ascii?Q?mnosFDj0Cn3l1B1DRFQ90gmvd33pjv8St3ZTsZEONT6M1t7oj/TFuB9zTwFi?=
 =?us-ascii?Q?canz4nXA9QCbhefsl1bgUXJaKmPt0nTGRrwoyJROayqyB8RNKjDT0PyRW4Y0?=
 =?us-ascii?Q?c76e/zSmbomx2FHLUGTieCI/ktbMUvvqn6T3EZu7TMLmL+FQV4vpzqYk/kFd?=
 =?us-ascii?Q?xkAPZcTxEVrp5AYEavPoZlFfPXCpEJIrV5cNeRG7Cv2A5AJ5q0f0plikRlom?=
 =?us-ascii?Q?vgjK6qsoArYgzs76k1XfwgbRiKmBUiCYw85qh5voJ0Tw+kt3b/pnm5wz0iTd?=
 =?us-ascii?Q?Ls1VsMFYEhN1MnCZHEGWPqgIU5qhboWV80KbaSBIoAi1oVmsil6EVdxXOJlr?=
 =?us-ascii?Q?jMeA7GJxnkF020GTs8kKIsQvqXNqBuQe07/mru/XOQjJO78Y+/APu0zXClTo?=
 =?us-ascii?Q?HvYMoTpAuBoy/Wj8N3SUQPoTy+JHkUtLOmxhbzVkf6lXf8r932/CTyXPGYvO?=
 =?us-ascii?Q?HWuQ/0M73fr88fKQSdMa3fTc8xEF79u0XzpjCxv6OJeySSlgIxJ07ADHjNKx?=
 =?us-ascii?Q?NxWYtb1XNqdLMMzgUT7PfZRGZmTl6JMgrMnLUzoauvLrxpv+l8SF95KCb+rX?=
 =?us-ascii?Q?D2e06i7QhkWtVfw8F2nsVARs+GzSfe3y8KZarqXvmM1irb7XWXm7D2dGlvkR?=
 =?us-ascii?Q?ZXNBwdZ2zCNLPcAWhZ8+KC/CQlVoEyCd15/eW7n/5vkaWQA9n1pnyfF9e1a6?=
 =?us-ascii?Q?hOWfgS5cPdbd43vf3JQHXQr6LeMhfkePmG/wj0ffyq0FW/u4JKEqS09KQaG2?=
 =?us-ascii?Q?ZKDESFTsq/QQaBWtu0F/oG++Cg0SAQ9RXZJxiOtx8QaKuLfL3azvBE80C/gG?=
 =?us-ascii?Q?Qr+phoZXdwRYaxzIGqhlVnuT89iAt+TgHMFb6UVjR+odINVRjJHMAHUf6NFy?=
 =?us-ascii?Q?Hh+tVxC0UGZMdqKdrCy1+YHxyECCtRus5ATDhyp9kNMIVmzjZyAWckQcibAZ?=
 =?us-ascii?Q?ZjD99Lffnhp3jtz+bOTL2ZTDZVH7dWzwOvZjU6TBl04j2aEgoBB3dF96YIPF?=
 =?us-ascii?Q?PRp3YwO/MJBkjvQBbnZ5BBFZBPvP8ESV0qNbytJwSM8rX8TF0o2jacFwOr5d?=
 =?us-ascii?Q?WgGDAegIQ+qhe1a5oS8FX1AJ2BVt2tjFZzwfFkrknSS7RRN67RZw2CF+4Bq/?=
 =?us-ascii?Q?CZGe18DI4AtNhk2f2XaRrIee5MdLJQKwgq9/96OYph1Nfw+RMvbsN63IDVdI?=
 =?us-ascii?Q?ojffT1CJ67pOXzMuzJBaO2E33mSAHWXNve+7Yu7CPm6spPUQE83yeonAxE9y?=
 =?us-ascii?Q?chYu1Wcphm1dNxzJeZzPX3cYMUnhn7uu6bUUm28Ouv0F5UxCYHtgt3UjOufS?=
 =?us-ascii?Q?JHbBDeuwjZoilX7R/KT/Sng4WkkNOfvubmd8n4sXCiW9hhZOID4ANrZSGnTW?=
 =?us-ascii?Q?9qnbhQ0m/WQM12SwB1BRIRhD+CndpnM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7697003c-0688-4aa0-e0f9-08da332f11d1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:17:28.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwQfL40NwOm+pn6wBx9fX8hUMS0lZnqttl3ia4VLd8JWukeA85K4wypO/T4Ui1ZSWofALHvARMG/EtmEExE+7YQiavrk4JsdhqAGaef9i6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5520
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=805 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110042
X-Proofpoint-GUID: ENJBZxZfdtpHolvdBBhtLaEMwfJyNrOi
X-Proofpoint-ORIG-GUID: ENJBZxZfdtpHolvdBBhtLaEMwfJyNrOi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 11, 2022 at 04:48:38PM +0800, Xu Yilun wrote:
> On Wed, May 11, 2022 at 11:33:29AM +0300, Dan Carpenter wrote:
> > On Tue, May 10, 2022 at 01:00:15AM +0800, Xu Yilun wrote:
> > > 
> > > Hi Dan & Moritz:
> > > 
> > > Thanks for the patch. But it actually reverts Nava's patch. Since Nava's
> > > patch is not pushed to linux-next yet, could we just drop it from
> > > linux-fpga?
> > 
> > I don't know if you meant linux-next.  It's pushed to linux-next.  But
> > linux-next is rebased every day so reverting is fine as far as linux-next
> > goes.
> 
> Thanks for the info. I was not aware of that and may mess up something.
> I force pushed the linux-fpga yesterday for this patchset, then linux-next
> would be conflict with linux-fpga, is it?
> 
> If it is the case, how could I remedy?

No.  Don't worry about linux-next.  Stephen rebuilds it from scratch
every day.  It's fine if you rebase.  There are quite a few trees which
rebase.

regards,
dan carpenter

