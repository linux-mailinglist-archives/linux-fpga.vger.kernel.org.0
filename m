Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E1522E89
	for <lists+linux-fpga@lfdr.de>; Wed, 11 May 2022 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243841AbiEKIfk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 May 2022 04:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiEKIfH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 May 2022 04:35:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663BC106A5A;
        Wed, 11 May 2022 01:33:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B79NfI011683;
        Wed, 11 May 2022 08:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=BzFT7FxuMl76QM86EA927faGneSplC6kT0FHP9FqyZw=;
 b=Yl5TuEPHlXf8HWJbGHOokr596eiHh54JpsdRTQhNMKQ/K/RWdMwIH6W8NqHZ8jZj4o9C
 Obo9GCfmxUQ9DsvtMj11QIjbXl4J8gMXAWBRo/gUY9/DvdfgPf/sMXiuoVfQzbtuaI3M
 G7PiFEuZ8AgvhrqzUeF9aocMgwLGSonc1S71pJmXXbb3E4Q4edtHcNjB/ZwjixdyGrFc
 YX79kclfpGRmSY3K+7diWkCHLdJv9TG1WwxOxum4KW6evrjPfS6cUDXcxaGGyM1LNsxJ
 c2iXo2sXvvRjbmkwsbAtl23P178gPljSzoCsu1459BQNS75LywLCjDPibH1u3RL2ugg3 ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcss3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 08:33:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24B8Vf9W022624;
        Wed, 11 May 2022 08:33:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf742e82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 08:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpUqGc4SPEeuUiFFvlpKB/OiIjISIwLCm4ssEj8C6KHAkMtQkYS50p40j8XozbWoAABtO3sn6UZTnABDQRl4llfD7ka7ysTbdvc1wN2rowMPODz9zOb6+SzKt07FvkTszFNu9+ttrFNUjToDf4LBhslh43RtaxS5wQvROMJ68Ro1hX+aJJFj2c+BcXOJV/0WSkaSDRCR9z2rPN1DqdWc7kauMuY7u2ntzOFCA8xOlBN7XOCWHw9WwNI6RFv6ATrVZxXqww0ALPcsOX0OoHVF0FFdc/gPtXAQ7esFr3ZE2y99F/QESPqfJm7MxbW56KWG0vmnut7miXNABJbX8c+8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzFT7FxuMl76QM86EA927faGneSplC6kT0FHP9FqyZw=;
 b=ldpVmQFbkUNP73+ii16bRD5QMSNoA264m7fGKh8CZGDIaUX02k2EOczwopgMYJET7u0mvcgzI+j5zVIN7nfn4pdHQKeQ07h54GlFrX4mMXiiO51ggWMHXr/2K/Xys+gafYS+NL2ipRTfg4lr1Ximctq/V+KOhoG50fG4oYd7nFjNRYlkN0EuPdxfpTU0taMD4SLjmu2ytT/jDmYgokhtjBv7sJV4xqoSdkGZqPGiTR/xxlgfxH7uWrvVcPfONqTOBdAKm/pQI2JuLyDX/k8yY7uwAtVdjbKCrH6BMjYFml47kQx4LcoCPT8QvtqqS/MKqjxU9ThEUv+lhuiUlaLUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzFT7FxuMl76QM86EA927faGneSplC6kT0FHP9FqyZw=;
 b=mBGbqIFxuDElx+kCNKq/4n+5COahKssI1UDWRVm0sW4czIuCwTyla1IR01lE+TcyhULk9OzVQuQDf8PV47ycWe8m5gCnqpDUxI56ewTaEyJrZSfhxVQfLxACS0z/rt4txQdH0w/6sA+bOGtv284lFBlr2R5jkOb3aYSvtz0/BB4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2154.namprd10.prod.outlook.com
 (2603:10b6:4:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 08:33:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 08:33:40 +0000
Date:   Wed, 11 May 2022 11:33:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Wu Hao <hao.wu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
Message-ID: <20220511083329.GN4031@kadam>
References: <YnkE8AbimDa7sfN8@kili>
 <20220509170015.GC470015@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509170015.GC470015@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c4c214-20cc-4ece-8497-08da3328f345
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2154:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2154085C63937DED089295DD8EC89@DM5PR1001MB2154.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe813w2dakj6MaQDRSa4mSkjFak43KdO7vKtFc1g3L3CeW1UvTSZ+rnC7lDAHT0KyFbHZpYmnytdNmT/K/Id1K5ubt6arCR9BzAIRtM7otK+WTQYBX9d3S3xrFHWI+MGZBRXvJHpO8+Tr8DX59IzEDadlasYU6DkeziatWv8DNRYJMkWGHsiyfNlWVhqPkthUHlqIGSDsW6bS7/WUZ9AEfvGrNE0smmQWq7nfvRu2uAyIsrIeHL57UN5OHC7AvzQQxwbWbj46BWQ6D8VOG56cwX0N4Hd0NnNeV7SDAjXCD2hc3+3vKh1rA9HsCV+jIW7j2rms3qx9DpVC3CMWMK/iD5UWQXImrqorjkWXxXyQjZ9V0OmeSLFxw1SE54M9rrFQmaoMOgsPGrZRhWpyLKQ4kN1lEQ4Dm97kYOAScbIIJ3T1U1bDtwn4VL9nJdnBmQ1FT7sQaX6L5dbmTJxtfpTaoIm7ef1dc6tIcsZ7jFk+JtA8OrNXWkPH13NAbSh4eHA9dQzUYpbL1LKY4/vQw/Du2PagnIlSzjWerziB4bS8Iol9/Y2E6to1y5Jq/Ila7Tnuyt43NuaomXJLTuqCJKYbxqV4M0wpxqYPSYhnI1q0tflUjOBwVz2aiPzOAUR1YA9WA388WwKlHtZHXZDP9E/hgFzABJnxPK0hglBounOCvLlEmxCyXfyusU1F7bXSJot2EY6zLxBaHlL5Ax88UebuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(66946007)(316002)(8936002)(6916009)(4326008)(66556008)(8676002)(26005)(54906003)(33656002)(508600001)(186003)(1076003)(6506007)(6512007)(33716001)(6666004)(9686003)(86362001)(38350700002)(38100700002)(52116002)(2906002)(44832011)(5660300002)(4744005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XgnYFDIwE8jk41UnUzp9m5xnLnXl3QJkr9C/ilgJ2MYjbxzHHLRqa9ZaSdLG?=
 =?us-ascii?Q?rTTqo6UNv7WkTiiw1g7EEIKGhry8sW2jppJGul+zunPFLKDEl1MpxFyZRpbM?=
 =?us-ascii?Q?dhUd8yivBxnEc1Ju7kKY5CSejH3k/5m5yarl9kUtEMjz9S0eHoWexD8FCddh?=
 =?us-ascii?Q?k7x8LL8P05SEl/EJmWQYSBVCDO/54TE03xIwsDLBM3bLcvALpYm3exXNYEDc?=
 =?us-ascii?Q?pxVteNrJkdJYgSQ3t7+awOcNaZqZPuUmCwtHzJaBDuRkt39J3Acrve450GF3?=
 =?us-ascii?Q?oFJemveqGcKwneh7mP8olWwY+RLAxZOvnWll36dQa9wh4LxK2t1Dwlz0nJqM?=
 =?us-ascii?Q?dTr/10qsJc4+2W451IiIGWzA9Cq1kr0yss7QHLHq48xrEMCzdnzFvrokWssd?=
 =?us-ascii?Q?z9Lz5PPPb1tUxB4hTnsdoe4Ad/Ezq4a4HZxg7hdSj1qPKwXVlGx7NILdldQw?=
 =?us-ascii?Q?tfy2VzZoaz0PWMN3srLygS5td3yTvAqmzGqfecsqNMfJtAlcZ2mzHc2tsvfU?=
 =?us-ascii?Q?dmVHGmZi82L91hiy5y0My+H7zGuGmOPQlnLtOe9JHnxzothSF3lPvZbo4zxX?=
 =?us-ascii?Q?tbwun6xGGYPVo2yYE2zBsDj44GXr5C9LnPKrwFCy+gEgwm2PmS29RK8CDxGr?=
 =?us-ascii?Q?AXyYSZ+ObHC1D9zsJLJvby+3xE09wBFFIupQF/aYDmxwbwb0A5G98a5OKjDB?=
 =?us-ascii?Q?dkOWwsI7+P7K7ErGxvmvnrVZ0flFXVc9N9EtrIVoaJWZ5zDiFJJUMWINtXEz?=
 =?us-ascii?Q?W2yVg/48pK7axrxbEU3uzLMRFzTBa5GtmPgnpWQWz4nla3iBkVFgKVhJfxxZ?=
 =?us-ascii?Q?mmxNWG8aqhGRxWOrplEjoLknXauBRg2BMSVE3k7lQILKSC23cRzlpg9LbFJU?=
 =?us-ascii?Q?1VT1Z9JjRQ7t0HJ2XvRnonP9OGZzRPlRcTvA/UDHJsfAV5vimP9fdDvfIGg8?=
 =?us-ascii?Q?7BergftwwahOPI+ijWAioLnkOwQ2iCASYJc8n4Z5NX6jiTJd9HGf/i4qaG0/?=
 =?us-ascii?Q?5K22YJ66JKTITsCHg12iaHRAM351PIrXuV/WklGUI/f5nosPsb5oNXURptLN?=
 =?us-ascii?Q?UxH+4Hz8g+H/b+UfWH0AE99JzuKUmce+/Y/d4/UGn9OJzs5YFPKFYiyEMyZR?=
 =?us-ascii?Q?cpxl4LIlqakRma1Onk2XCc41TVX4Y1ShS8FjY4FgFRLC8ghb4SALc0KQBRmH?=
 =?us-ascii?Q?z8ZplA0LRRNM2wHL7k8F1Zf6FR0p+ELcwS7o/ltYI26WmLejehpcKxJ7S4T1?=
 =?us-ascii?Q?hXtgw5tTSGjhE1lK2d/wsy6L+GsnOBxTFDVThDDFcLDe9QB088NVnNt5Jie9?=
 =?us-ascii?Q?/OK1u0xjDXAPioalT8gRGXo5ENNyKzOGZpLaGPS2ePa6aV8vWrQ5Wa+RvNsM?=
 =?us-ascii?Q?68obhS+fmvTJd0buIjWSqrqdrApVfemH6Tgssp+Ql/o8dYF86hRW9nEjrsKs?=
 =?us-ascii?Q?SqmiAIeQA6k4EOe1O/TDhb909RUkRKWReTHzO2PYl1jOL1j5BtUWYq7Ut4ou?=
 =?us-ascii?Q?r817qucsQBBBl8og75PcCiUB6/ApfWx4FrGznv93AF4gpUPPmbYyseC5M+Ez?=
 =?us-ascii?Q?gOg7VVWDaZup7SEta6VLc8UU3zUydIrz/s+tBldyfQ/P7UdMF0k07tf77Nkg?=
 =?us-ascii?Q?e1SN803QsOuzZOVPKCnP8/qE64uwCvH7LfI/sesUdzmGPjryjXMq2HnC750m?=
 =?us-ascii?Q?KmV5vEjuDVhzn2JSCCG5OIHupKco12YQA7UJSlXjOC40ZXV7kedU7RmGGM9g?=
 =?us-ascii?Q?7/cTVwLOoBDn0CPAvwi/IqF0nZPFeww=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c4c214-20cc-4ece-8497-08da3328f345
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 08:33:40.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgiAPytDjTcmT05qi2XEBqw25dTBFzEZm5BKEHuZfByvJuEsoP2z3O6fK0X4hPYR5Jdpuj41Tg63RK67QbJhal3MdOk5STfbfOUFScL2+IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2154
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_02:2022-05-09,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=719 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110037
X-Proofpoint-GUID: t6kI_baRZRIo_W7zJTIDrBNS27JqkvPQ
X-Proofpoint-ORIG-GUID: t6kI_baRZRIo_W7zJTIDrBNS27JqkvPQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 10, 2022 at 01:00:15AM +0800, Xu Yilun wrote:
> 
> Hi Dan & Moritz:
> 
> Thanks for the patch. But it actually reverts Nava's patch. Since Nava's
> patch is not pushed to linux-next yet, could we just drop it from
> linux-fpga?

I don't know if you meant linux-next.  It's pushed to linux-next.  But
linux-next is rebased every day so reverting is fine as far as linux-next
goes.

regards,
dan carpenter

