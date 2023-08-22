Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F2784E50
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Aug 2023 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjHWBjb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Aug 2023 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjHWBjb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Aug 2023 21:39:31 -0400
X-Greylist: delayed 917 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:39:29 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882EAE46
        for <linux-fpga@vger.kernel.org>; Tue, 22 Aug 2023 18:39:29 -0700 (PDT)
X-AuditID: cb7c291e-06dff70000002aeb-39-64e54ad3ed24
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 20.DA.10987.4DA45E46; Wed, 23 Aug 2023 04:55:00 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=Jxp5Y0vl03LkAw2dOpAkPK3swTZ19f5bIyfzT5PJ9dMOcbd+PgNaNRXNSEtzloD06
          EQRPJornz1Y8xZVyPWvc7YzsB3BhT5hOgTNzziiEgzEX3080tmew2kzAi0TDIO4g+
          q9effBj9O5f0P0fA3erPir8iRHOHB9g5bb8jnjYII=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=bFCu67Y2cIivymknIJmA7cP/uMG1fsqZQEE/NtMoH3c5AGHR0vu/Zwltx2Wi8/pdQ
          g3qtyc2lcqeceh5aV0MysFzl7sDwraZ6RCd0A5KwzbMHvcnnBLcDFxtuGZY7pMhGE
          NQDHJUn1LN4nsAa665gAceLP7VZeDuXXZh0fhEYcI=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:00 +0500
Message-ID: <20.DA.10987.4DA45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-fpga@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:14 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW/eK19MUgxO3eC0ezfzO7sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAisfv5bSCbi0NIYA+T
        RG/PCnYQh0VgNbPEhr/rwapYBB4yS1yZ5gVR1cwoMXv7akaQBK+AtUR37y52EJtZQE/ixtQp
        bBBxQYmTM5+wQMS1JZYtfM3cxcgBZKtJfO0qAQkLC4hJfJq2DKxVREBOouHLL7BdbAL6Eiu+
        NjNC7FWVWLfhJpgtJCAlsfHKerYJjPyzkGybhWTbLCTbZiFsW8DIsopRorgyNxEYaskmesn5
        ucWJJcV6eaklegXZmxiBYXi6RlNuB+PSS4mHGAU4GJV4eH+ue5IixJpYBtR1iFGCg1lJhFf6
        +8MUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry2Qs+ShQTSE0tSs1NTC1KLYLJMHJxSDYz1L6tu
        JAVdzk5+or1JrTV/ykmVAxP/xi3v3xjkv2pH3EodMxYXMyH3lBcrfqYuW9q0e2pP+24vmQrB
        RzPkqz4bRf1Sd14ZvOQB26Kz7Zd2ZdxX1bq177nwN8HGSwnsTdfCt578mxwjIrmoTqNxHadI
        3q7nPSyXzU3vbp1UfHiPstJtNxs5j0IlluKMREMt5qLiRADY4vciPwIAAA==
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

