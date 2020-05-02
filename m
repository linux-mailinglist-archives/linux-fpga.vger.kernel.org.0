Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C521C25A4
	for <lists+linux-fpga@lfdr.de>; Sat,  2 May 2020 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgEBN0W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 2 May 2020 09:26:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52364 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgEBN0V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 2 May 2020 09:26:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 042DP6WI041766;
        Sat, 2 May 2020 13:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ZZ8bfzNv3DAbWH7wZiRzKhCuWhVGiU4tF73LU5lVl1M=;
 b=fjxSnyXdlEWVki/DUdnfaLl4zHh+qNI1ovI32WfctclrxMRJbcHf/+vU880ETk04Tj/v
 pqdKX/a3GMrSLxt36YzAmOuV2UafaVc4dUAVUTsRD4jJkS7ebG1SFXP9ofrCELi0KFB/
 s+NIp2+Ih4ha0su6xGH6HOiwUmCXx5p6EbaHTARcau06LI8jqoNx3pORStjMIlKAPE//
 zWB3Kd+fKIqQHoS+xx7QVUG1k5by6PUIeoDJ3W0vsZeZrDMzLMsBNHQSomwHvAgYe3yd
 NUtQY0nhvztlqyLTUkwOOaK0/vPejRzj7hVOCNU7L8sZjpM79pbkgo47qYxEdYAd/xM4 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gmryv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 May 2020 13:26:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 042DMWDs045926;
        Sat, 2 May 2020 13:26:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30rxw9btp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 May 2020 13:26:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 042DQHV4011839;
        Sat, 2 May 2020 13:26:17 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 02 May 2020 06:24:24 -0700
Date:   Sat, 2 May 2020 16:24:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org
Subject: [bug report] fpga: dfl: fme: add performance reporting support
Message-ID: <20200502132419.GA41486@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=3 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005020120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9608 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=3 mlxscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005020120
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Wu Hao,

The patch 724142f8c42a: "fpga: dfl: fme: add performance reporting
support" from Apr 27, 2020, leads to the following static checker
warning:

	drivers/fpga/dfl-fme-perf.c:948 fme_perf_offline_cpu()
	error: potential NULL dereference 'priv'.

drivers/fpga/dfl-fme-perf.c
   941  static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
   942  {
   943          struct fme_perf_priv *priv;
   944          int target;
   945  
   946          priv = hlist_entry_safe(node, struct fme_perf_priv, node);
                                  ^^^^^
It doesn't make sense to use the _safe() version if we're not going to
check for NULL.

   947  
   948          if (cpu != priv->cpu)
   949                  return 0;
   950  
   951          target = cpumask_any_but(cpu_online_mask, cpu);
   952          if (target >= nr_cpu_ids)
   953                  return 0;
   954  
   955          priv->cpu = target;
   956          return 0;
   957  }

regards,
dan carpenter
