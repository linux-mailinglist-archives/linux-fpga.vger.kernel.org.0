Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E894BF410
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Feb 2022 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiBVItb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Feb 2022 03:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVItb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Feb 2022 03:49:31 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC51592AA
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 00:49:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21M83nEn001441;
        Tue, 22 Feb 2022 08:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=FAlGbgMGsluNuD6xkRVKnJHEE2Gyt5EjooX8muXtK/8=;
 b=r5HO0OswAIweVR/5ZjlBeO9D2xMXlUOyBMoG85MEFn91aKNyQ31wNzjBfjKuQy4R0KLA
 1C57lB1dN3zg/xnUy6DmOrmzeKsT/ISKihf3hekzd/ggqYY9QwJ9UVEiJAir/OwK1UZh
 m/06a2SwoZdzWe/Ep1y2m4nZBmQ/PKRP56UTYQpgSjaYZ9umfrnaq7FKvk6Wl2VTFJie
 ZeCkgnbMfTGPe0ToCy+CL6+WmDgrILjnBGgefsvvtJy2vKF85Ef+62zKyIFbYRZOpK+p
 vIgfrDPcCD93H5lh66d+N3BqcvSnuYsRkdHd3y8P5vq4O/JoqYWgqEzAiadB2c/B6Ook nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx09h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 08:49:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21M8kopB044156;
        Tue, 22 Feb 2022 08:49:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3030.oracle.com with ESMTP id 3eapkfj7u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 08:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXLZ+LIgVk9H8L/QoQDOHFWnM/1CiFTovWo7y/FqRWXJd++KcaVf18SJVFN7g8YCCSuH3+bUC0NToUJd8IE/Gtm44mBmja2TuZAM7luy0STGbVfPeeIArUDC2EDTqJv8U34MnWbNmrFabUO8MfPk7I6wOk+QieHL3lk+CIDdmYdMBl8vJ+EmRGo8KOD1jvhdv062BsaaOMzPjezRWIZv7KFTaU+5dhZ5s6BzQD9T4HStvaAqhgo25xBrX3ybcVdonlRgFU9V2GrdGDgV7wXwfr1fTN/weP+wzI0Ap8zhBGuVRVR/GvAlGYMcaMRaIA1YtVljkcWppNIQqaHGAXlcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAlGbgMGsluNuD6xkRVKnJHEE2Gyt5EjooX8muXtK/8=;
 b=dCtwKhcRKAi1OhJJrOacyLOM0YWxYPwooyzirzIev+4tfxia6mkF/yVrEgUtV+/6wCHe7Cp3hC47YVJ+1MO5V7ofCyTI3T992QaeRm4DYMVnHboxnN1P7K9274PonGp3ZMTDkTwPPs8X+ak2UqyfrSITMn7hQdcnix7WIKexnHV0ane8lo9uDcmeUptbduvh9FTIbLgFV4oGgldikU4NA6PTwM4l7DTaIYvAGAliIm7nsTLZ9B1LwAcqytaHBBpJW1GWeM30jIuXpzOE7TpDmwXTUQQpznXZdt/5/CtGHvoB7vB8GTT6Z0L4ZBZxzO5EDpuTFichV8x5jkUQ3fqK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAlGbgMGsluNuD6xkRVKnJHEE2Gyt5EjooX8muXtK/8=;
 b=C+3jdeYFqGrlWlx6K7xK0avNYqZqy4Nt0jKjWFgpQLWOkPfkIAbV9pEX0XRfPLSm2RmZ9BrY4sljnGtrjK3QCHoCeiui+8jBj7tquJJFa3zXBNT+wiTZQgO/FmJRip+L+ihCslL2tQn/sOxsqz6yEekEcmyDya2evXcea/9z7VU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2244.namprd10.prod.outlook.com
 (2603:10b6:405:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 08:49:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:49:00 +0000
Date:   Tue, 22 Feb 2022 11:48:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org
Subject: [bug report] fpga: dfl: fme: align PR buffer size per PR datawidth
Message-ID: <20220222084851.GA14540@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0134.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f13331fe-7905-443e-2f7f-08d9f5e02b7c
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2244:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2244061AD5A75D27EDD24DE28E3B9@BN6PR1001MB2244.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87UxTnym1mZlth/s2z/Qo3AECAHBvgYpojtGwkHjMz6e0LyeFEYjA7/P4nNQBXT5Bt475PMCwHtcS/bIHuLcF+S6A2UOh7A7c90JEgeiDGmPqOo2kHbvX/facKR/rL6IBO3l3uTbl4hISLYp/FdA81Tlr1ooE0o92MkzH2NfUuYJpjt04sC+gWR6CspvIWn1xB4/xMF7xsa6Sh6Qz5ySmg41it7Xi2vAoTcR3rd+FBdacNE2ExwSKvWTH+ooUxXKslWe5livQxpoaS38MYIA8DsxQGvEg2bw6R+Z9obi0bwgUFlBL48aHW36kou7ShAwuC5TANy5Ftol1e7j2VW6wVtS4QDnAQgOD2C2WxgMxcS30moFUPirweEbvzcVB/kLZ1nMrLAh+NCG87InOYJXQIQAb2lomcAc2ngJILGHt3HLGxFY7NqT075oJVODmLZPr4WtFeJXatzOl5f1o2Hau0F5wqiO9w/gPkGEOFxw+wi/dQiVG5M2mZGAPBEdqTU7NVmSLuDPeirR341MRmI96SkP7FaPNOGjoUI3l6M9xSJyWkANLipv6Aun2nKmQ8/3hfXtawnptmImp3ZRLp6RW3BAlc9tor0x8Dbjjti3IYRwi8PJX/7pNicBbOJIlxH6uViDQnzRp/7loK8TCAOaeSxdiojrrnMqHD6ib+YfTphQjHISXQ5Irde6ZhTn44t3v71t6cqeScV5KbruuX4ruQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(33656002)(2906002)(6486002)(26005)(186003)(316002)(66946007)(1076003)(66556008)(38100700002)(66476007)(38350700002)(86362001)(5660300002)(9686003)(8676002)(6512007)(6916009)(52116002)(44832011)(4326008)(6666004)(6506007)(33716001)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAGo3GbmCR/LSoFU0adMH003BvA2L9lzmW0hTJFJn9Ftv/7XGbDXyw1wO9GW?=
 =?us-ascii?Q?iGDZNgxce5q1NQ8YdRpQIgtToDuIkut72LeVAUrq5RzB5ES/mvGZIydGLbd+?=
 =?us-ascii?Q?c9Y0J4E/ae9FzWov5Xtxc6DFiI9pG1eIQM7LTUl1aZi0XRviECSrQrYn6qku?=
 =?us-ascii?Q?EORokdMcF1FiZ+NEpUijey3pUc+zMGdtyaXlYFZ7ajuzugCkNJsEQkQYWZQo?=
 =?us-ascii?Q?KIFlkbnYeIEdnk/qpLCuawcXvWU55JhtUiuRn22MxixVLn6FBBhC2pECmBk0?=
 =?us-ascii?Q?aKukaGAzCqI46CEqw2/F4T6q9xwbaty1dxyrT0JXCRjwi9cLFBen7PHFzAKW?=
 =?us-ascii?Q?pta72rz6J7kA3R1pd7AAjxruBAG/ttYL0OJKYkuCHo7P8zQnOPt36zr0OGpG?=
 =?us-ascii?Q?MDmf/xREnprk200Rpiklv4bSbnm+A57nheO0aEOJ3+xLyOdxJ9RQTvPVMd17?=
 =?us-ascii?Q?HvlSsHaGoQT/v5c5qC1/S9d+nRl9TzYvOiqTW3PIox/s51Ox6zqZ/uGKawII?=
 =?us-ascii?Q?BXJm6NzrcG/4PGatASzGE+W2yu8R4gROMdJUe0c1ErbKXKgBO9TUZJhc4flP?=
 =?us-ascii?Q?NmyrOE/GBr7nzwif7wEvVqlhB/yzGijP1VzjGI6CXETzgLmCOvwMO9A7SMCe?=
 =?us-ascii?Q?fUbbaGdI6jpRFFi1Xf1RJ8lmtboKq9LPBSkWRrPC9srbJ4/cbDIqmqgnf9Do?=
 =?us-ascii?Q?w5kIIHjKBUOwyRJ/CvE9U4lilugfI4Q11mVtdrVAIhWWCZqzkAEGjcM7awJm?=
 =?us-ascii?Q?0nlP8tbXc9Z9OUPq0jpj+gee0SJ/ya1lVBFalSspzjjlFV6LqazADpMNWeXf?=
 =?us-ascii?Q?IbDJ1axvnxgJ7B6SNCxx6Abhy+3Pce3dzmj8hjm2EKinSsbiRf9AK67kIv3A?=
 =?us-ascii?Q?U4wp5vVagE9Jn996t5W0Ywuy0IP7NuTadpLTwFCDAzcxNgDgv9EUyD5TZh8x?=
 =?us-ascii?Q?5aDlq5tylzYdh2z/41UsyPbG74Hq2n+BqtujBpEPfgOCWLALK2fkKW9UhKKN?=
 =?us-ascii?Q?js53He0dj+xZHHtofvym4ZJM6orQgEpFMYcIctRGlhitJPEroiul1I0oK7iz?=
 =?us-ascii?Q?zmNsPyxzvDk7w9zD155ONI0MBZ1FD4Am6cu7P9SKqEonJGjIbhWJpBQITVgH?=
 =?us-ascii?Q?JoBrNYhMjYxgF7kl98y04F0HnPPFtJ6gGRVxN/ewQRojFyzcwSO6idPV7OM1?=
 =?us-ascii?Q?/9yag+Kv+d4MfhfCqWYvhw/7dVoUyzYLptoEKTPnLoxJHlk6ofBWd1kEPFc/?=
 =?us-ascii?Q?YWeP2EOkz00DyfCyfakubUMCuzvR2Urk5wNslOouBPhA9gTZxIGRSBlPgeip?=
 =?us-ascii?Q?JIi4DN8hnJ2PW8EpDZOJ9S6CktstDz2FevR6W2rYeeIQR/60aKmWeFPqXCB0?=
 =?us-ascii?Q?trefee5jr8w1gZ1IEo3PGUymx0Z3Miv1qAorke8aVSBqHy1h8FtrR0TrHxGE?=
 =?us-ascii?Q?1HJIqj14s96Lq8OU2IGpDoOwgUiFhoBFwaxYh0fzM/HqbCXoNMniZiKHOGIN?=
 =?us-ascii?Q?xITKNyNTnXEVH/zZy2WViE6EEH8sznsGV6ijmYXGHG5v/lP0CockZiQ4uSvx?=
 =?us-ascii?Q?glzzj2i98bHY/XsHBEHbB1frKD00GTIHGs0i9+bwl4lIsro8FQNL0BgCR7in?=
 =?us-ascii?Q?eBgW+F8bItK6X7YOLQUD9vH7g0B/lHXqTvFXl6x5eMwQ3LBnkO41Kc7mXKXG?=
 =?us-ascii?Q?zBkDBA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13331fe-7905-443e-2f7f-08d9f5e02b7c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:49:00.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WMoFaQpB6bPFWnx0fLU2mJZGEto8fWIcrLhHZsp4HfIjTQ9jIcxqdaGQkJ4e+zT5QaRu7e912Jq463141cOtbsiR5Hc7Djqx9y4AMj7MEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2244
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10265 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220050
X-Proofpoint-ORIG-GUID: qaxFVipXTzPiGqcyCVR7sFyp9jg2l24c
X-Proofpoint-GUID: qaxFVipXTzPiGqcyCVR7sFyp9jg2l24c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Wu Hao,

The patch 69416739ee36: "fpga: dfl: fme: align PR buffer size per PR
datawidth" from Jun 27, 2019, leads to the following Smatch static
checker warning:

	drivers/fpga/dfl-fme-pr.c:104 fme_pr()
	warn: potential integer overflow from user '((port_pr.buffer_size)) + (((4)) - 1)' [local copy]

drivers/fpga/dfl-fme-pr.c
    66 static int fme_pr(struct platform_device *pdev, unsigned long arg)
    67 {
    68         struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
    69         void __user *argp = (void __user *)arg;
    70         struct dfl_fpga_fme_port_pr port_pr;
    71         struct fpga_image_info *info;
    72         struct fpga_region *region;
    73         void __iomem *fme_hdr;
    74         struct dfl_fme *fme;
    75         unsigned long minsz;
    76         void *buf = NULL;
    77         size_t length;
    78         int ret = 0;
    79         u64 v;
    80 
    81         minsz = offsetofend(struct dfl_fpga_fme_port_pr, buffer_address);
    82 
    83         if (copy_from_user(&port_pr, argp, minsz))
    84                 return -EFAULT;
    85 
    86         if (port_pr.argsz < minsz || port_pr.flags)
    87                 return -EINVAL;
    88 
    89         /* get fme header region */
    90         fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
    91                                                FME_FEATURE_ID_HEADER);
    92 
    93         /* check port id */
    94         v = readq(fme_hdr + FME_HDR_CAP);
    95         if (port_pr.port_id >= FIELD_GET(FME_CAP_NUM_PORTS, v)) {
    96                 dev_dbg(&pdev->dev, "port number more than maximum\n");
    97                 return -EINVAL;
    98         }
    99 
    100         /*
    101          * align PR buffer per PR bandwidth, as HW ignores the extra padding
    102          * data automatically.
    103          */
--> 104         length = ALIGN(port_pr.buffer_size, 4);

The ALIGN() macro can wrap to zero if it's >= UINT_MAX - 3.

    105 
    106         buf = vmalloc(length);

It's sort of harmless-ish because vmalloc() will WARN_ON_ONCE() if you
pass it a zero and return NULL.  But we could try to prevent the stack
trace.

    107         if (!buf)
    108                 return -ENOMEM;
    109 
    110         if (copy_from_user(buf,
    111                            (void __user *)(unsigned long)port_pr.buffer_address,
    112                            port_pr.buffer_size)) {

This doesn't zero out the padding, so it might be flagged as an info
leak depending on who is reviewing.

    113                 ret = -EFAULT;
    114                 goto free_exit;
    115         }
    116 
    117         /* prepare fpga_image_info for PR */
    118         info = fpga_image_info_alloc(&pdev->dev);
    119         if (!info) {
    120                 ret = -ENOMEM;
    121                 goto free_exit;
    122         }
    123 
    124         info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
    125 
    126         mutex_lock(&pdata->lock);
    127         fme = dfl_fpga_pdata_get_private(pdata);
    128         /* fme device has been unregistered. */
    129         if (!fme) {
    130                 ret = -EINVAL;
    131                 goto unlock_exit;
    132         }
    133 
    134         region = dfl_fme_region_find(fme, port_pr.port_id);
    135         if (!region) {
    136                 ret = -EINVAL;
    137                 goto unlock_exit;
    138         }
    139 
    140         fpga_image_info_free(region->info);
    141 
    142         info->buf = buf;
    143         info->count = length;
    144         info->region_id = port_pr.port_id;
    145         region->info = info;
    146 
    147         ret = fpga_region_program_fpga(region);
    148 
    149         /*
    150          * it allows userspace to reset the PR region's logic by disabling and
    151          * reenabling the bridge to clear things out between acceleration runs.
    152          * so no need to hold the bridges after partial reconfiguration.
    153          */
    154         if (region->get_bridges)
    155                 fpga_bridges_put(&region->bridge_list);
    156 
    157         put_device(&region->dev);
    158 unlock_exit:
    159         mutex_unlock(&pdata->lock);
    160 free_exit:
    161         vfree(buf);
    162         return ret;
    163 }

regards,
dan carpenter
