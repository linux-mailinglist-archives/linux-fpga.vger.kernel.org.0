Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49753E8341
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Aug 2021 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhHJSwH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Aug 2021 14:52:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16570 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhHJSwH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Aug 2021 14:52:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AIpeHT003587;
        Tue, 10 Aug 2021 18:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=W6zs8vQOy1nw0LdPOsl9iv6WhusdEAZHRgLNlkqkdE0=;
 b=Y+UO+gFqFg6PIDziu9aR6fZek0qQ2OW/N5wrGfDOsvYckp5quL6OMt+ip3Vc+ijPjXV1
 gKsC28Y54ijrQaFclzV4pk6NvzpsopLPnda0mRMdnK1KCFhbpdxSZwSMxXdiZxukbSvv
 jND3W2Jryl6xScKAYP4MDYtPiPzzH4liUx5ZE2r9b0LJqG8Qci1LXalm8Rmmex+DczqS
 WfjoJcu0Da4+Vqx1gqm/OL5UD5y20o5LxflqypniojVnG82J2JxaSO8/OPLDG3dMBjSh
 ff2siOMMc8zIQNHHf3f8UFc3VUFt6mmwlUxjiPokRf4SU4+cSTAxMeeSr+o05cYzVb7B oQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=W6zs8vQOy1nw0LdPOsl9iv6WhusdEAZHRgLNlkqkdE0=;
 b=dRlTzgR5z7sqDIyz4aCUhy6VtOzRSoWP/xa9WhmD8CLuvfkoQo0RjcjdN/rOtdARRJ0G
 rKZNjYhtrPp2ietw/G40wl+jRExGiBxzi9mMsXBn6euQmy7uqAIbPXB13lfyyIaG6Fi7
 WSXSpCYfMkkAJCs9puDxOeanxVActY0OjLV92vUxd/gPfqU3AfL6OVBR6t/ZXRT8Ve47
 rrvCh61VwRC5Vwy9mHU44CNPz1WEnUHsDenvnzWOHEFbWIpAKv4+BYr7ik77IYGkG43O
 X+4OdUuxKZp7JKXSBVmB4D5SCt4ABL0yCQ/BphGTwuiMsY1YRS5JJJbsYT2JwMzuT6v/ gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqgr78y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 18:51:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AIoN4W169022;
        Tue, 10 Aug 2021 18:51:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 3a9vv56khm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 18:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+m4b56CLdTM3Cxw2dzMmE5FUXsok5kK+mF/6J5BALNo6JieKW4ThBQdtL/T7Y4iZ/Ztr3ME9ebLSgrwR9V2bH36h++ASarbHjOo9/2DADsPkwuUS3s3/oUC3rlfIcIx6+wgpiTJYdi4VAD5Nrq3EQA+YqZ/6P/ZoCNpm0t/5GlMyzBxD/hECWouYTIUoT7PZxe3r9OWs3VX021gFbM8Swr02SeJS9gXZv027lRyIvKjEWX59r0JGbDfYzaYHAsMEIfXJshFWj4QpEJjaiXVQCPgj6uxeTUNfSSLnxjEPpnuX+2s9YNrOGz4DsOzHowr+jEQaYXyykuCmLcD9zZ2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6zs8vQOy1nw0LdPOsl9iv6WhusdEAZHRgLNlkqkdE0=;
 b=BpeXPuW/P9zTkK6snllKwX6s0HNkRTjwvwZDH3Salk6A7C1Bk8KhyqOOuiIydaKyrousmlatXFKyCo3XbxoblEt1ZpA2fjXJu7LSLdBmL6a7dhMN3mmrTWNU7fSitWEfrJNbMavYNliBbkVQZ3xiLNHzclISHzGuUyJbkULXTWs63JZQ24fDIvl1hOGSZyOjkpWvfwMyQ9X1jATK1a4/0uXigXCI//nKGnMNALXLiU+BUjvK8Im9LgZK/3Ok0RU3DajVDaT5UArUZK4e7HpiUweOJwEZVUceebMG1zvi1kx6hBGB03IX72hrfSRI7QO2t+hJEfEZYchD0KYgdJytoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6zs8vQOy1nw0LdPOsl9iv6WhusdEAZHRgLNlkqkdE0=;
 b=zGZ9xOIBkGF4gAvSunuJr7FVzI5yUc04qilQ9V8mVfD1o7rGuys/oV6HlCtY7VcmwqhmOPIuypgr4adNoJuYtzIf9YRacu1Cm2EHcPvz5omiNq2Icpj8/sGbK1fT/MesFeFjzuvBFbG6jQ46xXSLAgrNi6msCGqXGBeDmKTWq74=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4692.namprd10.prod.outlook.com
 (2603:10b6:303:99::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Tue, 10 Aug
 2021 18:51:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 18:51:34 +0000
Date:   Tue, 10 Aug 2021 21:51:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     trix@redhat.com, mdf@kernel.org, p.pisati@gmail.com,
        atull@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: machxo2-spi: return an error on failure
Message-ID: <20210810185116.GR22532@kadam>
References: <20210810164036.922830-1-trix@redhat.com>
 <YRKyAScLKow17mPO@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRKyAScLKow17mPO@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 18:51:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c3ee28-642b-49bb-d756-08d95c2fe001
X-MS-TrafficTypeDiagnostic: CO1PR10MB4692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB469289011A3F7CD068E84FD78EF79@CO1PR10MB4692.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgAskrgjRqrveJJaXjeKWBss6XmPco7Dji8ZAbKoFbK+etGVVNExWJuJBoo0rnpO5FN+pR2LiCqrYHb4XjAmOKSojIPEIPgkT5PnTe9P27J8TOOyRduaiTgFmFBHkyyYa5E4/MhdytvCm5+L89LKQNDzPvWLayyjlLFU6speIldmqoNY8f5RWflbhcV5CWrNROw+GLn5qMbw3IqIamc8+dZy6qDQxaC23IDHPFvY1t1F9kjwJqDJafN/RMu5Si7PCRMyZGsIZJl0XA9gx5GOF2tA+SQVL5wLm1ghZlAszdnNgO+vyIejsnuJ4wk4B2tHpuz96GfBtSOwVKOLH727IZJv227KtIG5cRE3mnCpWJ5Ho8BuKR3kx2soF7vneZU198PQ9VwOpF5wB525aag/1RrmVgAy19oXThpTKqy27Sch9VKDuPCi8WvaN2it/Q/G9Nx1/ycBVVMZrH31Rdm1TR1VN9OhIvyRJKSbwn3IoBlwISp2F7bd+i3A7yVe0KQv841418njcHamj48RfwxrHXMvDLzDvX5+nydHX0VN2rn2AVwb6ZejB38GFVR09nluMqQ0D8SsUKxc7IbD+RuhrzkeNq2RMOvOrWfSaw2T07QOjz9I3X8j4rrHUgIjqv1RDsb/v5lAwYf+jp/7b6hoHZ6bVGTpV7E1xpwG9ebivqq9csF86PYAAcjxPQk2NlDkoGf9JNGmn8RLzLzEAghOrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39860400002)(478600001)(26005)(186003)(6666004)(4744005)(956004)(5660300002)(38100700002)(52116002)(38350700002)(2906002)(1076003)(44832011)(4326008)(6916009)(6496006)(9576002)(9686003)(8676002)(8936002)(55016002)(66476007)(33656002)(33716001)(66946007)(86362001)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YoCtrw9TrvLqLy+Uox+Jg7QEaO5fiOQY1B3F4AIcM/+qLzsWea+TBt6AqlTS?=
 =?us-ascii?Q?UnwVQEF0wnV8lgQl0cZbAn7+ZK08KhPM8vRaSR5aM1KDNhQi3MRWj0OW4r2E?=
 =?us-ascii?Q?zrgX+/3PY7+wT6bQ9crCy2Y3EEl9nNbpfMwLM/FZJboKX1FbP0in6S+8amqN?=
 =?us-ascii?Q?AJ4I8ET4VeX++3p3JaRmrnueP8N+16H1VuDqf//o2qO+ryxSGFLs+c5h0B3U?=
 =?us-ascii?Q?RLe82H65QQYEQ2+cU1YfW+UbojhRfWuO9vfkINr+A774KLoiRYhCBbTkmIse?=
 =?us-ascii?Q?g9eWrmG+fumWE4kjAriibRAOy8k+uZ7Z7wYk73KjSSAm7BPtY36t99SBfws2?=
 =?us-ascii?Q?dfyM1r8BNw1BqOZLQR//Bz9QSMjYUzDdGWd/U5K2yAE64EyMt3a6z8xrKF25?=
 =?us-ascii?Q?i1d7crq2dZmECZ9IFe22PnOQ8QUiDDRXwAFiuLVTGtKP6D6eeqbiNVZlJSFN?=
 =?us-ascii?Q?dkAr/+9SO1zpjZC6u0Y9JmuHN+fYt2HRzfePr147bml/8reqzxs8UUALhHth?=
 =?us-ascii?Q?EBBBIWGBbwJ60TmcPKWzDCTKEnzspjC8mmV4V/K4boFG9vvRKzKX8VyBQz9K?=
 =?us-ascii?Q?XSfEAg5AOV7OPLXdYsHP/tW9yaYOhUBASVZEH657/61/mHeqehYJHnj+hFeL?=
 =?us-ascii?Q?Tf+72MpTRqgqqsJEVKvSKwa64pC2dRv3OOAasDLun9cCoWKiVSqXmVeSpGm9?=
 =?us-ascii?Q?35keifJrjCrWFnlRVDNy5+p+JiDeAGbmv9hd4xBao7HsjldBay4YjYw0MRH2?=
 =?us-ascii?Q?PFDi/QS7Z5YD7p72K1IsG7xgp526sZVtVgXuFf0wxSMg7P0He3453r50FaxC?=
 =?us-ascii?Q?VrsbrL9O/JRoyPsFxsopDxAbDptBpgOYomdNo+B+TmD9bHMgQLIg/Zwml8Wb?=
 =?us-ascii?Q?rc5ATe0XqN9EsZd6etY/QnuEC15izH5wQArpK4z/A4E45TRDJRRhN82BpR8X?=
 =?us-ascii?Q?0JrweYn01trUKpMOZIa/zoMdD9EroSouWo5gmJFghtJr2eMuiuoKsuuWCkKD?=
 =?us-ascii?Q?JEI6HbZ27rCB6p8fDKQ8MebzMUA3Xe1Tiwsk0mITJtpbA1NXJIArm8MfKwNw?=
 =?us-ascii?Q?jbTkwGoWx1WxgzG0TyRRzD+i71nBVeCerX6NgDY0PnlNRKze7kul7Ua41Ybn?=
 =?us-ascii?Q?OeDdd2ZmInIkfVq48UAH+irhM5rK+at9hgZsXi4/C6JrQmRNHzRhW5psF4Df?=
 =?us-ascii?Q?oYxSoAsoHjSICXif6R8oDrB9AdSOZa1EcAMl5DaPu254V3BdMXfN1BYsp8jc?=
 =?us-ascii?Q?Nc3LCeD6vI59SWX7Vg3zoW+uNZCBe8vPCPYS8SguJDlvIBMjEV4WUXwymyw+?=
 =?us-ascii?Q?6Btk2VKlsxoFUdi6R79Q4Jy6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c3ee28-642b-49bb-d756-08d95c2fe001
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 18:51:34.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbJeP1UgHfWq4ocXdP3of5/J0B4wsE8lovaWFPVL3zWA2zvtPDqkrMYTEg1Yjd6pzbDTFr3Qpv/UHj2mBwvBVNVK60IVU+AeukhMdI1Yn7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4692
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=920 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100124
X-Proofpoint-ORIG-GUID: bIDM6gP-FqduCLhMvfGAx1oYyMQ3kA_7
X-Proofpoint-GUID: bIDM6gP-FqduCLhMvfGAx1oYyMQ3kA_7
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 10, 2021 at 07:06:09PM +0200, Greg KH wrote:
> On Tue, Aug 10, 2021 at 09:40:36AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > Reported problem
> > 
> > 	drivers/fpga/machxo2-spi.c:229 machxo2_write_init()
> > 	warn: missing error code 'ret'
> > 
> > 	drivers/fpga/machxo2-spi.c:316 machxo2_write_complete()
> > 	warn: missing error code 'ret'
> 
> What reported this?  What does it mean?  Where was it reported?

These are Smatch errors, but my bug reports don't mention Smatch so
that's on me.  I've fixed my report templated to mention Smatch now.

regards,
dan carepenter


