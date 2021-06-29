Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EB13B6E93
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 09:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhF2HRM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 03:17:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232161AbhF2HRL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 03:17:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T74NPL073907;
        Tue, 29 Jun 2021 03:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L9v3RQH1zHpxAGFlETHpjFWqzbungmt0EpYWdvvBKSU=;
 b=CBFzT5kjF91tuVXh6tk18+BwSB4Z3A4qWDHvfsYNOmPWpswqSJr6FkuDFw/YBUY9MkyU
 FI9gcX/6gubdvz/GECi6NBXpwFuiZ4i/7K0DJZS3PNEBncRX8ncDfmtu6NtbVwcs04Wf
 oHdR6afwahyVthk7ImJweF5Pz4APqh1taq7clgwiiNOdpwruE4z8xosnhr/phYYWoE/W
 aXVnPUKdStM+mFow06DgtfTCcNvxkzUszJDFB4fRjlpOXmCJDEYwxljuhibCcDlSXWEQ
 mzc8EQtJ92rGDiKvN7wjxbjxsKUN7hMuBOtjDdS+TDpGxJnm3CMWoRg4YozuLPL32MLm Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwu71p9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:14:36 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15T7EapB110846;
        Tue, 29 Jun 2021 03:14:36 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fwu71p95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 03:14:36 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15T7CLD0008795;
        Tue, 29 Jun 2021 07:14:35 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 39duvbuh06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 07:14:35 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15T7EXuq11337996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:14:33 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F52BE0A2;
        Tue, 29 Jun 2021 07:14:33 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D16D3BE079;
        Tue, 29 Jun 2021 07:14:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.45.57])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jun 2021 07:14:27 +0000 (GMT)
Subject: Re: [RFC] fpga: dfl: fme: Fix cpu hotplug code
To:     Moritz Fischer <mdf@kernel.org>
Cc:     will@kernel.org, hao.wu@intel.com, mark.rutland@arm.com,
        trix@redhat.com, yilun.xu@intel.com, luwei.kang@intel.com,
        linux-fpga@vger.kernel.org, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rnsastry@linux.ibm.com
References: <20210628071546.167088-1-kjain@linux.ibm.com>
 <YNoXnHq+nlJhO8o6@epycbox.lan>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <46a6380b-e0c8-00d1-7e31-4bb8bc543438@linux.ibm.com>
Date:   Tue, 29 Jun 2021 12:44:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <YNoXnHq+nlJhO8o6@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QDzXB8eqp-xqzciIykzRLepFr3ZsJO54
X-Proofpoint-ORIG-GUID: WYHhOhBOgZdJkhiL2AYBHQSAecoi0QKa
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_02:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106290050
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/29/21 12:10 AM, Moritz Fischer wrote:
> On Mon, Jun 28, 2021 at 12:45:46PM +0530, Kajol Jain wrote:
>> Commit 724142f8c42a ("fpga: dfl: fme: add performance
>> reporting support") added performance reporting support
>> for FPGA management engine via perf.
>>
>> It also added cpu hotplug feature but it didn't add
>> pmu migration call in cpu offline function.
>> This can create an issue incase the current designated
>> cpu being used to collect fme pmu data got offline,
>> as based on current code we are not migrating fme pmu to
>> new target cpu. Because of that perf will still try to
>> fetch data from that offline cpu and hence we will not
>> get counter data.
>>
>> Patch fixed this issue by adding pmu_migrate_context call
>> in fme_perf_offline_cpu function.
>>
>> Fixes: 724142f8c42a ("fpga: dfl: fme: add performance reporting support")
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> You might want to Cc: stable@vger.kernel.org if it fixes an actual bug.

Hi Moritz,
  I already send patch out without RFC tag yesterday.
Link to the patch: https://lkml.org/lkml/2021/6/28/275

I will cc stable@vger.kernel.org there as suggested by you.

Thanks,
Kajol Jain

>> ---
>>  drivers/fpga/dfl-fme-perf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> ---
>> - This fix patch is not tested (as I don't have required environment).
>>   But issue mentioned in the commit msg can be re-created, by starting any
>>   fme_perf event and while its still running, offline current designated
>>   cpu pointed by cpumask file. Since current code didn't migrating pmu,
>>   perf gonna try getting counts from that offlined cpu and hence we will
>>   not get event data.
>> ---
>> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
>> index 4299145ef347..b9a54583e505 100644
>> --- a/drivers/fpga/dfl-fme-perf.c
>> +++ b/drivers/fpga/dfl-fme-perf.c
>> @@ -953,6 +953,10 @@ static int fme_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  		return 0;
>>  
>>  	priv->cpu = target;
>> +
>> +	/* Migrate fme_perf pmu events to the new target cpu */
>> +	perf_pmu_migrate_context(&priv->pmu, cpu, target);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.31.1
>>
> - Moritz
> 
