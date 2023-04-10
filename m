Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34F6DC29C
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Apr 2023 04:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjDJCRm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Apr 2023 22:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJCRl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Apr 2023 22:17:41 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F8D3C21;
        Sun,  9 Apr 2023 19:17:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx15so2065827ljb.7;
        Sun, 09 Apr 2023 19:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681093057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wf+efalkSkI9mDMxtM/0oFO463/s9uRI1g/ofMKtVDo=;
        b=WUDlFzBq4CMSyM65JP/KVwNhuWO/RvSl+oy866bY0BnNNEASFunHZ+hSDxCSEmW8lD
         E9H63EEimuLNHW8A4CVtaK5W4nINAv27VKeF16TJMA6tT7HEXFgTFRCbdgBFqgS+Wt9T
         g7kKyK22WkrzO8eC1O0jFEH407JspVuyghQUqbvQ0nVMGvAskJRH9lhCf25LWFFAPmxm
         lgPF1US1pVdLAl/jNasKmk2pUs8zJKNphtS4QGGk0M+KdOrfspcLzL9H9pAMI93w8ex7
         OeODgTFbnPy/q8PsUdTjNP43qzWhEhqE3Pa4Qd+INiYWeh6VnfCLIeMRMlIzeefGtEjE
         zUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681093057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wf+efalkSkI9mDMxtM/0oFO463/s9uRI1g/ofMKtVDo=;
        b=7DGvg7jXjcveCK6C89uJGDlvLsxoVoLgZpBh10w0xgzjak9LUrK2o+Qi9HYkl8pFrE
         KtOsqCUzKcitYOD6RprWkwTDi5t9gas6dTtIelVkeXptPNSnpgeDbGhlXFenOgqkd96T
         5PprbTz/X44qIuq9Cwd6Qqd5+Qm7W8zgHYiKmZLvqLpUDIwrMFJ3I3C97NRp+xssifFs
         6LDzvV8eecehor5VVpUwHOmYnQ1Ad9H3jurBhsprZc4ULnj9ZsEgXK1OBWPD1xklrjz2
         RmKGEOIgFHZOQ/84L2WAX5wBXy8DBJLisbmQVKzwUm4RHqiVU7gqUVfmxRoucWwkETbG
         TFeQ==
X-Gm-Message-State: AAQBX9cGSZDP1Uytf1z99EYgF9rvn72LwwquWUneGRqkS7w6ghE3H9PU
        ngsnabrj0HMY02OkqzcE2lAk+AaEX9Ud0nz5K0I=
X-Google-Smtp-Source: AKy350brDVaJMT570wYdSM/EYIYWXwU+EDYTuo8e2Qv81S4dgcFrmPHEYudKemWMtHHarOvKLnR2zIz09Kd9CS+j7gU=
X-Received: by 2002:a2e:93c3:0:b0:29b:ebfa:765d with SMTP id
 p3-20020a2e93c3000000b0029bebfa765dmr2450197ljh.1.1681093057526; Sun, 09 Apr
 2023 19:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230206054326.89323-1-k1rh4.lee@gmail.com> <Y+X+kZResf0a/aES@yilunxu-OptiPlex-7050>
 <ZDMLSOoMt5Ims6xT@eldamar.lan>
In-Reply-To: <ZDMLSOoMt5Ims6xT@eldamar.lan>
From:   sangsup lee <k1rh4.lee@gmail.com>
Date:   Mon, 10 Apr 2023 11:17:01 +0900
Message-ID: <CAJkuJRh4r9bqjfTAdkFgAQ1Az+zt6HuG85d-fWVQXdgmQDW8dQ@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl-afu-region: Add overflow checks for region size
 and offset
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

In my opinion the code has an insecure code pattern.
The size may have integer overflow condition i think.
But, I did  not do dynamic analysis but I did static audit fpga code(I
don't have an fpga device).
because of this.  I don't make sure about Yilun's comment.
I think the code must have defensive coding rules.

best regards.
