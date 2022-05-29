Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB31C5371CE
	for <lists+linux-fpga@lfdr.de>; Sun, 29 May 2022 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiE2Qx3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2Qx1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 12:53:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EDF65D36
        for <linux-fpga@vger.kernel.org>; Sun, 29 May 2022 09:53:27 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e184so6135569ybf.8
        for <linux-fpga@vger.kernel.org>; Sun, 29 May 2022 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=iu0oLUbqAWlHaXBHn+ZkhuE+X3FiWsPMuGFtxOE3t11SKMdV0Q2iZDKfnjTIUk6Vws
         JVVU3ZHr8Gvhv3Ie5KMVZODbbzAaTLirVatbI/CStJPgFPcVJ4A9utVPzpfsxOgCy+D5
         jOuz8GreAa97mXt6cHYCkxKUfFf8RxQjvl68ET1HQKFV9pbMKsAgOptmqf8nOJrMRTS6
         WzhudgK+fPX2V/7eCAZOR4CJ6qs5LtVSIhIIBPyQLBjr22kKuf1AOSMTpiCWQ/yGpnq/
         mOYvL6jkcyXAxCsBsnvRC+S8LIxNjMUbcAz8rZvFbvgv73APd2m7mv9Ob2aUCbbb3tgc
         3LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
        b=FFh/bFc7rYujVBOc/uzp8aBWqkDWvsGl32ptcKH08jJmTWLb3AiTGvMgfs4V++b873
         07m31Qa1qWqw4emEr06OmEejTELy72Bhxv8PO0/a/ZVU8BISO1p3nC6uXF1qxXJDUfRc
         Dj+PEfcCzcPxtTdDFfV39mrb4RA1zuJztOsjW3y7m3b2VLntdjym2FZT6S3/Hne5xqFS
         pc+SkV6C+hcmOMMuLPKtyHHlOwW3aynY1f/IEC2e4fcsYSxIySufQEevk912dblEcjZx
         PdUucWlTlIKwEMBmI2KnFzabUTWNdTf/CGFMU+pxSXb6vWAExbjamQILh9/ikeUiCocX
         5qQA==
X-Gm-Message-State: AOAM532pAq07BEMISp1MbvsojRzp8seMCIqllQM7ltsxVUW7apQ7KVKs
        H66pZ56kXJFqqKWQrdPPUqE5Sl1afKFokmu0C07AzQYpAbA=
X-Google-Smtp-Source: ABdhPJyELuTUEmKJfXQ7DxfPdxcuNPoJ0iUbhAHrtTYo5ZQBSkSRGKf5GzTBLbjrT8I3nwS5ab/LM0kErqiOb+HpG1c=
X-Received: by 2002:a25:5503:0:b0:65c:5bcb:bb83 with SMTP id
 j3-20020a255503000000b0065c5bcbbb83mr8145373ybb.405.1653843206353; Sun, 29
 May 2022 09:53:26 -0700 (PDT)
MIME-Version: 1.0
From:   James Tobin <jamesbtobin@gmail.com>
Date:   Sun, 29 May 2022 17:53:15 +0100
Message-ID: <CAMyPCTQ6x2FwYCa9GzXRwujHhf4AemD6=X6E4sSgeXpcdDF7XA@mail.gmail.com>
Subject: 
To:     linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

subscribe
