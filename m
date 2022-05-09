Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B487A51FC5E
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiEIMPt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiEIMPr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 08:15:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542782B1A7;
        Mon,  9 May 2022 05:11:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249AQ35H024511;
        Mon, 9 May 2022 12:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=fk5Vp3QjBGhzSEZWr3LziM6mFWiNLKwatqEMTCKdCPk=;
 b=Uw7UlCi7K4IcPpMXexC1kmYc2jXO+e0idrELWIITSzScojWW4vm5B9SInJzuvN+I62ua
 Bv6JWIWeJb78Hn0B2T8dWd8RyCNwvJsECQ+sWiTT70haSPk9dCdnoxOVzpUca2kG+551
 QuCzrX8jBPXB9sxzMKpHyRkhX0vBjgA1U/QPeQNRRSpjvaFnCN2fbaXHVzSWuaCpLt+o
 2h3uQ4I2Ks2qqX+EoCFoNekhGvV1BsZDwQlssSGTHCAk9CXNalFoMRupw5v7H4vTfp+I
 ZWLd+6fO/J4l9DD/SrpTc/GrJZt09uOWCK93L+CRBZ5VjNZvGq3qGCdrThESuEmiW5tO jw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfj2b86w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 12:11:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249CBDo0040398;
        Mon, 9 May 2022 12:11:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf70v4fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 12:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt7LkSUMvww/a+n/M4X4CyW/nIoRV1UWVCmho3b6UV6/3LnvFuIXAduyJfmwCi1FR+clMQN2uFiK7479OIHAd0UKcqV7uaMNbUEA7cwN6YyC2t1G9NC7v2cY+uB1XlGluPYeiIudlEfrwj6NyI2WSSxbV630QneFhp9DSV2Ll/lQlYrnhnwCrVbtkrZcTVPlxoNCrnG2wgkkSEXwyciFdXT3wiM5297eX1EJLpAT2+FcyMI+6JJj/SK4wf8nCivT7kWCU7B2NtYPMG/xOjlExdQeuwSnXhdU6z28M3FoOaTOCkiAkbcujR5J2Htfd6WtbO5WptfWiv2z5DKmuopfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk5Vp3QjBGhzSEZWr3LziM6mFWiNLKwatqEMTCKdCPk=;
 b=TnptfPoaWrDn4qtNqnLh1qGoDoXEoeGpsaPNQsX9x5lrd4RG4HFNcKVMuSUAm6qyMaif5Fp+NTH2o2XgAzfQ7Ym93nNeMaVqt2BmSeusyexUQPoX4yz5L0pQ44gLw2Z/dVd2g4EmL5MwjBRubmErSseQuPw15o7ZEadBxqcxSnIrEaa5PR19ntHW6P/9s9EuTXXyfrD+fqgEvnky6U8hvtyjCYLwiYqGOL/i8sHT8LDsULcqfMzf4dcRySCF4L1cmKEDgS9p4YrMeSiuM2FyMzyPqgAnDROxD+FeWd3V1MMybiqUvcWL6SOZF6bGDhOfz8nSm12/jsNf7dpskMXUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fk5Vp3QjBGhzSEZWr3LziM6mFWiNLKwatqEMTCKdCPk=;
 b=Db38xJUo/+WzKO2AuepDRtQcZkrSpxIQTtKNWXKW6cuQ2P9PoztQBxLS3E0Jg7XnSt6nVI6gFk4UFubRKecodCW46wDw18sY0NO3WOpQnvu6iYRyqaIn7ON/Iob/nmwfJMYE0ijGUV26oSGYUo/XER9g0x570MWG9Rh96OkwWbQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5146.namprd10.prod.outlook.com
 (2603:10b6:610:c3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 12:11:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 12:11:41 +0000
Date:   Mon, 9 May 2022 15:11:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     Wu Hao <hao.wu@intel.com>, Michal Simek <michal.simek@xilinx.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <YnkE8AbimDa7sfN8@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0158.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d88336b-42a3-4cce-28b8-08da31b51388
X-MS-TrafficTypeDiagnostic: CH0PR10MB5146:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5146713AEEBB5097D07EB8E98EC69@CH0PR10MB5146.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNj+8bF9mCKiJMg8x11rXtGUwiwebH+L+LFOeseVzo/iK8F1/HUuartVCGop/HVfKaGjp4PtLKPqCMRFJ4biwikaWuu29jVkUhXNRbhln2iwb865+WAMMQwVq/QilQfXGwY+9XrMJABiBYm8MBBVK71GjYpPBZ72xnhv92PGVdD6zCy3mLnjT+rzyoX5pbI5xIr+yxIIuxs0Ulbv6PymQsqD07t8q4i5fScB8wK4m0U5EnKSh9IRX/qqyr/ZT6t1S9+8HGVFXyiokBtcouNCDznNiISAXktpMBS1JNADoVd8Vaaz1ITJdLyx3jH8l2k3/RRgyMQc8GV6L57oDc84JxG8ZU74OEscOsl97m4NeK8rSh9FtNndWfhK1qFfMMiIhjJlsCASqh4aGOTFKk2IpVX3yGVkGUIKH5TUrDNbh9PZ9ooEeOXDoIy1Ny+GL4rHNjeAM05anQvZJskLEG8f8RDtXzEc8XhXwGEbWlVDzzEv7MRiFd5Z7YHtq84jGkWUtpNufp+tpEuMzZzASOa5Lfyxx7zOpwnmkMdoVGA1CaeCiyQPWImOsDg+pl5S9MUj/dDkKx8gu8chzsUKE0JhQt5SiLISvsnRx+PbNCeV+JUfyTIZJFkBJDx+qn7TfgJLNkZuOefg5bwwdNAWKKd+myV5yMiLtyAyqxdWmAWgf4YTB8TXPU3D4WEul5scjuQWfBiLBldnMCDs62auJVu0uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(6512007)(26005)(6486002)(9686003)(52116002)(6506007)(186003)(6666004)(316002)(86362001)(2906002)(5660300002)(83380400001)(44832011)(33716001)(54906003)(8676002)(66476007)(66946007)(4326008)(66556008)(38100700002)(38350700002)(8936002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BBSJ/eWYqrT5f57f4vzGYcV9jPw1IypGBew7evKpaDFKcs71Ggv3AAfIFQiN?=
 =?us-ascii?Q?LAldSoZCR6zL1+yB/pQ3MRRNp/cL450QVW2dCQyJnQMfsaxvYsg3ra/h6L5x?=
 =?us-ascii?Q?plHOmNcsOdEI42FiEr5p7UYPugZlXet0mv51ihWeMFVQDiKbOpu5AWzXqA4g?=
 =?us-ascii?Q?b70A1pRS86wlVmLv9vxYjadhQwKcZ+/NniqUNfeayDCiaxizSZJ2lTTYqd10?=
 =?us-ascii?Q?VyLtYuRxhQE5AV/NsCU5/C2MoCM/qCsYiGDxdtvHRhkn8LEkvbjCsrUXAMbG?=
 =?us-ascii?Q?dJwBNMshhGohl+v/Vc5zzdudznsgQm9ufjGZKpJtxpoxBcOT8NS2iKqLGkMH?=
 =?us-ascii?Q?HVCAoZ9r271iibBhqSVjJpilEVREgX1N6V9wR75pAufKlRRG53O1xkqP9sKi?=
 =?us-ascii?Q?wEYoM+HBSsYObZxq26P1cJ9Ubn0cyFwarSptfwevJGg1w3TK7evnu1Q4bJDk?=
 =?us-ascii?Q?p/4qAmrgin8S5hHjtBx+IwP9qJPz3MvhL4Z5HK4KKcffNUNiU9a+CNrDMEoL?=
 =?us-ascii?Q?4Sscljer4QYpjLnIPUN0cX1gtShijA3uDGHu0+V9MSGXvehfbCAV9zIoEiHR?=
 =?us-ascii?Q?xEQtPG/kBbuuAXyYJVEyEST4CNmXSBfAMbGPgJ3kPCno8adNuorTHmcIemPx?=
 =?us-ascii?Q?wE5lqZeCKzaO7f8SfCYLwjuoYDZlZ7fMx/mP1JHrchqZPT8ZdRl2KsKSc6Xv?=
 =?us-ascii?Q?pLukayzwY4ttPPp2yz812me5pOP90CeWgHOZo1mRs3u7YmGA6Y+GcuzEp4da?=
 =?us-ascii?Q?nEJZOpP/wXqMQ9wZHQ24hIhguRM1pmvLGaA5ikXEOqdnAailVUBhMkeaF6ef?=
 =?us-ascii?Q?JD8FK42R5xmwkvGraVuSe7tBBoQqXY3kP6l2DpFfXn1rlNmNP97riCHSexXf?=
 =?us-ascii?Q?4OENz7sMCZHjJkPEjz5fqi8a4tMdxhlwxP7pIpfvG8R9PhoKWuWB1JJqMjR4?=
 =?us-ascii?Q?+vMPW6q6+LCX6oykiullMnq4sQWcc+K3DxKevdPmUdfEiJJfod1D27URlrEs?=
 =?us-ascii?Q?cHX9KNv4UOuotkrRY0kpUCsGeOjVKvtjGHFSm7f1RBkYJll/RBKiicQF5TIV?=
 =?us-ascii?Q?ewljPKUpgC4Uw2oC8hWiuPLeZX9JINqIl0D+WXwiSQaD0shCmpjeUIhkX3HZ?=
 =?us-ascii?Q?vFZ2EG35D80aElwTL5z7J1oS+yl2darHLhMMKNXgRR421pSxX3k9c+KHa4iT?=
 =?us-ascii?Q?Z/7T1u5HvBwCM+jjxQmkZdMDLrwaX8qmtqZdoBbH5U71KGUoofJVgz5sOSWc?=
 =?us-ascii?Q?D9OB5ai9960Zm1YQWf0JC98TyETM4i13uIOnFKBHBj1Z7mt1xJH/jyyxRIwu?=
 =?us-ascii?Q?Xk7gSIbkZ6BC3pr8rQrcCvwhIG0kSPBjkoWuOyf/7umMGOHslE11N+Z00rj5?=
 =?us-ascii?Q?NDY+fv0nappWdkiypwHnuI87F5bmzv7T6T2mJM6FjfhKazBd1icVZEUpMyzB?=
 =?us-ascii?Q?9//gve8qsSdSMWlkXH7sq19KKsJufQpiVN/Oh28Apwer45qQacK5IulCOt7A?=
 =?us-ascii?Q?sUnXryPG1rMZiwVfBBikjhOJ6Zuj/UUjVDqVURJxUkW9vDtGdCsE1+OEiOxv?=
 =?us-ascii?Q?P5rWqQ6KspNZ7791HGH/niNIiPs+0BBtUSOH6C7hsqYoRbAfmhlnbWo75882?=
 =?us-ascii?Q?g8/XdqedYMU9GhPsSglz076Dyckyv5M7HXCeLgcF8sqMCGLJp3/PvaEOUNwa?=
 =?us-ascii?Q?6FHrUCMfiA95wN+J86/MA8kZV3hlgYxZ50JwxRZYavsgx4nciaM3EjGifK8v?=
 =?us-ascii?Q?8vKyqoPojRHKTXdw/9KtDAABr6Rb/oU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d88336b-42a3-4cce-28b8-08da31b51388
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 12:11:41.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDaklhYGSWJVGttDM8iRWlXoeQ/5DGL+CgA+yua3tbz8XIzmrbQFeBO6O0Aw9P4twlTMPI8JmFFcknEfsYg7Kc2gUSDe2Nf1nnNHZnPWlxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5146
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_03:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090070
X-Proofpoint-ORIG-GUID: vA625ex8xzPCUGdT1hpDDXNt6uIoSIcp
X-Proofpoint-GUID: vA625ex8xzPCUGdT1hpDDXNt6uIoSIcp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The type needs to be u8.  The type was accidentally changed to char as
a cleanup.  Unfortunately, that meant that the zynq_fpga_has_sync()
function never returns true.  This bug was detected by Smatch and Clang:

drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync() warn: impossible condition '(buf[2] == 153) => ((-128)-127 == 153)'
drivers/fpga/zynq-fpga.c:246 zynq_fpga_has_sync() warn: impossible condition '(buf[3] == 170) => ((-128)-127 == 170)'

drivers/fpga/zynq-fpga.c:246:14: warning: result of comparison of
constant 170 with expression of type 'const char' is always false
[-Wtautological-constant-out-of-range-compare]
                       buf[3] == 0xaa)
                       ~~~~~~ ^  ~~~~
drivers/fpga/zynq-fpga.c:245:50: warning: result of comparison of
constant 153 with expression of type 'const char' is always false
[-Wtautological-constant-out-of-range-compare]
                   if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
                                                           ~~~~~~ ^  ~~~~

Fixes: ada14a023a64 ("fpga: zynq: Fix incorrect variable type")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The ada14a023a64 ("fpga: zynq: Fix incorrect variable type") patch went
through six of revisions.  The kbuild bug found this bug early on
but the author ingored kbuild-bot and kept resending the buggy patch
anyway.

After the patch was merged then I sent a separate bug report and Xu
Yilun asked about why only the author was on the CC list for the first
bug reports.  A valid question, definitely.  I will poke the kbuild
devs about this.

Hm...  Actually looking through the list there have been a bunch of bug
reports about this because both Smatch and Clang complain so kbuild
sends duplicate warnings for this type of bug.  And then kbuild
sends another to say "This issue is still remaining" warning.  And then
Xu Yilun sent an email "Kbuild-bot is still complaining.  Please don't
forget to fix this."  So that's at least four public emails about this
and one or two private emails directly from kbuild-bot to the author.

The kbuild-bot wanted to send *another* warning today, but I decided to
send a fix instead.

LOL.

 drivers/fpga/zynq-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 6beaba9dfe97..426aa34c6a0d 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
  * the correct byte order, and be dword aligned. The input is a Xilinx .bin
  * file with every 32 bit quantity swapped.
  */
-static bool zynq_fpga_has_sync(const char *buf, size_t count)
+static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
 {
 	for (; count >= 4; buf += 4, count -= 4)
 		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
-- 
2.35.1

