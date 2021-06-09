Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189C13A0A83
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 05:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhFIDNP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 23:13:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233316AbhFIDNP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 23:13:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1592Yljn166699;
        Tue, 8 Jun 2021 23:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XA2LuTKM6oytXDfyhlj9P6N1EyqEbVoRRxJ1vjn8jgc=;
 b=bLiCk1FtCU1F6m72Dk44bIJFumRDvGvlg2fqfyuWKdtHqeyisSOg0Ssi5jUy0EYvs60p
 p7bV5IHrSao073RmGCDxVCXX818TC6/xLLwqhefYKegxfikoO7UcSNfUcG18Cn1+aPRj
 UghMgSQQ/f9aXTIYUc2UNSl9ChjkW3VI+7+hVBBmUj+Pxa8dmJ8WoEJfnvjSwJMsGLw7
 ptC/ZuIHAImVOxRultXmhS1nBL3+KGVTfrU2+WmIYMJXxcF5iAmXWa/WsqJ4KzKMQTW/
 Ps34kkPPXz+8bJsSCYIkoZhz0+9SlQyjFSPxoaWmEtHdKedXYHrRi2yPsUNWJQAszQbh 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 392d7pkpsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 23:10:57 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1592ZWrv168759;
        Tue, 8 Jun 2021 23:10:57 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 392d7pkprx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 23:10:57 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1593AtHT020402;
        Wed, 9 Jun 2021 03:10:55 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3900w891e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 03:10:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1593ArdC25625026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 03:10:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01D3942042;
        Wed,  9 Jun 2021 03:10:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F1864203F;
        Wed,  9 Jun 2021 03:10:52 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 03:10:52 +0000 (GMT)
Received: from [9.206.155.145] (unknown [9.206.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 27FAB60134;
        Wed,  9 Jun 2021 13:10:44 +1000 (AEST)
Subject: Re: [PATCH 03/11] Documentation: ocxl.rst: change FPGA indirect
 article to an
To:     trix@redhat.com, mdf@kernel.org, robh+dt@kernel.org,
        hao.wu@intel.com, corbet@lwn.net, fbarrat@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20210608212350.3029742-1-trix@redhat.com>
 <20210608212350.3029742-5-trix@redhat.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <01f22915-0a72-1d16-7a42-a6e870ccaec2@linux.ibm.com>
Date:   Wed, 9 Jun 2021 13:10:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608212350.3029742-5-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rhKqRFJG-wMyLq05xrV-qvprdaqJmQuI
X-Proofpoint-GUID: nFu8dFCLDDKqockFlSmj80mifT7sH7nq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_01:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090001
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 9/6/21 7:23 am, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Change use of 'a fpga' to 'an fpga'
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
