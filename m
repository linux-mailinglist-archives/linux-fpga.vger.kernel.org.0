Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B453E55F9
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Aug 2021 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhHJIxO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Aug 2021 04:53:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11854 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235220AbhHJIw5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Aug 2021 04:52:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A8pixF018547;
        Tue, 10 Aug 2021 08:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=YDkpjvDqkFdVQRrwt63Lvt+tgEtZGpQZez9V/Rh3dXs=;
 b=rAld+eGt6rmCncwCx78riifJsG1XnEwsmzAsmYRTjM7QdaViNQzuKmZKt2+2lNasITHo
 JwTAiD3Egsi5Sx7suZ14AvxajWFFV+eZrCsIAZcGf5A2mHkMQebfIerdAP1+4XNIBnqD
 2ekObPTOAFDviQ2CL3dZtopicpSpvc6BbDMhW4pptqguFACYsUBrzqXwp+FqcErw2IWx
 5YxdaxmJJj+eu4NAlNBB+3VbRE9Ugx0fZCcvE3PXw4sT6u3ZXymuA3JQQ/icu32EkY1Y
 d6Qwvp0eO0iHMkgMTtqJl+nA53Dqj3smSOapTOKkEX8mLU6j9P9dRfTgBET0RsS8gIu3 5A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=YDkpjvDqkFdVQRrwt63Lvt+tgEtZGpQZez9V/Rh3dXs=;
 b=ijgSgksiesX4woMJQ933snNBI36sKuJVYvJuzPXjo0jWC7P/RSsnfXf+PJ4kYm2WPD3x
 rI++F/DKobXIL8NnlrGrhvMMYD4jm07zAvwYb3xedXXDuOX0sZud3VgxwnVxb1AxKxcT
 dLmItXhltg1825IWOthjkxp602qPqJHXFUew/7FoQr35voK/02twcrAh8JSAI9vasx53
 eSD87RiAIWlqMTao1d1bLvaZdAnxTV0cuRc9jOHbRfoCMov209NoOdeOUlIoDBlLi2xw
 H6rUPuOMeZ8WohnAsfpf671kusl4RD9tuI3CJc80UEybiXj4ABg2MFQCX1shY/dAQHmR Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aav18kfsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 08:52:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A8o8N6165071;
        Tue, 10 Aug 2021 08:52:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3020.oracle.com with ESMTP id 3aa3xsqn6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 08:52:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP7+jvWZiB1AS1oPgu8CmX61XRBNOnz0ScJ8kMicx2+bL994aCyhAPNXhV4BKZpgwtAKqB12jxAwy0cRY91o8j50WOKw2HVg008JRU2rFv27RtUYnGUJip5i0y2cX84e8JyOgf3OsqDMfkn7GwHRH52wylyFswV1tgOao8xK/7uPrCk/so5enq8doGGDZgRxP1K0KWkZey3RNYBDWYCsIrGHwjS3QAZrlQthizbKH+vRdTuECx4FBthINzuF40RInMBK6nVW72RkbAYLNv2EWwdOxK86JRv7c8TyeFn/Xedy09+EJWRlcszi0LtSRT/skyoR0yzvCgoesnuOKY/Oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDkpjvDqkFdVQRrwt63Lvt+tgEtZGpQZez9V/Rh3dXs=;
 b=BxvplHS+ATsh4PLJlNFrnv/0P2BfXI6JSyzL2WOngDYSPX8UF+94O/pkrSZ/aKIRsHr5o0C7PyisCjR3Acshxzd+229YiNMDNBxjndO4BtE9PAYIGZ8Qiu4i4BBpxCaIII9ck6WnOzpoC4QLdQRVwhmWpzEWEczCVXeghspUWAJtOJLa/MX20++/FCKUvxeUVC2p40rFPyflxM86Pf8fKtzkmb5yWgYshg0OSQ2/4efE2ST7BTTol8tmM+iSFg0uMYt4XftfYvWZDvBq+edfk0fwoZXS/G+F8IFuyDt5Kj6t4PgnLy/DwQihVJID7cp0LN76406t8vt+ekbtbCnnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDkpjvDqkFdVQRrwt63Lvt+tgEtZGpQZez9V/Rh3dXs=;
 b=YkEcwMtGe3I/+OvIoiKLJ2bvm9MXxVN/DsnvufapmgVmTY1fdMK0xz9gNSLnzkaCDV9n9eEAAkUXqxZWn2fnQ+XGeatmlCEOqhh3vYgXp3OUDVSPqvgfiTeLtOr4AAth0/Gf4CyU3Ao4oP5LYu2UL+l/tBR401FQWyX2kKlEBFQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1886.namprd10.prod.outlook.com
 (2603:10b6:300:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Tue, 10 Aug
 2021 08:52:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 08:52:31 +0000
Date:   Tue, 10 Aug 2021 11:52:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     p.pisati@gmail.com
Cc:     linux-fpga@vger.kernel.org
Subject: [bug report] fpga: lattice machxo2: Add Lattice MachXO2 support
Message-ID: <20210810085219.GB23998@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 10 Aug 2021 08:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6866b534-5e1e-495d-7405-08d95bdc306f
X-MS-TrafficTypeDiagnostic: MWHPR10MB1886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB188685AC5FB83CF0A46325788EF79@MWHPR10MB1886.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdQZjGC+Cu/3iMMM/IfSU3bkYMv0eRt2BQ4dejTI0mwaH8wPJesGnxfxzh51tJmbyLSOGNIYyqKYkA3/TxrtXJ25YFg0tqtvxqKZRRQRIwMHf05IA3kTIa7g3LHnzb0idGsOJJ8/YtsT9v3LeHcGI6/XMFx9I9qzYd/aHE1ytoBznYfo4e7KCmogZErd2oimCKZdAxBvThJ85SAS7TkAtQV3cjDRO0TLBo9uIlLmiOjMw5orFvPqVymJh/9UuQbj0pyy/S5zp4JJ93Jp/kALFshXuXmFnVebo/BRkukVzzu68kaVR8780q6IZHiHY2DyPyl2aAY0YwcQ3k/pw8nq/JqlnHottpn+brDh/kvieRTHSIQEUV+Or6OokPt9Q+cAQQn5rZxkYw/B5UoWM24KTn3uVAwsO53qscWK1ntfENu/vJE8HmmXJmee6FvibvuEyqybw/i29x1ECeK/dx9Ua+DdlG2h68/qHC5C453qdCJRuFqd3dX+ryM93oivlVd9ZxPMdenbrPJ9D+6HEjYXWmo+1yEDh97pDbJSq9NyJoX5hp5mwqWSe+jPiUmfPVssI9B/pJo6+EkCdTckwVYK44JGE7XZlNxY8NvD/ZDGGV2E1KoowpO2yljnnmMujwjXmZwM+Bh2W+gPokCgERtYt2VF4WpzaFgiyCHe0YriSwXL1+Dy1gxLQHT35If8EZOxEOQsofwSsOaZSOsEkbP+aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(9686003)(55016002)(44832011)(86362001)(66946007)(83380400001)(9576002)(4326008)(8936002)(1076003)(316002)(8676002)(66556008)(33716001)(66476007)(52116002)(38350700002)(6666004)(26005)(186003)(6496006)(508600001)(956004)(5660300002)(6916009)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPMajfbkqTaPyDWnndcwOgVMxnvg03B1c+A6mUOC8erlxLkMgFLBVkvwt30u?=
 =?us-ascii?Q?Vh6szjy2iefiBGuNi35sBIIVasnSfA4Mhe2S9wpIiimJxhS/cT3whYn/EPel?=
 =?us-ascii?Q?a7l6jl7qbV4ka51CVoOuoKcXOdEJOC13EmLKNC55dOuSEC2Bw7xa5okvbe43?=
 =?us-ascii?Q?q8uofsn0X8A3fUQzmBd92t1RbvfZEmqnGDxsGk5pdCDraEjbavV+Ui1RwPCh?=
 =?us-ascii?Q?aWJjh+OiAK4x310QhbRBH6KfuXv3FB04P8Sgs9chCSdJFeP1U+RY4CXqIceY?=
 =?us-ascii?Q?E16Su5XMmZ63JvdBsfnrmaymmCUOx/kcqBxIvoQkb9rpxUdo766v2RCW5iR4?=
 =?us-ascii?Q?d7oVjlHYv704ymkZl/3Jwuu5Z8T4qpV3NFa0Tu4D6vBhEANxQEw0pQk+eI8l?=
 =?us-ascii?Q?TRFW25FrjMuq+4ysR741O4uhW3YDdbVBkr6pfTspwiuLVIPOAqhFLXk5LQIv?=
 =?us-ascii?Q?RBoq90VD/KQ17tABRgzmL629Owfz3+oYBICmktGiM4nY/kClcdNMv/C7/j11?=
 =?us-ascii?Q?cUHHNfY33UaRsdJU+ghA1XDSqrBJxGynRL6i34uRtZRsRDSUVQjjk3SU1/Dn?=
 =?us-ascii?Q?dl24nKBKjkI5e907DFRKP7V81WjHiEK4uTZp72dQl55wtA+dOexCAlsdqKgY?=
 =?us-ascii?Q?ReVPINmBOc0LIgWrcffmP+vZXv1EQnkIlMw/Zt4C/EpnTvvi2aHyyH+KI834?=
 =?us-ascii?Q?V9UiwnbdxlidH7kPVjSv32KMXBu99mcbbLqB9g3oWcfK9JONlkGWYJjgEAti?=
 =?us-ascii?Q?FQjZgESatOjosg+U9O06bCr7kmot0OaxcC+/uEmAkTXw7hts7/crcKRjdKKf?=
 =?us-ascii?Q?feDhaTq3ucK3dsxPHNr16bL4FI5MQ3zIHv56fqsd21Z9hnfwwSiFV+dwpfcv?=
 =?us-ascii?Q?UBxtOn3+qdI9U5wiPYd73lwz1qnh08lALuqeFQnZaMXKaaT6jY6hIcpt5aqE?=
 =?us-ascii?Q?b1q/LaaE+pLni1iz4ykbB0yXs4dSM4eeDQf2rfkQN1FPC9JT79NB09Y3v2TW?=
 =?us-ascii?Q?+YIZhX8I8sjIPEAl3E5WFmQ3alLHGs8AlzRaaxHJsDFIr9TIKxg/zM2xmQXr?=
 =?us-ascii?Q?6kE1ycJqIBPmfGvdjbNMQyeF50s4emLFKxGb16jvfs81AIUtNRMPEjjx5olH?=
 =?us-ascii?Q?5rQA4zZtZoMQn6il9GxULF4qJqfQ5HmbmyO7JWnsFHE4DTi/+q5AhUsAlrxI?=
 =?us-ascii?Q?/YZDMI7dYr3R6DlZVDNACRKivu48EWwJSaJVXTLe46AfdJngrZ0rEPGQz7Xz?=
 =?us-ascii?Q?T1EClZkn0Jt0BQOPHdmU4zjsXffD5Y65E8MNdyO+OyF2FGqWRRaoIkbtv5xS?=
 =?us-ascii?Q?Uc/SsQfiXK6fN0MoaIWIYAmV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6866b534-5e1e-495d-7405-08d95bdc306f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 08:52:31.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQTRMYYIUOD8Q5v8WEvLsZvqtCM0X2r0nsDKEd7GIZeUhta2enwHPOl09zxGgXcNDBfoDONZVge81XFuCNv8Enioz4iY921aD0k1hEgcgI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1886
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100055
X-Proofpoint-ORIG-GUID: nKBIauBVW4w2GlbPJLgOgno1_KXK9dqk
X-Proofpoint-GUID: nKBIauBVW4w2GlbPJLgOgno1_KXK9dqk
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Paolo Pisati,

The patch 88fb3a002330: "fpga: lattice machxo2: Add Lattice MachXO2
support" from Apr 16, 2018, leads to the following static checker
warning:

	drivers/fpga/machxo2-spi.c:229 machxo2_write_init()
	warn: missing error code 'ret'

	drivers/fpga/machxo2-spi.c:316 machxo2_write_complete()
	warn: missing error code 'ret'

drivers/fpga/machxo2-spi.c
    187 static int machxo2_write_init(struct fpga_manager *mgr,
    188 			      struct fpga_image_info *info,
    189 			      const char *buf, size_t count)
    190 {
    191 	struct spi_device *spi = mgr->priv;
    192 	struct spi_message msg;
    193 	struct spi_transfer tx[3];
    194 	static const u8 enable[] = ISC_ENABLE;
    195 	static const u8 erase[] = ISC_ERASE;
    196 	static const u8 initaddr[] = LSC_INITADDRESS;
    197 	unsigned long status;
    198 	int ret;
    199 
    200 	if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
    201 		dev_err(&mgr->dev,
    202 			"Partial reconfiguration is not supported\n");
    203 		return -ENOTSUPP;
    204 	}
    205 
    206 	get_status(spi, &status);
    207 	dump_status_reg(&status);
    208 	memset(tx, 0, sizeof(tx));
    209 	spi_message_init(&msg);
    210 	tx[0].tx_buf = &enable;
    211 	tx[0].len = sizeof(enable);
    212 	tx[0].delay.value = MACHXO2_LOW_DELAY_USEC;
    213 	tx[0].delay.unit = SPI_DELAY_UNIT_USECS;
    214 	spi_message_add_tail(&tx[0], &msg);
    215 
    216 	tx[1].tx_buf = &erase;
    217 	tx[1].len = sizeof(erase);
    218 	spi_message_add_tail(&tx[1], &msg);
    219 	ret = spi_sync(spi, &msg);
    220 	if (ret)
    221 		goto fail;
    222 
    223 	ret = wait_until_not_busy(spi);
    224 	if (ret)
    225 		goto fail;
    226 
    227 	get_status(spi, &status);
    228 	if (test_bit(FAIL, &status))
--> 229 		goto fail;

Set an error code here?  The other warning is similar.

    230 	dump_status_reg(&status);
    231 
    232 	spi_message_init(&msg);
    233 	tx[2].tx_buf = &initaddr;
    234 	tx[2].len = sizeof(initaddr);
    235 	spi_message_add_tail(&tx[2], &msg);
    236 	ret = spi_sync(spi, &msg);
    237 	if (ret)
    238 		goto fail;
    239 
    240 	get_status(spi, &status);
    241 	dump_status_reg(&status);
    242 
    243 	return 0;
    244 fail:
    245 	dev_err(&mgr->dev, "Error during FPGA init.\n");
    246 
    247 	return ret;
    248 }

regards,
dan carpenter
