Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EC25A8D42
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Sep 2022 07:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiIAFTI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Sep 2022 01:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIAFTH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Sep 2022 01:19:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B810908D;
        Wed, 31 Aug 2022 22:19:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VNnUks017482;
        Thu, 1 Sep 2022 05:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=UalFDQaPg/gQbPPhBdW+VsI/9LH4FsO/nBxfbKTpz6o=;
 b=Kmd3f8Vc5CEKDPZyWiMKD4QNS3EFetMxy7fqLWaVzhZJ+b6fIrRDqOXYWyyDyjZxBjsK
 WoawpXFZdYHSthHqOaZMOf+pWHjA1lna0wQzKrcV36GFKVrjAmPLxKRc4N+CtQScG19M
 CNCWiRPUCSelEbnIpguZ7wHWqO1YGzJxS0LSoiSI2CItngsbGmPo2Vfh8yU2xQQ4kVq3
 VZBJNn4QKqLgJ6zJY+nxKFio/UkWq9pF4SHkVZaG/tTSmW8SI699qIMWVfqRzuP6WqqH
 oUMrehOqdXS3TT6tgEspBGtkT1EjqXy1gwOCrbZ36RDDhUM7igAaPHgZtV/onO1Z3zr3 KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0u0f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:18:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2813US1x014531;
        Thu, 1 Sep 2022 05:18:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79qc40ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Sep 2022 05:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5Q5bA/tzMKHt0AJuMXqmt+E7dwYfuRRMppmM7U+lkF8fww48SaJYhNnWysSBXgnVDAGhN7/4+5woWAtZwCVQRcMqz7tMX6o7bke1G+Y+xzxqcounNR1qRpTN2FrNbxGeBLU/7J/0GjNk3VLeg+lG5nqMtdJK0pgdGXHiXPYGdH+VbHincicAcywaekrIR8be1VSMwCSeL5/0V+rNihB3tR33HkMcl5fzU4+pCthemGyDOcKoHkAuziLFErtNXCnz3qwPnbyIZRR3wRw1i3lOl+at81+Jmchm2f3qZYQgYmigepgC2FGI7ircspJ8wPiK4oCUDxf+tRR6iXuoc4Y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UalFDQaPg/gQbPPhBdW+VsI/9LH4FsO/nBxfbKTpz6o=;
 b=XqtNTL3l1GoncBS1nfqk3CrtGMBo485OIY/jy1SQ/IAgQlC8R8Ob1AF4aS/6MfLoVpIQtCz/HSRvkXabu+b6L6oEOfXPNulK8g01naG5yRpLTndtekNrbWGvdue2ADJnw7MQf9zT8pGdv0iPLIHtliQr+lzzpDrYD/CemzkQ8nkrt6j89lYCdan9hDfFEo0IfJiGRzXpuZJ7vAYkaa8GhwDkCxucmxK9rQXDFBKMEbtTBlJmSwePvt3qad6FMt/mzfPIKnQCnDpdaYnoFlxT+rJYtgICk3YfzCoBoYCGBRIB21vrZZbX/AFois/HElJNYiQ05Jv/TUcTKZLMBo/eEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UalFDQaPg/gQbPPhBdW+VsI/9LH4FsO/nBxfbKTpz6o=;
 b=evk/vLjRbyVkG8RWLtYUxQV2A6E1iQOBs1n5Pv4nIX3RmhbemgD823s9wIBKKM1VEAXnzUR0Kj4bvBQB55xlsJBxRAmEUohbN24rqwQbQmhpBiqzGmjVXt4aX/Hiwzlki7waKlKIU4dXvytMGJosF8LmgpKjLvpbnzqUUr+2FYY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB6559.namprd10.prod.outlook.com
 (2603:10b6:303:228::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 1 Sep
 2022 05:18:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 05:18:55 +0000
Date:   Thu, 1 Sep 2022 08:18:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Luwei Kang <luwei.kang@intel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fpga: prevent integer overflow in dfl_feature_ioctl_set_irq()
Message-ID: <YxBAtYCM38dM7yzI@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ffdf277-f6ca-40e3-69aa-08da8bd97769
X-MS-TrafficTypeDiagnostic: MW4PR10MB6559:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JichDvqftEk3yPdiuAxRFtfrhNtiwlImmTspCWSc8s9nF8e6LzW0OFqmRH0Grp6SVCbiyzG6a6W0Rann97nhw2FjTpqo9vftyy4YoxJzEkHj01rIdJQMsLWYPLS8+EUK6vVrsdAB8L21ibhoJeHzQItYVcmFqj3qebKIYcIqklN3UgFvQfzSQG61IZE4ebRPXwErVG+onyogSGdCE3znSS7V3m19uPQ5IwpI6WknLxX2tdcRWh704uC9+VFwnq3QHaBx7EnQsbVYRA70QzZE+4U5gFJhmMer3XDa+stWObPobWOZzgz3/ul1mHu9+8d7GnvUeQyQbHibeAtB0VaA6zLd3JBz55gmUyIQyo81FeTqSBdAfx6bCF/QC/UFWq/InuTllAkDBnuKdgzSaqNi3sifvqYAz49ocUEGhhrZbo4RnJdE79Q0mB9SPC1g1QImiQITZ+ZLmt+5SvjHee7akNMGsLyCiEhJY7sJRIqbFDm048RENo/I9XKwwjYjsdPxOCfxtBIN4yq7R5A+GAxQ6OHwF3jAP9FRilXKn+PBHoNSpfQE02nAdLw+nUkX9RYM+qPiINhFlogfqerPqVSC0uo/BvIw67ygdI4HNWkrrxqj8JEqugkOF4g0mBXZYNwE8mK/3YEK4RmUn/Q3uIomaMOaqPuvvZ2q92yJRjRKgVqCSIJ8e2naCbIOJGTGhYwLphJuAAVHDh+0GLg8YN4MeMmE4lRBiWDFLRd7Ak1vagxD2TbPwOPVmBP2hTCafBso5uq1YxUEyw3UpIIqJi/+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(396003)(376002)(39860400002)(136003)(8676002)(6486002)(41300700001)(33716001)(4326008)(478600001)(66946007)(66476007)(66556008)(2906002)(52116002)(83380400001)(5660300002)(6506007)(9686003)(26005)(6512007)(6666004)(4744005)(8936002)(44832011)(110136005)(316002)(86362001)(54906003)(38100700002)(38350700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kncjbpb7E3SDgEzKwj3MDc48Y6JAmnH+9ol0hMMZrA1p2Ygxw7hz1fPs9xA9?=
 =?us-ascii?Q?bd6di4Wj4e9E2z1nVc7RcHrF9vW+Q87j17i2sUfpDXnqDtIfzKYfXCi6+jy+?=
 =?us-ascii?Q?kkZ7bMRUtxEeGm4ApxyhaX5DOjPHeZfuXF/AbMTi+AodQQO2YLeCi3yEqZ9P?=
 =?us-ascii?Q?6aV5KH0HoSqOQPClOAj2S7w33Ic07oeFhMH/U1YsvF5q+JufeBkr0dktuL6i?=
 =?us-ascii?Q?n0rfer85fE5a9sTxKntXazWXM7STF/3YG+kEP0xPFE02nMFdiA4B1bjE331e?=
 =?us-ascii?Q?gLUxPzX63BewIhw4f/UZMcpiDxvrnP1AcKFbHfx6oKr5uXt/HA4axEhiH+l+?=
 =?us-ascii?Q?CPImHo/lLUFJYSYgT4grCJPcPIjVnB247xozTGNqawqpkjBx7qxJ2TPkz5jG?=
 =?us-ascii?Q?o856kNJypSdHQV8c3udl9YXD+t++IfEUhV1DHnhHLOfsTyUbnrU/MzSD1H/C?=
 =?us-ascii?Q?3zyTYhIy3YBtqIUTH4n1cNqIjcdGo2Q9kSABxNKsTzjjyaBGXNfAd2eKAXjd?=
 =?us-ascii?Q?GiLQNrTqV2kLlC48/oxhD5b6suzHDXU0DH2vaRsSG3UYMZOe/vocUdo7z6H3?=
 =?us-ascii?Q?1F4KrgFLWYZJI6J1NXDTMvcr8w6qOb+wW/7aCvb6EmnpmycW9SsmGj+ei5lT?=
 =?us-ascii?Q?qChBEdTn+it8c7v0RONLPqu4liEr4AonqPjYakBCIeMbtEr4/cVOmjk0ZGB5?=
 =?us-ascii?Q?9u3s9J2+OBPo9dQXt7Wo1stx++p5PK/hWkjWfndE63KEEeF3pVpQIX1th5e7?=
 =?us-ascii?Q?rjtO92ssMQkYQ5ntU1dfz4RHGbqnQJpXXyMQFuK7tQwzs3fuz0d3MxrYjt2f?=
 =?us-ascii?Q?Et9Ixd+icw8/qcYOExhabuhaoFNzK3Rn8Et4kkcug6NYlLEbpez6L2XyMq4s?=
 =?us-ascii?Q?clRoUtPUXUbYlCN7FZ/N1E9OcvbNsvxflwo1OKJ7bWf6paMdEVvKG1AET/ce?=
 =?us-ascii?Q?77Mlc9fP8y6ntrPkVviR5tgemtG3K9xhol2DGQw4PbUy87fB9S0GijatoOkV?=
 =?us-ascii?Q?yPBRCf169o0To/0cS9hF72Qaq9hjcwjOMlnMs6KxfjQ1GrGYkycGZbSW91bV?=
 =?us-ascii?Q?h/BebYmLcWEFQIOTuDmd80ywfZVGFucrLTYIH6mvwcFF6jXdg2i+aHPEG9Lh?=
 =?us-ascii?Q?4ChzS9968cw5lFwF6bynjRNItF+FX6c0aIMtJphkIGJfhkn8Pp6mA1txj+Er?=
 =?us-ascii?Q?dbGRlclnV2GwstkrJfSS+7jkFcpfgWMnLvXuf43qQG2R0CDjT9kTsbrNRLUt?=
 =?us-ascii?Q?vom68+JddsptGMxPem+E8eZH9ZpfH/RAfwbtyOFjeSv06kEmke6LES/8RAmI?=
 =?us-ascii?Q?C6h8Z81WmmzKKBrrBET+4LwD2CGBhctAcxv62ylEFUPoUUs+VSETxdq09vyb?=
 =?us-ascii?Q?so4SldGDBepK3yLdslIPnBwNJCAqz+nRwmCWq6zumxLR979jfK1sem21cB5q?=
 =?us-ascii?Q?ee+o3g/Idq5t05rtregwg5hFFFSUPnQG/+Z4fiHnsm7gEH4/NFycgKSnSQQs?=
 =?us-ascii?Q?1Drw0HtaCaD+80sfLsw3uGrzNWiqA02dZD8Y6L5Yko0L5jr/lr29tfbB5LbA?=
 =?us-ascii?Q?zrokcpd0LPrtmeIwCix8tJb9j7Yb2OZQsRbX+/jT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffdf277-f6ca-40e3-69aa-08da8bd97769
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:18:55.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOWmoL2E7gy5s88BCd377NWS5oUwrg72bdcfNJ2UFjfyogdrb/GJKYGbyU6dCQgSKpqVc67kOv4p3Ug7oT10GmQyJwueyPKCqjjq1HHR5Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010023
X-Proofpoint-GUID: 4D8-RMzC0HHD29EwRWnBbqfR26CiTvQR
X-Proofpoint-ORIG-GUID: 4D8-RMzC0HHD29EwRWnBbqfR26CiTvQR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The "hdr.count * sizeof(s32)" multiplication can overflow on 32 bit
systems leading to memory corruption.  Use array_size() to fix that.

Fixes: 322b598be4d9 ("fpga: dfl: introduce interrupt trigger setting API")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 5498bc337f8b..b9aae85ba930 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1866,7 +1866,7 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 		return -EINVAL;
 
 	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
-			  hdr.count * sizeof(s32));
+			  array_size(hdr.count, sizeof(s32)));
 	if (IS_ERR(fds))
 		return PTR_ERR(fds);
 
-- 
2.35.1

