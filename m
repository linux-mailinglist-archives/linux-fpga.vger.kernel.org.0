Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C44D3C78
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Mar 2022 22:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiCIV5T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Mar 2022 16:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCIV5T (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Mar 2022 16:57:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C011E3DE;
        Wed,  9 Mar 2022 13:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=np/yWaL2SEzbDeedmW1sD91moVYVslUM9GnclnqGYR0=; b=XQZUONtNuJqS6qIBp1kK9rFEP/
        I7aRgAaFTm79ECSAzXh6ErUdkF/XCrph62NI2+SmVBCZeeCa2/k5wWwaoXetSs8ez77os7vLkLrLS
        aS5keUyklEULbOOlfYj29SWYR/upE5lYKMsXspqSQLSLw9k2YK75DXw9lnFk4ei6u4eXEdpxfOJC2
        G4xCxH3IJAh+6GCI9JDluxdErRZzKdBOsuYV0Ws4gZ5Evw+5JMXfUsRWIpooNl3Z++CxExzsWlQaX
        qSBaYC56Y9fpoI5S0ixuy4B8h61ioFTwqRcz9kzcMbuPeVR/ja76pvVINQJAYZLzNQNguYaGldsRu
        4zhXabhA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nS4Hw-00HXMq-Nl; Wed, 09 Mar 2022 21:56:09 +0000
Message-ID: <1e517288-fa06-e02f-ed6d-598a70b349ac@infradead.org>
Date:   Wed, 9 Mar 2022 13:56:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 6/6] Documentation: fpga: dfl: add description of OFS
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com,
        Tianfei zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net
References: <20220307133243.1426300-1-tianfei.zhang@intel.com>
 <20220307133243.1426300-7-tianfei.zhang@intel.com>
 <alpine.DEB.2.22.394.2203091331130.3679111@rhweight-WRK1>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.22.394.2203091331130.3679111@rhweight-WRK1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/9/22 13:54, matthew.gerlach@linux.intel.com wrote:
>> +Open FPGA stack
>> +=====================
>> +
> How about the following minor changes for the first sentence?
> 
> Open FPGA Stack (OFS) is a collection of RTL and open source software providing interfaces to access the instantiated RTL easily in a FPGA.


s/a FPGA/an FPGA/
please.

-- 
~Randy
