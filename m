Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BE74B5934
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 18:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350848AbiBNR5C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 12:57:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346819AbiBNR5C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 12:57:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB5DC0;
        Mon, 14 Feb 2022 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=33ImK9+s2DNm18/WPm+/nato/x7o1dW+u21zFfhAtCk=; b=ND/hdKI3LDDT/z2e9gKkk9zhs4
        /ROR3zW71rhmaEQFD+2sCWP31HFaly6us7wTs53iyfk2IdOupmRfe70YZZYsMfpMDLXk5n6tDbhce
        io2ynx+7g2Vqe1te9r0vTw3KOs8qoObFKkq6VZ+2PSY1rHq+2GkNO3d3f5HXhUOzTWWtQs0NZoqDo
        iCgWK6rHf6SdcS5TJ0aVN2BwdIICDMsHLk0nLdqyxUTr5HN8EVqeNVwzGvFTow3qbQX5g5r2JS9Mo
        redxUj3rBeLZ5JXUyFFYt0RxI8rKHWmu8wHpeMg1M4QQ+TB3+7DHDCXGTEXmkp1lzxpYF7VKqnPjn
        P5FSt3ug==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJfah-009xkG-If; Mon, 14 Feb 2022 17:56:47 +0000
Message-ID: <be378318-2b68-15d3-df89-db5b10ccc8cb@infradead.org>
Date:   Mon, 14 Feb 2022 09:56:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Tianfei zhang <tianfei.zhang@intel.com>
Cc:     corbet@lwn.net, hao.wu@intel.com, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com, yilun.xu@intel.com
References: <20220214112619.219761-2-tianfei.zhang@intel.com>
 <eb5506aa-815d-b373-2eff-a3b9df533141@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <eb5506aa-815d-b373-2eff-a3b9df533141@gmail.com>
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



On 2/14/22 04:18, Akira Yokosawa wrote:
> Hi,
> 
> Just a couple of nits on ReST formatting.
> 

Thanks :)


> 
> I'd recommend running "make htmdocs" and see if the pages are rendered as you
> expect.

I think that's "make htmldocs". But please do use it.

-- 
~Randy
