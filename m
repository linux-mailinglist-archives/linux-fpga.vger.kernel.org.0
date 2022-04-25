Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881150DEFC
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiDYLkG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 07:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiDYLkE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 07:40:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F992DE
        for <linux-fpga@vger.kernel.org>; Mon, 25 Apr 2022 04:36:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P9sMZT027770;
        Mon, 25 Apr 2022 11:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kGChNFLp8gELlkTbOyE6JJwU0IxJTBXWXQ+QsjVNzXw=;
 b=CCX5+i3BvN4UeNJ0NGCbhs/FnsAoBQHn0EQT4sPNtrzpzUZb028DB6/wnl+2Cjy/bYOp
 U2xhPax+4krYHb/93vlHh0IhTxz1JIg16GnCO28ngKbiTsOdvrLmPqxzFfjHvaIVDl/E
 wbaSNEITTc9DCedQVpHTRkKedmIU9wMWTg68QCCYT8OioZqRHgBo8fyXRA6xQfkWEiyM
 lkIy5BVrH37HxjD3hHDZBKKfQoObxp2eSCBfDc8BBjvdJ28a1zMZJaquPA5++5kc842M
 LlL1hSkBsSvO1SoynzJLfHtYIPCr6zXdet6Tp7+K3x2ITL9zZGwljk9aC1SDRtentVvV pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9ajw6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:36:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PBQ8DS007527;
        Mon, 25 Apr 2022 11:36:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w29rbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0CpYSH3uQ0JH3V1McXIoTYEEHfjLmzr/C4309neJvVuygGrv4NFCnUFWEwoKgTjmqeDPbw9dUbjF2zFKy/cTYpsw6LxKG/ElL2z3Xo1qbTo1RDUwbEDm2FSP9M+PCeWSkz6W/FjuwGZR15K5ePhACBCng+upmOiu2lAYQwVg1aBQkIkS+3y1rnOekMBbboMLhIuSDhGNTIJRdcoUgc3aCyLZF8Rjz5LTb3Ij3sB+LqI3PN6OCMEx5zx+kOeoI6Xvv7mR6rNUVjLqv/yR39p4DvbdT9WLmL7QFt3NMZ2CmgTRLa3KK7EMH35CLgVARa68LopjGoIIFj1C0LErtwJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGChNFLp8gELlkTbOyE6JJwU0IxJTBXWXQ+QsjVNzXw=;
 b=YMHO1A4wHo4JoRf2fnb/Di8dEg+v+aOJKj3gs5N5geLpZuRZp64Fy2FiMaDQeWEjMgoWvMk1y35JfXYihRNfrD/Dl1gkkybRd0rtMfsUe0vgGu/rDnrk2qT27m8UIG2LBVh4g/UxywzsHDT5Mpx9InCiGpq4qskBwZfMxYnfOcqnkXVXOvQOwdjdZJlrxioPU3S4E/XwbThLu4QV+0q/uEMzmWd5L+Ceh9BSQ/QxpotqvXG0qgS4n/SFzfhs908vQmnKFXcokrGNCOkEK0MoytY0WEWUiHGf2JkX3iiwmDzk5ccb7rn4j9YAnlTZZuw0YVoiREq/TwbB5jqOroLKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGChNFLp8gELlkTbOyE6JJwU0IxJTBXWXQ+QsjVNzXw=;
 b=xMuh3rJGi/IZlWBK2oSLIvZy7bkXqmNvhsIOJuWTrXvzZIXpuNwa8GMxhJY0JbdGw+6MNZP9lI48mttW1NUA60W5txjfY6JKWnIrOxveA+19jVc9ynogGMl9Bz2fhnLaq1ckEkPfdcc54q8O2H9WHG6STvzx5dGoWG3EWgBZ1Ak=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4964.namprd10.prod.outlook.com
 (2603:10b6:208:30c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:36:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 11:36:49 +0000
Date:   Mon, 25 Apr 2022 14:36:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     nava.manne@xilinx.com, Moritz Fischer <mdf@kernel.org>,
        lkp@intel.com
Cc:     linux-fpga@vger.kernel.org
Subject: [bug report] fpga: zynq: Fix incorrect variable type
Message-ID: <YmaHxydsy/Ff1awV@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 554e94ca-76c0-4246-7d8b-08da26afe29f
X-MS-TrafficTypeDiagnostic: BLAPR10MB4964:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4964B5F1A87349A9B107C2AB8EF89@BLAPR10MB4964.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pps1TA+kYrPhV9SI7eCA0wTO7iFlNvppv/FsHcZ31cX1M7mXwFsGJQ9RjHjFc5iw7uNjSSlbfMTQFuGJ4lEkSkVLZDKT97kcWJ28LqKZMjTY127WCqwS/dtQ5VcsSBdnoJgyOTBRemxVazhVewIFhno/JZ9wzJCGr7GxbtEo/fSJL85RlFB45Vnmjudc7zgj7d1kvSdXPgVDUAk6qHNyRYi3CHWhrFc7yLEXr0Z0LE3cstTLOq921lzpI5yM9Kp9y7XF1bQT3ThQBMSY567kRWPYFVs1qJauP4lC6yruO3Qk1U5FDl/cKaztEd528naLZWmzjn6z8CouQB6z4978z0KEOPHugPr662OGmKVzomhWnnmVhXayxI+2GzjiGZxyG2GMwqWQWzViT8jxNoRfpuRwW90LXmtg9vY7zwR52YjK8Z/EBzAeH5MoH+4AnhAfZ6FCt3/sDYkxYcdgKQu2mZgo0mTBCKFG5dH4gnUJOx+CdgoKeclW10WJCogBXdWfXbyMdWPhsayvH4BkvTbVjXX99GvkUbAIgAU7sv5GWbLLl/aXqgL/uZxbIukMiuTb3JKv6+S8gMYybrH4h3RE6zOhLB+hdbhNI7TWAoZDn0e4KDzMjcdBqvisuzF8RapSFCkqDDrNN04vnCuRHHpFkXkCgjz+dflAfspUM992/Yyi0QfLRAz3zQpTCVQ/jpubQtuaTiT632SY/T+L42fYNBtGsHmPO5dNXZ7QvWFDWImc3scN2xCcAaMQ69Nv08nF3SRbUdgGaNC9mIBoh6ths8Qfhcl9HDMAUvFfGppyXHAOBz9eJltSKJ6NOfMhgKlMnObah1DJnzl6nflJ+61L9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(83380400001)(38350700002)(38100700002)(86362001)(508600001)(5660300002)(8936002)(2906002)(44832011)(33716001)(6506007)(26005)(52116002)(66476007)(4326008)(9686003)(66556008)(8676002)(6512007)(66946007)(316002)(6666004)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySevl6XxAInJYXWdSMgmTV30UMHS3CXnSOaqiAppooDCu5ku4YE8u/0lz0x3?=
 =?us-ascii?Q?SU0N4R/+nQHYCOfKFR+vOFslssEkQ+oMRVYqlKCRWKk5Hmh44vdFXkvr4qxI?=
 =?us-ascii?Q?QKa0ha/6Fzc77iBaoYG24s4E8qXo6T6YkUdoaULPzjKT5CX2RA4uypSFOgXe?=
 =?us-ascii?Q?Rk2bPV3T9b4Y0bIUJZE0upA9iI49AcWit7To6SlPOeAu0o7OVTDjZeaD0AAD?=
 =?us-ascii?Q?uZPfh4hgw4JRv1NTX7F7AesK1swbuQSLRrcef8+RXfUl55mgAEN4CiBZqWQb?=
 =?us-ascii?Q?dvcbqaeiosbawP5aOTmo27/FQfM3wocy9AP8Hr0g4yvaH9xKP77Kac/lKQXi?=
 =?us-ascii?Q?BQwbB3UNE9buqWS84Ezt2i+gykJFWy+YbbSs1tGnbJvVMAeTDLDx1IQx1aMb?=
 =?us-ascii?Q?oe7GHw/s1gdpxaIiyaR7VLgWoFQFIdqLC4aUbnrEWNsopPES/8QE7TbB4BpE?=
 =?us-ascii?Q?+31iSsAqBli3p8YSC7js4gxkfqpZgTcYgFbHtfs+61Mx/0fs/w8VJM0luwkf?=
 =?us-ascii?Q?IeMqbGk+LJSvECAZxbRVj8JwQY86ZOyCDvtAIpmfE+VxK8wpCBSPHuERwqqN?=
 =?us-ascii?Q?DSSNJy5mhw4g0m+25Cs0CfDiOztGbWSH0FZwrZwekysi1T8ioc1lP2N6nZI1?=
 =?us-ascii?Q?kS9LrLpGJzvq0E6O8Iw0jGVnR286Et7fa+xr9/8LiZIeW5wLDh9gnYswzeo7?=
 =?us-ascii?Q?35Otk/eZyDXBAN4un/8+S0qcwkeBjKxb70TnpmY0K/8YFx+JNZN/Szyq5UdB?=
 =?us-ascii?Q?UhpzYZro2aiaSiuD7REPfcQvR5j9d5xJvbIoLdkbRb1gsa0jE31LHPykcDDA?=
 =?us-ascii?Q?2W0xADpOJ+5HuPhSQB6x4mJS7Q1bEUNEj/irdCJBo/tKmqklAdVl5hqjlFTS?=
 =?us-ascii?Q?VEJ4bcR/fKvNFXnK4z+wYOT9zQGfhwul7Gu2N0l1hU41YylSnpCuMTkmKoW3?=
 =?us-ascii?Q?i4+CRrpIpKLKpqILjJJ9Mua9h/DrsGE/xlGToryEEbDVAv3rMWFuNBzeYPRE?=
 =?us-ascii?Q?+vv0z1IFWzdv6cVtsORu3VGFjgAFjhqPUvBYM/T3hpvGVX7yBpfzlw+FPeMI?=
 =?us-ascii?Q?o0ouafXfGRLjg+9gIT1PGXYnmmVmGxOzQlu2840VhFnlFct+RNBu2+lLCh7Y?=
 =?us-ascii?Q?7MEMQ2w3VsnWeFsRLfcOaYzbwgwT5x8/VAYPUQirDmejaXA/Xm3HGD2YPZ/g?=
 =?us-ascii?Q?vzgC1I5p7QDKVvCxabqoMCe8p9LZ17IaqtYiJte7EPe/O0vUl/4vnUipdiy9?=
 =?us-ascii?Q?h1ayWtV24ENAQKoKu6atH7KN3XhT/C6uLovWvt+H0K/0G8G6xLdFDmbWmnOp?=
 =?us-ascii?Q?PZHcrmj5InqhIzd5JbJqKPozEDqrOKjnFvK/eLIQ5FrN/L25HnAXGvC+DCHH?=
 =?us-ascii?Q?P5/GSfFsejsoNc6qLqb2VdaDUGJnBzY5LmJWC5F5EVlvcFAncqheAqhOPsoS?=
 =?us-ascii?Q?yAHFHFbgXw+Iei0xMhnhO1/0K8QfVcxO7Iy68MyJ2siGgCQWyHZkyhqrwc9u?=
 =?us-ascii?Q?vn/0Oqpo+NcldmuH93jgey1pj1qqvp6HKTUxQdhxJ8xtsuASbTy5k0xwihJp?=
 =?us-ascii?Q?BcYUKzvluBbHmRQwgOYsuke04BQVuYQ37CcxkfN8Bh+hyqpQleSnXCiwMsyN?=
 =?us-ascii?Q?9DPu6jjPxWrMZXqFyDlKX8TH4ngxfZJKnd0btg5tpWiV/ECEHemTlNTOQ5Ih?=
 =?us-ascii?Q?bK3p6Vt7kfa1VIXZ9ETF60PkVePamR7Nqf868RXbWgiHiWeqdSLD2wiDZpdY?=
 =?us-ascii?Q?yMxpK3vrdhgG1U1ocaYjbgWk0RxGwUE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554e94ca-76c0-4246-7d8b-08da26afe29f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:36:49.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfJm337flbalvRL3yecDWgN7zctgsrz4UHKXyWusx9KFnPw0FV+flA8U83BY7xLo5UJm7n40ybR8Ml0DmjaKQ2uiEYoDSDtfpzDvYwmfb9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4964
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_05:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250051
X-Proofpoint-ORIG-GUID: uMVA_nfWG--i3xty8LrLa_rP6kfM9oAZ
X-Proofpoint-GUID: uMVA_nfWG--i3xty8LrLa_rP6kfM9oAZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Nava kishore Manne,

The patch ada14a023a64: "fpga: zynq: Fix incorrect variable type"
from Apr 21, 2022, leads to the following Smatch static checker
warning:

	drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync()
	warn: impossible condition '(buf[2] == 153) => ((-128)-127 == 153)'

drivers/fpga/zynq-fpga.c
    242 static bool zynq_fpga_has_sync(const char *buf, size_t count)
    243 {
    244         for (; count >= 4; buf += 4, count -= 4)
--> 245                 if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
                                                                ^^^^^^^^^^^^^^
The patch changed the u8 to char.

The kbuild bot sent an email about this bug on Apr 4 but only Nava was
on the CC and the warning was ignored.  This kind of a dangerous thing,
because I tend to only send warnings once.

https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/4RFIS5FM43D2U26PX7ZL44AFA5RYBWX2/

There is a process issue somewhere.  Why was the linux-fpga@vger.kernel.org
not CC'd on the original report?  Did you deliberately ask to be left
off automated bug reports?

    246                     buf[3] == 0xaa)
    247                         return true;
    248         return false;
    249 }

regards,
dan carpenter
