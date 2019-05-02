Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C920011428
	for <lists+linux-fpga@lfdr.de>; Thu,  2 May 2019 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfEBHb6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 May 2019 03:31:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfEBHb5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 May 2019 03:31:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x427ONta097605;
        Thu, 2 May 2019 07:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=soMW2cB/iychtsnTHc4Ua9jzrG/NqqJFczKuqm12hjc=;
 b=NJHE5HC0HoW7U7BwHhqDMKGhEKhiuD35dtqAyslZMaQ66JVTpVMiHNmgbtdtkZroZdLq
 LPg4/G93olsbpCpPHnifg0TWkX854u8Na15kLBXseNTrBIpejxDhl+LFTf4tC9qmf8I0
 70Nr06qx0PqSQToFShyfo/O1aYDEZFieoLJAdTxMB1kxnamykOetTJ+Gc88lMTdbJB2X
 qE7pjjxbaS4wMNRhiNBZYqSRy+UDeQhsjOCdV1vGVARa/yj5dwQ+tBwl6zfrwzc5nrPt
 YO5k9hgm8K5hNSFdg59O5sNEfxwgmlOgai86UETDisnCzgmyFigi4/kyWMjAmXjOTjbv 8Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s6xhyeqeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 07:31:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x427VmqM019879;
        Thu, 2 May 2019 07:31:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2s7p89m8g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 07:31:56 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x427VsO6015705;
        Thu, 2 May 2019 07:31:55 GMT
Received: from mwanda (/196.97.155.240)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 May 2019 00:31:54 -0700
Date:   Thu, 2 May 2019 10:31:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     nava.manne@xilinx.com
Cc:     linux-fpga@vger.kernel.org
Subject: [bug report] fpga manager: Adding FPGA Manager support for Xilinx
 zynqmp
Message-ID: <20190502073143.GA18363@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=467
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020058
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9244 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=491 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020058
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Nava kishore Manne,

The patch c09f7471127e: "fpga manager: Adding FPGA Manager support
for Xilinx zynqmp" from Apr 15, 2019, leads to the following static
checker warning:

	drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
	error: 'eemi_ops' dereferencing possible ERR_PTR()

drivers/fpga/zynqmp-fpga.c
    40  static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
    41                                   const char *buf, size_t size)
    42  {
    43          const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
    44          struct zynqmp_fpga_priv *priv;
    45          dma_addr_t dma_addr;
    46          u32 eemi_flags = 0;
    47          char *kbuf;
    48          int ret;
    49  
    50          if (!eemi_ops || !eemi_ops->fpga_load)
                     ^^^^^^^^
This is an error pointer.  Possibly you want to handle EPROBE_DEFER in
a special way?

    51                  return -ENXIO;
    52  

See also:

drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state() error: 'eemi_ops' dereferencing possible ERR_PTR()

regards,
dan carpenter
